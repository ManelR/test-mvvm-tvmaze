//
//  TVMazeApiManagerType.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

protocol TVMazeApiManagerType {
    func getShows(page: Int, completion: @escaping (HTTPResult<ShowsDomain,Data>) -> Void)
}
