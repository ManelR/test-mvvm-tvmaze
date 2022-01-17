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
    case detail
}

class DefaultShowListSceneRouter: ShowListSceneRouter {
    weak var context: UIViewController?
    
    func route(to route: ShowListSceneRoute, parameters: Any?...) {
        
        switch route {
        case .detail:
            let detailsVC = ShowDetailsSceneViewController.instantiateViewController()
            if let show = parameters[0] as? ShowDomain {
                detailsVC.setShow(show: show)
            }
            
            self.route(next: detailsVC)
        }
    }
}
