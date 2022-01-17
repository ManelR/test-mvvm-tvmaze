//
//  ShowsResponse.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

typealias ShowsResponse = [Shows]

// MARK: - WelcomeElement
struct Shows: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let genres: [String]?
    let rating: Rating?
    let image: Image?
    let summary: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}
