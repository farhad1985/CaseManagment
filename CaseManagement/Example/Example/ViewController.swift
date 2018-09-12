//
//  ViewController.swift
//  Example
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit
import CaseManagement

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        CaseManagementService.getToken()
        CaseManagementService.getSubTypes(1) { (result) in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func aa(_ sender: Any) {
        let main = MainVC.initail(title: "Case management", service: CaseService())!
        
        self.show(main, sender: nil)
    }
}
