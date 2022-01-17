//  
//  ShowDetailsSceneViewController.swift
//  TVMaze
//
//  Created by Manel Roca on 18/1/22.
//

import Foundation
import UIKit
import Combine

class ShowDetailsSceneViewController: UIViewController, ViewControllerType, StoryboardInstantiable {
    // MARK: - IBOUTLETS
    
    
    // MARK: - VARs
    private var subscriptions: Set<AnyCancellable> = []
    
    internal var router = DefaultShowDetailsSceneRouter()
    internal var viewModel = DefaultShowDetailsSceneViewModel()
    
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
            self.viewModel.showTitle.assign(to: \.title, on: self),
        ]
    }
    
    // MARK: - ACTIONS
    
}

// Setters

extension ShowDetailsSceneViewController {
    public func setShow(show: ShowDomain) {
        self.viewModel.setShow(show: show)
    }
}
