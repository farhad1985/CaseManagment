//
//  CasePickerView.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class CasePickerView: TextFiledCM {
    
    let pickerView = UIPickerView()
    var dataSource: [CaseRequest] = []
    var selectCase: CaseRequest?
    
    
    var onChange: ((CaseRequest) -> ())?
    
    
    
    override func config() {
        super.config()
        pickerView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputView = pickerView
        setupToolBar()
    }
    
    func setDataSource(dataSource: [CaseRequest] ) {
        self.dataSource = dataSource
        pickerView.reloadAllComponents()
    }
    
    private func setupToolBar() {
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let buttonOK = UIBarButtonItem(title: "انتخاب", style: .done, target: self, action: #selector(selectItem))
        
        buttonOK.setTitleTextAttributes([NSAttributedStringKey.font : CaseTheme.Font.font], for: .normal)
        buttonOK.setTitleTextAttributes([NSAttributedStringKey.font : CaseTheme.Font.font], for: .highlighted)

        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([flex, buttonOK], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc
    func selectItem(){
        guard let selectedCase = self.selectCase else {return}
        onChange?(selectedCase)
    }
}

extension CasePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = CaseTheme.Font.font
        
        label.text = self.dataSource[row].title
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectCase = self.dataSource[row]
    }
}
