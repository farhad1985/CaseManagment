//
//  AddCaseManagementVC.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit
import AVKit

public class AddCaseManagementVC: UIViewController {
    
    @IBOutlet weak var caseTextField: CasePickerView!
    @IBOutlet weak var partTextField: CasePickerView!
    
    var defaultCase: CaseRequest?
    var defaultPartCase: CaseRequest?
    
    private var castRequests: [CaseRequest] = []
    private var caseSelected: CaseRequest?
    private var partCaseSelected: CaseRequest?
    private var audioRecorder:AVAudioRecorder!
    private var vr: VoiceView!
    var isOpen = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        vr = VoiceView(frame: CGRect(x: 0, y: height, width: width, height: 150))
        self.view.addSubview(vr)

        handleOnChanges()
        setDefaultCases()
    }
    
    @IBAction func record(_ sender: Any)
    {
        self.view.endEditing(true)
        
        AVAudioSession.sharedInstance().requestRecordPermission { (isAllow) in
            if isAllow {
                self.isOpen ? self.closeRecorder() : self.showRecorder()
            }
        }
    }
    
    func recordVoice() {
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? audioSession.setActive(true)
        
        let documents = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let str =  documents.appending("/recordTest.caf")
        
        let url = NSURL.fileURL(withPath: str as String)
        
        let recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
                              AVSampleRateKey:44100.0,
                              AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
                              AVLinearPCMBitDepthKey:16,
                              AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue] as [String : Any]
        
        print("url : \(url)")
        var _: NSError?
        
        try? audioRecorder = AVAudioRecorder(url:url, settings: recordSettings)
        audioRecorder.record()
        audioRecorder.stop()

    }
    
    func showRecorder() {
        UIView.transition(with: vr, duration: 0.3, options: .showHideTransitionViews, animations: {
            self.vr.frame.origin.y = self.height - 100
        }, completion: { _ in
            self.isOpen = true
        })
    }
    
    func closeRecorder() {
        
        UIView.transition(with: vr, duration: 0.2, options: .showHideTransitionViews, animations: {
            self.vr.frame.origin.y = self.height
        }, completion: { _ in
            self.isOpen = false
            self.vr.stop()
        })
    }
    
    //    @IBAction func attach(_ sender: Any)
    //    {
    //        let gallery:actionSheetButton = (title: Message.chooseFromGallery.rawValue, style: UIAlertActionStyle.destructive, completion:
    //        {
    //            _ in
    //            DeviceSettingAuthorization.photoGalleryIsAvailable
    //                {
    //                    self.showGalleryWith(UIImagePickerControllerSourceType.photoLibrary)
    //            }
    //        })
    //        let camera:actionSheetButton = (title: Message.takePhoto.rawValue, style: UIAlertActionStyle.default, completion:
    //        {
    //            _ in
    //            DeviceSettingAuthorization.cameraIsAvailable
    //                {
    //                    self.showGalleryWith(UIImagePickerControllerSourceType.camera)
    //            }
    //        })
    //        Util.showActionSheet(self.btnAttach, title: "" , message: Message.gallery.rawValue, buttons: [camera,gallery])
    //    }
    
    private func handleOnChanges() {
        caseTextField.onChange = { caseRequest in
            self.partTextField.setDataSource(dataSource: caseRequest.partsCast)
            self.caseSelected = caseRequest
            self.dismissKeyboard()
        }
        
        partTextField.onChange = { partCaseRequest in
            self.partCaseSelected = partCaseRequest
            self.dismissKeyboard()
        }
    }
    
    private func setDefaultCases() {
        if let dCase = defaultCase {
            caseTextField.setDataSource(dataSource: castRequests, defaultCase: dCase)
        } else {
            caseTextField.setDataSource(dataSource: castRequests)
        }
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func setDataSource(castRequests: [CaseRequest], defaultCase: CaseRequest? = nil) {
        self.castRequests = castRequests
        self.defaultCase = defaultCase
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
        closeRecorder()
    }
}

public extension AddCaseManagementVC {
    public static func create() -> AddCaseManagementVC?{
        let bundle = Bundle(for: self)
        let story = UIStoryboard(name: "CaseManagement", bundle: bundle)
        return story.instantiateViewController(withIdentifier: "AddCaseManagementVC") as? AddCaseManagementVC
    }
}


//extension AddCaseManagementVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
//        let path = info[UIImagePickerControllerReferenceURL] as? URL
//        self.imageFilePath = path?.lastPathComponent ?? "jpeg"
//        self.imgAttachment.image = img
//        self.btnImageRemove.isHidden = false
//        
//        picker.dismiss(animated: true, completion:
//            {
//                let fileSize : Float = (2048 * 1024).convert()
//                self.startLoading()
//                
//                img?.compressTo(fileSize, callback:
//                    {
//                        (data) in
//                        if let compressImageData = data
//                        {
//                            compressImageData.toBase64(result:
//                                {
//                                    (base64) in
//                                    self.stopLoading()
//                                    self.imageUploaded = base64
//                            })
//                        }
//                })
//        })
//    }
//    
//}
