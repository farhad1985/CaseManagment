//
//  TextFiledCM.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class TextFiledCM: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        config()
    }
    
    func config(){
        self.font = CaseTheme.Font.font
        layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
        layer.borderWidth  = 1
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
