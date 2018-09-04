//
//  Extensions.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation
extension UIView {
    
    func addCornerRadius(radius:CGFloat)
    {
        self.clipsToBounds = true;
        self.layer.cornerRadius = CGFloat(radius);
        
    }
    
    func addCornerRadius(radius:CGFloat,inset : UIEdgeInsets)
    {
        let padding = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.layer.frame = UIEdgeInsetsInsetRect(bounds, padding)
        self.layer.cornerRadius = CGFloat(radius);
    }
    

    func addBorder(color: UIColor = UIColor.white, thickness: CGFloat = 1.0)
    {
        self.layer.borderColor = color.cgColor;
        self.layer.borderWidth = thickness;
    }
}
extension URL {
    func getQueryStringParameter(param: String) -> String? {
        guard let urlComponents = NSURLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems else {
                return nil
        }
        return queryItems.first(where: { $0.name == param })?.value
    }
}
