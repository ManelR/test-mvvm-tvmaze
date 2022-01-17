//
//  TVMazeApiManager.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

class DefaultTVMazeApiManager: TVMazeApiManagerType {
    func getShows(page: Int, completion: @escaping (HTTPResult<ShowsDomain,Data>) -> Void) {
        let api = DefaultApiManager.shared
        let path = "shows?page=\(page)"
        api.get(url: Endpoints().api(path: path)) { result in
            switch result {
            case let .success(data):
                // Decode json
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(ShowsResponse.self, from: data) {
                        let showsDomain = self.convertShowsResponseIntoDomain(decodedResponse)
                        completion(.success(showsDomain))
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

extension DefaultTVMazeApiManager {
    internal func convertShowsResponseIntoDomain(_ input: ShowsResponse) -> ShowsDomain {
        return input.map { ShowDomain(title: $0.name,
                                       rating: $0.rating?.average,
                                       imageURL: $0.image?.medium ?? $0.image?.original,
                                       summary: $0.summary) }
    }
}
