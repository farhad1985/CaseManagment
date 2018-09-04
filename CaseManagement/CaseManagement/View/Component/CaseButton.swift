//
//  CaseButton.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class CaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        config()
    }
    
    func config(){
        self.titleLabel?.font = CaseTheme.Font.font
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
