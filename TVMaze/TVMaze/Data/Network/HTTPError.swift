//
//  HTTPError.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import UIKit

public enum HTTPError: Error {
    // Server Error
    case serverError
    // Client Error
    case clientError
    case noInternet
    case timeout
    // Other
    case JSONParseError
    case responseModelNotConformsDecodable
    case createRequest
    case unknownError
}

