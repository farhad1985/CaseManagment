//
//  FullImageVc.swift
//  OKala
//
//  Created by Mojgan Jelodar on 1/24/18.
//  Copyright © 2018 Mo. All rights reserved.
//

import UIKit

class FullImageVc: UIViewController
{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwHeader: UIView!
        {
        didSet
        {
            self.vwHeader.backgroundColor = CaseTheme.FullImage.Color.backroundColor
        }
    }
    
    var path : UIImage!
    
    @IBOutlet weak var lblTitle: UILabel!
        {
        didSet
        {
            self.lblTitle.textColor = CaseTheme.FullImage.Color.white
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = CaseTheme.FullImage.Color.backroundColor
        self.imgView.image = path//UIImage(contentsOfFile: path)
        self.lblTitle.text = "نمایش تصویر" //Message.caseManagement.rawValue
        self.lblTitle.font = CaseTheme.Font.font
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FullImageVc
{
    static func newInstance()->FullImageVc{
        let bundel = Bundle(for: self)
        let vc = UIStoryboard(name: "CaseManagement", bundle: bundel).instantiateViewController(withIdentifier: "FullImageVc") as? FullImageVc
        return vc!
    }
    static var storyboardName: String
    {
        return "CaseManagment"
    }
    
    static var storyboardIdentifier: String? {
        
        return String(describing: self)
    }
    
}

