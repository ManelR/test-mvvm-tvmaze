//  
//  ShowDetailsSceneViewModel.swift
//  TVMaze
//
//  Created by Manel Roca on 18/1/22.
//

import Foundation
import Combine

// INPUT DEFINITION
protocol ShowDetailsSceneViewModelInput {
    func viewDidLoad()
    func setShow(show: ShowDomain)
}

// OUTPUT DEFINITION
protocol ShowDetailsSceneViewModelOutput {
    var showTitle: Published<String?>.Publisher { get }
    var showImage: Published<String?>.Publisher { get }
}

// PROTOCOL COMPOSITION
protocol ShowDetailsSceneViewModel: ViewModelType, ShowDetailsSceneViewModelInput, ShowDetailsSceneViewModelOutput {}

// DEFAULT MODEL IMPLEMENTATION
class DefaultShowDetailsSceneViewModel: ShowDetailsSceneViewModel {
    weak var router: DefaultShowDetailsSceneRouter?
    var subscriptions = Set<AnyCancellable>()
    
    internal var show: ShowDomain?
    
    // MARK: - OUTPUT IMPLEMENTATION
    @Published var _showTitle: String?
    var showTitle: Published<String?>.Publisher { $_showTitle }
    @Published var _showImage: String?
    var showImage: Published<String?>.Publisher { $_showImage }
    @Published var _showSummary: String?
    var showSummary: Published<String?>.Publisher { $_showSummary }
}

// MARK: - INPUT IMPLEMENTATION

extension DefaultShowDetailsSceneViewModel {
    func viewDidLoad() {
        if let show = self.show {
            self._showTitle = show.title
            self._showImage = show.imageURL
            self._showSummary = show.summary
        }
    }
    
    func setShow(show: ShowDomain) {
        self.show = show
    }
}
