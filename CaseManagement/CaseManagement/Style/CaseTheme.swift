//
//  CaseTheme.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

public final class CaseTheme {
    
    struct Font {
        static var font: UIFont = UIFont.systemFont(ofSize: 15)
        
        static func setFont(font: UIFont) {
            self.font = font
        }
    }
}
