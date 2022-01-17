//
//  DefaultApiManager.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

class DefaultApiManager: ApiManagerType {
    
    public static let shared = DefaultApiManager()
    
    public func get(url: String, completion: @escaping (HTTPResult<Data,Data>) -> Void) {
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            _ = self.makeRequest(request: request, completion: completion)
            return
        }
        
        completion(.failure(nil, .createRequest, 0, nil))
    }
}

// HELPER
extension DefaultApiManager {
    internal func getSession() -> URLSession {
        return URLSession.shared
    }
    
    internal func callCompletionHandlerInMainThread<T,E>(result: HTTPResult<T,E>, completion: @escaping (HTTPResult<T,E>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    internal func makeRequest(request tmpRequest: URLRequest, completion: @escaping (HTTPResult<Data,Data>) -> Void) -> URLSessionDataTask {
        let session = self.getSession()
        var request = tmpRequest
        print("makeRequest - \(request.httpMethod ?? "?") - \(request.url?.absoluteString ?? "?")")
        print("makeRequest - HEADERS: \n\(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody {
            let bodyString = String(decoding: body, as: UTF8.self)
            print("makeRequest - BODY: \(bodyString)")
        }
        
        let dataTask = session.dataTask(with: request) { [weak self] data, urlResponse, error in
            var body = ""
            let status = (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
            
            if let httpResponse = urlResponse as? HTTPURLResponse,
               let date = httpResponse.value(forHTTPHeaderField: "Date") {
                print("RESPONSE \(status) - DATE: \(date)")
            }
            
            if let data = data {
                body = String(decoding: data, as: UTF8.self)
                print("RESPONSE \(status) - BODY: \(body)")
            }
            
            if let error = error {
                // Client error
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    if error.code == NSURLErrorNotConnectedToInternet {
                        self?.callCompletionHandlerInMainThread(result: .failure(data, .noInternet, status, body), completion: completion)
                        return
                    } else if error.code == NSURLErrorTimedOut {
                        self?.callCompletionHandlerInMainThread(result: .failure(data, .timeout, status, body), completion: completion)
                        return
                    }
                }
                self?.callCompletionHandlerInMainThread(result: .failure(data, .clientError, status, body), completion: completion)
                return
            } else {
                guard let httpResponse = urlResponse as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    // Server error
                    self?.callCompletionHandlerInMainThread(result: .failure(data, .serverError, status, body), completion: completion)
                    return
                }
                
                self?.callCompletionHandlerInMainThread(result: .success(data), completion: completion)
                return
            }
        }
        
        dataTask.resume()
        return dataTask
    }
}
