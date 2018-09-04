//
//  CaseView.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class CaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        config()
    }
    
    func config(){
        layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        layer.borderWidth  = 1
        self.layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
