//
//  HTTPResult.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

public enum HTTPResult<T, U> {
    case success(T?)
    case failure(U?, HTTPError, Int, String?)
}
