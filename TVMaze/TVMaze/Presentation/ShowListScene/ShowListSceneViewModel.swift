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
    var showsList: Published<ShowsDomain>.Publisher { get }
}

// PROTOCOL COMPOSITION
protocol ShowListSceneViewModel: ViewModelType, ShowListSceneViewModelInput, ShowListSceneViewModelOutput {}

// DEFAULT MODEL IMPLEMENTATION
class DefaultShowListSceneViewModel: NSObject, ShowListSceneViewModel {
    weak var router: DefaultShowListSceneRouter?
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - OUTPUT IMPLEMENTATION
    @Published var _showsList: ShowsDomain = []
    var showsList: Published<ShowsDomain>.Publisher { $_showsList }
}

// MARK: - INPUT IMPLEMENTATION

extension DefaultShowListSceneViewModel {
    func viewDidLoad() {
        let manager = DefaultTVMazeApiManager()
        manager.getShows(page: 1) { result in
            switch result {
            case let .success(result):
                if let result = result {
                    self._showsList = result
                }
            case let .failure(_, error, _, _):
                print("OK")
            }
        }
    }
}
