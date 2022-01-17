//  
//  ShowListSceneRouter.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import UIKit

protocol ShowListSceneRouter : RouterType {
    
}

// Routes from Login
enum ShowListSceneRoute: String {
    case foo
}

class DefaultShowListSceneRouter: ShowListSceneRouter {
    weak var context: UIViewController?
    
    func route(to route: ShowListSceneRoute, parameters: Any?...) {
        
        switch route {
        case .foo:
            // TODO:
            print("Go to foo")
        }
    }
}
