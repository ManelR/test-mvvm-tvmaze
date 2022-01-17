//  
//  ShowListSceneViewModel.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import Combine

// INPUT DEFINITION
protocol ShowListSceneViewModelInput {
    func viewDidLoad()
}

// OUTPUT DEFINITION
protocol ShowListSceneViewModelOutput {
    
}

// PROTOCOL COMPOSITION
protocol ShowListSceneViewModel: ViewModelType, ShowListSceneViewModelInput, ShowListSceneViewModelOutput {}

// DEFAULT MODEL IMPLEMENTATION
class DefaultShowListSceneViewModel: ShowListSceneViewModel {
    weak var router: DefaultShowListSceneRouter?
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - OUTPUT IMPLEMENTATION

}

// MARK: - INPUT IMPLEMENTATION

extension DefaultShowListSceneViewModel {
    func viewDidLoad() {
        // TODO:
    }
}
