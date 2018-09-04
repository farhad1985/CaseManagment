//
//  CaseCell.swift
//  OKala
//
//  Created by Mojgan Jelodar on 12/30/17.
//  Copyright © 2017 Mo. All rights reserved.
//

import UIKit


protocol CaseCellDelegate
{
    func showImage(_ cell : CaseCell);
    func playSound(_ cell : CaseCell);

}

final class CaseCell: UITableViewCell
{
    @IBOutlet weak var vwStatus: UIView!
    @IBOutlet weak var lblDate: UILabel!
     @IBOutlet weak var lblCaptionStatus: UILabel!
    @IBOutlet weak var lblTracking: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblResponseDate: UILabel!
    @IBOutlet weak var lblResponse: UILabel!
    @IBOutlet weak var indicatorAudio: UIActivityIndicatorView!
    @IBOutlet weak var lblAudioProgress: UILabel!
    @IBOutlet weak var btnPlayAudio: UIButton!
    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var btnAttachment: UIButton!
    @IBOutlet weak var vwAudio: UIView!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var vwAnswer: UIView!
    var delegate : CaseCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    @IBAction func play(_ sender: Any)
    {
        self.delegate.playSound(self)
    }

    @IBAction func showImage(_ sender: UIButton)
    {
        self.delegate.showImage(self)
    }

    func configCell(caseItem : Case,delegate :CaseCellDelegate)
    {
        self.delegate = delegate
        self.lblState.text = caseItem.statusName
        self.lblDate.text = caseItem.requestDateTime
        self.lblTitle.text = caseItem.description ?? ""
        self.lblResponse.text = caseItem.response ?? ""
        self.lblTracking.text = caseItem.trackingCode
        self.lblSubject.text = caseItem.requestCategoryName
        self.vwAnswer.isHidden = (caseItem.response == nil || (caseItem.response?.isEmpty)!) ? true : false
        self.vwAnswer.isHidden = (caseItem.response == nil || (caseItem.response?.isEmpty)!) ? true : false
        self.vwAudio.isHidden = caseItem.getAudioFile() == nil ? true : false
        self.vwImage.isHidden = caseItem.getImageFile() == nil ? true : false
        
        setStateTheme(case: caseItem)
    }
    
    func setStateTheme(case caseItem: Case){
        switch caseItem.statusCode {
        case 1:
            let color = CaseTheme.Cell.Color.successState
            self.vwStatus.addBorder(color: color, thickness: 1)
            self.lblCaptionStatus.textColor = color
            self.lblState.textColor = color
            self.lblTracking.textColor = color
            self.lblResponseDate.isHidden = true
        case 6:
            let color = CaseTheme.Cell.Color.wrongState
            self.vwStatus.addBorder(color: color, thickness: 1)
            self.lblCaptionStatus.textColor = color
            self.lblState.textColor = color
            self.lblTracking.textColor = color
            self.lblResponseDate.isHidden = true
        case 5:
            let color = CaseTheme.Cell.Color.progressState
            self.vwStatus.addBorder(color: color, thickness: 1)
            self.lblState.textColor = color
            self.lblCaptionStatus.textColor = color
            self.lblTracking.textColor = color
            self.lblResponseDate.text =  (caseItem.responseDate)
            self.lblResponseDate.isHidden = false
        default : break
        }
    }
    /*
    self.delegate = delegate
    self.lblStatus.text = caseItem.statusName
    self.lblDate.text = (caseItem.requestDateTime != nil) ? caseItem.requestDateTime.convertToPersianDate() : ""
    self.lblTitle.text = caseItem.description ?? ""
    self.lblResponse.text = caseItem.response ?? ""
    self.lblTarckingCode.text = caseItem.trackingCode
    self.lblSubject.text = caseItem.requestCategoryName
    self.vwAnswer.isHidden = (caseItem.response == nil || (caseItem.response?.isEmpty)!) ? true : false
    self.lblResponseCaption.isHidden = (caseItem.response == nil || (caseItem.response?.isEmpty)!) ? true : false
    self.vwAudio.isHidden = caseItem.getAudioFile() == nil ? true : false
    self.vwImage.isHidden = caseItem.getImageFile() == nil ? true : false
    switch caseItem.statusCode {
    case 1:
    let color = Theme.Color.blueBlue
    self.vwStatus.addBorder(color: color, thickness: 1)
    self.lblCaptionStatus.textColor = color
    self.lblStatus.textColor = color
    self.lblTarckingCode.textColor = color
    self.lblResponseDate.isHidden = true
    case 6:
    let color = Theme.Color.caseRed
    self.vwStatus.addBorder(color: color, thickness: 1)
    self.lblCaptionStatus.textColor = color
    self.lblStatus.textColor = color
    self.lblTarckingCode.textColor = color
    self.lblResponseDate.isHidden = true
    case 5:
    let color = Theme.Color.greetDark
    self.vwStatus.addBorder(color: color, thickness: 1)
    self.lblStatus.textColor = color
    self.lblCaptionStatus.textColor = color
    self.lblTarckingCode.textColor = color
    self.lblResponseDate.text =  (caseItem.responseDate?.convertToPersianDate() ?? "" )
    self.lblResponseDate.isHidden = false
    default : break
    }
 */
}

