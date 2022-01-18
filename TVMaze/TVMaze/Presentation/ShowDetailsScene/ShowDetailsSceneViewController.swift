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
    @IBOutlet var imgShow: UIImageView!
    @IBOutlet var lblShowSummary: UILabel!
    
    @IBOutlet var imgRating1: UIImageView!
    @IBOutlet var imgRating2: UIImageView!
    @IBOutlet var imgRating3: UIImageView!
    @IBOutlet var imgRating4: UIImageView!
    @IBOutlet var imgRating5: UIImageView!
    
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
            self.viewModel.showImage.sink {
                if let imageURL = $0 {
                    self.imgShow.downloaded(from: imageURL)
                }
            },
            self.viewModel.showSummary.assign(to: \.attributedText, on: self.lblShowSummary),
            self.viewModel.showRating.sink { self.configRating(rating: $0) }
        ]
    }
    
    func configView() {
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.lblShowSummary.font = font
    }
    
    func configRating(rating tmp: Double?) {
        let rating = tmp ?? 0
        self.imgRating1.image = self.getRatingImage(rating, 0)
        self.imgRating2.image = self.getRatingImage(rating, 1)
        self.imgRating3.image = self.getRatingImage(rating, 2)
        self.imgRating4.image = self.getRatingImage(rating, 3)
        self.imgRating5.image = self.getRatingImage(rating, 4)
    }
    
    internal func getRatingImage(_ rating: Double, _ position: Int) -> UIImage? {
        let value = rating / 10 * 5
        let positionDouble = Double(position)
        if value - positionDouble <= 0 {
            return UIImage(named: "outline_star_outline")
        } else if value - positionDouble < 1 {
            return UIImage(named: "outline_star_half")
        } else {
            return UIImage(named: "outline_star")
        }
    }
    
    // MARK: - ACTIONS
    
}

// Setters

extension ShowDetailsSceneViewController {
    public func setShow(show: ShowDomain) {
        self.viewModel.setShow(show: show)
    }
}
