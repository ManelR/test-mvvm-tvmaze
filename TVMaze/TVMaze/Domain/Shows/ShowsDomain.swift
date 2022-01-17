//
//  ShowsDomain.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

typealias ShowsDomain = [ShowDomain]

struct ShowDomain {
    let title: String?
    let rating: Double?
    let imageURL: String?
    let summary: String?
}
