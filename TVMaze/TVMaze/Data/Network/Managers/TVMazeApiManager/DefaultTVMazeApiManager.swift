//
//  TVMazeApiManager.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

class DefaultTVMazeApiManager: TVMazeApiManagerType {
    func getShows(page: Int, completion: @escaping (HTTPResult<ShowsResponse,Data>) -> Void) {
        let api = DefaultApiManager.shared
        let path = "shows?page=\(page)"
        api.get(url: Endpoints().api(path: path)) { result in
            switch result {
            case let .success(data):
                // Decode json
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(ShowsResponse.self, from: data) {
                        completion(.success(decodedResponse))
                        return
                    } else {
                        let body = String(decoding: data, as: UTF8.self)
                        completion(.failure(data, .JSONParseError, 0, body))
                        return
                    }
                } else {
                    completion(.success(nil))
                }
            case let .failure(errorData, error, status, body):
                completion(.failure(errorData, error, status, body))
            }
        }
    }
}
