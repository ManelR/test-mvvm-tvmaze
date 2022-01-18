//  
//  ShowDetailsSceneViewModel.swift
//  TVMaze
//
//  Created by Manel Roca on 18/1/22.
//

import Foundation
import Combine
import UIKit.UIColor

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
    @Published var _showSummary: NSAttributedString?
    var showSummary: Published<NSAttributedString?>.Publisher { $_showSummary }
}

// MARK: - INPUT IMPLEMENTATION

extension DefaultShowDetailsSceneViewModel {
    func viewDidLoad() {
        self.configModel()
    }
    
    func setShow(show: ShowDomain) {
        self.show = show
    }
}

extension DefaultShowDetailsSceneViewModel {
    internal func configModel() {
        if let show = self.show {
            self._showTitle = show.title
            self._showImage = show.imageURL
            if let summary = show.summary?.htmlToAttributedString {
                let mutableSummary = NSMutableAttributedString(attributedString: summary)
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(red: 60/255, green: 148/255, blue: 139/255, alpha: 1.0),
                                                                 ]
                mutableSummary.addAttributes(attributes, range: NSMakeRange(0, mutableSummary.length))
                self._showSummary = mutableSummary
            }
            
        }
    }
}
