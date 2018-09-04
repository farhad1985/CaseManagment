//
//  Connectable.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

protocol Connectable {}

extension Connectable where Self: UIView {
    func commit() {
        let bundle = Bundle(for: Self.self)

        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let view = views.first as? UIView else {return}
        view.frame = bounds
        addSubview(view)
    }
    
    func getBundle() -> Bundle {
        return Bundle(for: Self.self)
    }
}
