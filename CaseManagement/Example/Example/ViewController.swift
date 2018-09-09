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
      
    }

    @IBAction func aa(_ sender: Any) {
        let main = MainVC.initail(title: "Case management", service: Service())!
        
        self.show(main, sender: nil)
    }
}

class Service: CaseManagementProtocol {
    func save() {
        
    }
    
    func getCaseItems() -> [CaseItem] {
        var caseItems: [CaseItem] = []
        caseItems.append(CaseItem(id: 1,
                                  title: "Question1",
                                  partsCast: [CaseItem(id: 0,
                                                       title: "Ask1"),
                                              CaseItem(id: 1,
                                                       title: "Ask2")]))
        caseItems.append(CaseItem(id: 2,
                                  title: "Question2",
                                  partsCast: [CaseItem(id: 0,
                                                       title: "Ask3"),
                                              CaseItem(id: 1,
                                                       title: "Ask4")]))
        
        caseItems.append(CaseItem(id: 3,
                                  title: "Question3",
                                  partsCast: [CaseItem(id: 0,
                                                       title: "Ask5"),
                                              CaseItem(id: 1,
                                                       title: "Ask6")]))
        return caseItems
    }
    
    
}
