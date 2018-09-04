//
//  CaseTheme.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

public final class CaseTheme {
    
    public struct Font {
        public static var font: UIFont = UIFont.systemFont(ofSize: 15)
        
        public static func setFont(font: UIFont) {
            self.font = font
        }
    }
}
