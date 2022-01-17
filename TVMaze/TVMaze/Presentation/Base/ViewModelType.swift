//
//  ViewModelType.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation

protocol ViewModelType: AnyObject {
    associatedtype RouterImplementation: RouterType
    
    var router: RouterImplementation? { get set } //weak
}
