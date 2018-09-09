//
//  VoiceView.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

class VoiceView: UIView, Connectable {
    
    @IBOutlet weak var btnRecorder: CaseButton!
    
    @IBOutlet weak var imgPause: UIImageView!
    @IBOutlet weak var imgGif: UIImageView!
    
    var onRecord: ((Bool) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    @IBAction func didTapRecord(_ sender: Any) {
        btnRecorder.isHidden = true
        imgGif.isHidden = false
        imgPause.isHidden = false
        onRecord?(true)
    }
    
    func setup() {
        commit()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.imgGif.loadGif(bundle: getBundle(), asset: "voice")
    }
    
    func stop() {
        btnRecorder.isHidden = false
        imgGif.isHidden = true
        imgPause.isHidden = true
        onRecord?(false)
    }

}
