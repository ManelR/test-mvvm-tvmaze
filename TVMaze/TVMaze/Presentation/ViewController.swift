//
//  ViewController.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = DefaultApiManager()
        api.get(url: Endpoints().api(path: "shows?page=1")) { result in
            print("OK")
        }
    }


}

