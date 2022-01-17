//
//  Endpoints.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

class Endpoints {
    private let TVMAZE_API = "https://api.tvmaze.com/"
    
    func api(path: String) -> String {
        return TVMAZE_API + path
    }
}
