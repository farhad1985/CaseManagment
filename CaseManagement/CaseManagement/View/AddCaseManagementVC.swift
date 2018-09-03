//
//  AddCaseManagementVC.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

public class AddCaseManagementVC: UIViewController {
    
    @IBOutlet weak var caseTextField: CasePickerView!
    @IBOutlet weak var partTextField: CasePickerView!
    
    private var castRequests: [CaseRequest] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        caseTextField.setDataSource(dataSource: castRequests)
        
        caseTextField.onChange = { caseRequest in
            self.partTextField.setDataSource(dataSource: caseRequest.partsCast)
            self.dismissKeyboard()
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func setDataSource(castRequests: [CaseRequest]) {
        self.castRequests = castRequests
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
}

public extension AddCaseManagementVC {
    public static func create() -> AddCaseManagementVC?{
        let bundle = Bundle(for: self)
        let story = UIStoryboard(name: "CaseManagement", bundle: bundle)
        return story.instantiateViewController(withIdentifier: "AddCaseManagementVC") as? AddCaseManagementVC
    }
}

