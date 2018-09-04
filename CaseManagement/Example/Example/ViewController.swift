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
                                     title: "Question1",
                                     partsCast: [CaseRequest(id: 0,
                                                                 title: "Ask1"),
                                                 CaseRequest(id: 1,
                                                                 title: "Ask2")]))
        caseItems.append(CaseRequest(id: 2,
                        title: "Question2",
                        partsCast: [CaseRequest(id: 0,
                                                title: "Ask3"),
                                    CaseRequest(id: 1,
                                                title: "Ask4")]))
        
        caseItems.append(CaseRequest(id: 3,
                                     title: "Question3",
                                     partsCast: [CaseRequest(id: 0,
                                                             title: "Ask5"),
                                                 CaseRequest(id: 1,
                                                             title: "Ask6")]))

        vc?.setDataSource(castRequests: caseItems)

    }

    @IBAction func aa(_ sender: Any) {
        self.present(vc!, animated: true, completion: nil)
    }
}

