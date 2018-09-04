//
//  CaseTextView.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class CaseTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
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
        self.layer.cornerRadius = 7
        layer.masksToBounds = true
    }
}
