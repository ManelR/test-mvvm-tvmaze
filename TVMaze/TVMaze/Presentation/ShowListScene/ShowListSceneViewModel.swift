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
    func didSelectRowAt(_ indexPath: IndexPath)
    func didDisplayLastCell()
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
    internal var subscriptions = Set<AnyCancellable>()
    
    internal let manager = DefaultTVMazeApiManager()
    internal var allElementsFetched = false
    internal var currentPage = 1
    internal var isLoadingData = false
    
    // MARK: - OUTPUT IMPLEMENTATION
    @Published var _showsList: ShowsDomain = []
    var showsList: Published<ShowsDomain>.Publisher { $_showsList }
}

// MARK: - INPUT IMPLEMENTATION

extension DefaultShowListSceneViewModel {
    func viewDidLoad() {
        self.currentPage = 1
        self.loadShows()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        self.router?.route(to: .detail, parameters: self._showsList[indexPath.row])
    }
    
    func didDisplayLastCell() {
        guard !allElementsFetched, !isLoadingData else {
            return
        }
        
        self.currentPage += 1
        self.loadShows()
    }
}

extension DefaultShowListSceneViewModel {
    internal func loadShows() {
        self.isLoadingData = true
        
        self.manager.getShows(page: currentPage) { result in
            switch result {
            case let .success(result):
                if let result = result {
                    self._showsList.append(contentsOf: result)
                } else {
                    self.allElementsFetched = true
                }
                self.isLoadingData = false
            case let .failure(_, error, _, _):
                print("OK")
                self.isLoadingData = false
                // TODO:
            }
        }
    }
}
