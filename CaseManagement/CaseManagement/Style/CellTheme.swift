//
//  CellTheme.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

public extension CaseTheme {
    
    public struct Cell {
        struct Color {
          public  static var statusColor = UIColor.blue
          public  static var lableColor = UIColor.red
          public  static var attachmentColor = UIColor.black
          public  static var successState = UIColor.green
          public  static var wrongState = UIColor.red
          public  static var progressState = UIColor.yellow
            
        }
    }
    public struct FullImage {
       public struct Color {
          public  static var backroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          public  static var white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
}
