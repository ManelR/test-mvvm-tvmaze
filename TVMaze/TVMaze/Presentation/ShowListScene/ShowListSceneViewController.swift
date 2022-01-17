//  
//  ShowListSceneViewController.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import UIKit
import Combine

class ShowListSceneViewController: UIViewController, ViewControllerType, StoryboardInstantiable {
    // MARK: - IBOUTLETS
    
    
    // MARK: - VARs
    private var subscriptions: Set<AnyCancellable> = []
    
    internal var router = DefaultShowListSceneRouter()
    internal var viewModel = DefaultShowListSceneViewModel()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.linkModelAndRouter()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.linkModelAndRouter()
    }
    
    // MARK: - CLASS IMPLEMENTATION
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.viewModel.viewDidLoad()
    }
    
    func bind() {
        subscriptions = [
            // TODO:
            // Ex: self.viewModel.backgroundColor.assign(to: \.backgroundColor, on: self.view)
        ]
    }
    
    // MARK: - ACTIONS
    
}
