//
//  ShowsResponse.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

typealias ShowsResponse = [ShowResponse]

// MARK: - WelcomeElement
struct ShowResponse: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let genres: [String]?
    let rating: ShowRatingResponse?
    let image: ShowImageResponse?
    let summary: String?
}

// MARK: - Image
struct ShowImageResponse: Codable {
    let medium, original: String?
}

// MARK: - Rating
struct ShowRatingResponse: Codable {
    let average: Double?
}
