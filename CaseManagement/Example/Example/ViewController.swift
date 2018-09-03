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

    var caseItems: [CaseRequest] = []
    let vc = AddCaseManagementVC.create()

    override func viewDidLoad() {
        super.viewDidLoad()

        caseItems.append(CaseRequest(id: 1,
                                     title: "Question",
                                     partsCast: [CaseRequest(id: 0,
                                                                 title: "Ask1"),
                                                 CaseRequest(id: 1,
                                                                 title: "Ask2")]))
        
        vc?.setDataSource(castRequests: caseItems)

    }

    @IBAction func aa(_ sender: Any) {
        self.present(vc!, animated: true, completion: nil)
    }
}

