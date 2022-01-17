//
//  ViewController.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let manager = DefaultTVMazeApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.getShows(page: 1) { result in
            switch result {
            case let .success(shows):
                print("OK")
            case let .failure(_, error, _, _):
                print("KO")
            }
        }
    }


}

