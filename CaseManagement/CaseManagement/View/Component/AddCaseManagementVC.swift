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
    
    var defaultCase: CaseRequest?
    var defaultPartCase: CaseRequest?

    private var castRequests: [CaseRequest] = []
    private var caseSelected: CaseRequest?
    private var partCaseSelected: CaseRequest?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        handleOnChanges()
        setDefaultCases()
    }
    
    private func handleOnChanges() {
        caseTextField.onChange = { caseRequest in
            self.partTextField.setDataSource(dataSource: caseRequest.partsCast)
            self.caseSelected = caseRequest
            self.dismissKeyboard()
        }
        
        partTextField.onChange = { partCaseRequest in
            self.partCaseSelected = partCaseRequest
            self.dismissKeyboard()
        }
    }
    
    private func setDefaultCases() {
        if let dCase = defaultCase {
            caseTextField.setDataSource(dataSource: castRequests, defaultCase: dCase)
        } else {
            caseTextField.setDataSource(dataSource: castRequests)
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func setDataSource(castRequests: [CaseRequest], defaultCase: CaseRequest? = nil) {
        self.castRequests = castRequests
        self.defaultCase = defaultCase
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

