//  
//  ShowDetailsSceneRouter.swift
//  TVMaze
//
//  Created by Manel Roca on 18/1/22.
//

import Foundation
import UIKit

protocol ShowDetailsSceneRouter : RouterType {
    
}

// Routes from Login
enum ShowDetailsSceneRoute: String {
    case foo
}

class DefaultShowDetailsSceneRouter: ShowDetailsSceneRouter {
    weak var context: UIViewController?
    
    func route(to route: ShowDetailsSceneRoute, parameters: Any?...) {
        
        switch route {
        case .foo:
            // TODO:
            print("Go to foo")
        }
    }
}
