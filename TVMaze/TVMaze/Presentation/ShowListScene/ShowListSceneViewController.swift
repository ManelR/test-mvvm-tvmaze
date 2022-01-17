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
    @IBOutlet var tableView: UITableView!
    
    // MARK: - VARs
    private var subscriptions: Set<AnyCancellable> = []
    private var cellIdentifier = "showsCell"
    private var tableViewElements: ShowsDomain = []
    
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
        self.configView()
    }
    
    func bind() {
        subscriptions = [
            self.viewModel.showsList.sink { value in
                self.tableViewElements = value
                self.tableView.reloadData()
            }
        ]
    }
    
    // MARK: - ACTIONS
    
    // MARK: - HELPERS
    internal func configView() {
        self.configTitle()
        self.configTableView()
    }
    
    internal func configTitle() {
        self.title = "TV Maze"
    }
    
    internal func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ShowListSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableViewElements.count >= indexPath.row else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        let show = tableViewElements[indexPath.row]
        var cell : UITableViewCell!
        
        cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = show.title
        
        return cell
    }
    
    
}
