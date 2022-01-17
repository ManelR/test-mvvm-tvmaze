//
//  ViewControllerType.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import UIKit
import Combine

protocol ViewControllerType: AnyObject {
    associatedtype ViewModelImplementation: ViewModelType
    
    var router: ViewModelImplementation.RouterImplementation { get set }
    var viewModel: ViewModelImplementation { get set }
    
    func linkModelAndRouter()
}

extension ViewControllerType where Self: UIViewController {

    func linkModelAndRouter() {
        self.router.context = self
        self.viewModel.router = self.router
    }
}
