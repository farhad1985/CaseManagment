//
//  AddCaseManagementVC.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

public class AddCaseManagementVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var caseTextField: CasePickerView!
    @IBOutlet weak var partTextField: CasePickerView!
    @IBOutlet weak var imgAttachment: UIImageView! {
        didSet {
            self.imgAttachment.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var btnDeleteImage: UIButton!
    @IBOutlet weak var btnDeleteAudio: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    var defaultCase: CaseItem?
    var defaultPartCase: CaseItem?
    
    private var castRequests: [CaseItem] = []
    private var caseSelected: CaseItem?
    private var partCaseSelected: CaseItem?
    
    private var vr: VoiceView!
    var isOpen = false
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var maxTimeRecode = ""
    
    // audio
    var audioSession = AVAudioSession.sharedInstance()
    var soundRecorder: AVAudioRecorder!
    var soundPlayer: AVAudioPlayer!
    
    // pic
    private var imageFilePath : String! = ""
    private var imageUploaded : String? = nil
    
    
    var filename = "audioFile.m4a"
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        handleOnChanges()
        setDefaultCases()
        
        setupVoiceRecorder()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deleteAudio()
    }
    
    @IBAction func record(_ sender: Any) {
        self.view.endEditing(true)
        
        AVAudioSession.sharedInstance().requestRecordPermission { (isAllow) in
            if isAllow {
                self.isOpen ? self.closeRecorder() : self.showRecorder()
            }
        }
    }
    
    @IBAction func play(_ sender: Any) {
        prepareplayer()
    }
    
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
    
    public func setDataSource(castRequests: [CaseItem], defaultCase: CaseItem? = nil) {
        self.castRequests = castRequests
        self.defaultCase = defaultCase
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
        closeRecorder()
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "خطا", message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "تایید", style:  .destructive, handler: nil)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    func showGalleryWith(_ sourceType : UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapDeleteAudio(_ sender: Any) {
        deleteAudio()
        btnDeleteAudio.isHidden = true
    }
    
    @IBAction func didTapDeleteImage(_ sender: Any) {
        btnDeleteImage.isHidden = true
        imageUploaded = nil
        imgAttachment.image = UIImage(named: "no-image-available",
                                      in: Bundle(identifier: "CaseManagement"),
                                      compatibleWith: nil)
    }

    @IBAction func didTapAttachImage(_ sender: Any) {
        let alertPic = UIAlertController(title: "آپلود تصویر", message: "انتخاب کنید", preferredStyle: .actionSheet)
        
        let galleryButton = UIAlertAction(title: "گالری", style: .default) { _ in
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized: self.showGalleryWith(UIImagePickerControllerSourceType.photoLibrary)
            case .denied: UIApplication.shared.open(URL(string : UIApplicationOpenSettingsURLString)!,
                                                                    options: [:],
                                                                    completionHandler: nil)

            default: PHPhotoLibrary.requestAuthorization({ (granted) in
                    DispatchQueue.main.async {
                        if granted == .authorized {
                            self.showGalleryWith(UIImagePickerControllerSourceType.photoLibrary)                        }
                    }})
            }
        }
        
        
        let cameraButton = UIAlertAction(title: "دوربین", style: .destructive) { _ in
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            case .authorized: self.showGalleryWith(UIImagePickerControllerSourceType.camera)
            case .denied: UIApplication.shared.open(URL(string : UIApplicationOpenSettingsURLString)!,
                                                    options: [:],
                                                    completionHandler: nil)
            default: AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                DispatchQueue.main.async {
                    if granted == true {
                        self.showGalleryWith(UIImagePickerControllerSourceType.camera)                            }
                    }})
            }
        }
        
        let cancel = UIAlertAction(title: "انصراف", style: .cancel, handler: nil)

        alertPic.addAction(galleryButton)
        alertPic.addAction(cameraButton)
        alertPic.addAction(cancel)

        self.present(alertPic, animated: true, completion: nil)
    }
}

public extension AddCaseManagementVC {
    public static func create() -> AddCaseManagementVC?{
        let bundle = Bundle(for: self)
        let story = UIStoryboard(name: "CaseManagement", bundle: bundle)
        return story.instantiateViewController(withIdentifier: "AddCaseManagementVC") as? AddCaseManagementVC
    }
}

// Recording
extension AddCaseManagementVC {
    
    fileprivate func setupVoiceRecorder() {
        deleteAudio()
        vr = VoiceView(frame: CGRect(x: 0, y: height, width: width, height: 150))
        
        vr.onRecord = { isRecording in
            if isRecording {
                if self.soundRecorder != nil {
                    self.soundRecorder.record()
                    self.btnPlay.isHidden = true
                    self.btnDeleteAudio.isHidden = true
                }
            } else {
                if self.soundRecorder != nil {
                    self.soundRecorder.stop()
                    self.btnPlay.isHidden = false
                    self.btnDeleteAudio.isHidden = false
                }
            }
            
        }
        self.view.addSubview(vr)
        
        recordVoice()
        DispatchQueue.main.async {
            self.soundRecorder.record()
            self.soundRecorder.stop()
            self.deleteAudio()
            self.btnPlay.isHidden = true
            self.btnDeleteAudio.isHidden = true
        }
    }
    
    func recordVoice() {
        // TODO: change format
        let recordSetting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                             AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                             AVSampleRateKey: 12000 ]
        do {
            self.soundRecorder = try AVAudioRecorder(url: self.getFileURL(), settings: recordSetting)
            self.soundRecorder.delegate = self
            self.soundRecorder.prepareToRecord()
        } catch(let error) {
            print(">>>>> recorder: \(error.localizedDescription)")
        }
        
    }
    
    func getCatchDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    func getFileURL() -> URL {
        let path = getCatchDirectory().appendingPathComponent(filename)
        return path
    }
    
    func prepareplayer() {
        do {
            self.soundPlayer = try AVAudioPlayer(contentsOf: self.getFileURL())
            self.soundPlayer.delegate = self
            self.soundPlayer.volume = 8
            self.soundPlayer.play()
        } catch (let error) {
            print(">>>>> player : \(error.localizedDescription)")
        }
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
    
    func deleteAudio() {
        if FileManager.default.fileExists(atPath: getFileURL().absoluteString){
            print("its avaliable")
        }
        do {
            try FileManager.default.removeItem(at: getFileURL())
            btnPlay.isHidden = true
            btnDeleteAudio.isHidden = true

        } catch(let error) {
            print("error delete file >> \(error.localizedDescription)")
        }
    }
    
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finish record")
//        btnPlay.isHidden = false
//        btnDeleteAudio.isHidden = false
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish play")
    }
}

// Take Picture
extension AddCaseManagementVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        let path = info[UIImagePickerControllerReferenceURL] as? URL
        self.imageFilePath = path?.lastPathComponent ?? "jpeg"
        self.imgAttachment.image = img
        self.btnDeleteImage.isHidden = false
        
        picker.dismiss(animated: true, completion: {
            let fileSize : Float = (2048 * 1024).convert()
            self.compressTo(fileSize, image: img! ,callback: { (data) in
                if let compressImageData = data {
                    self.convertBase64(data: compressImageData, result: { (base64) in
                        self.imageUploaded = base64
                    })
                }
            })
        })
    }
    
    func convertBase64(data: Data, result : @escaping ((String?)->Void)) -> () {
        DispatchQueue.global(qos: .userInitiated).async {
            let tmp = data.base64EncodedString()
            DispatchQueue.main.async {
                result(tmp)
            }
        }
    }
    
    func resizeImageToFullHd(image: UIImage) -> UIImage? {
        // Reducing file size to a 10th
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let scale = UIScreen.main.scale
        let maxWidth : CGFloat = 1920.0 * scale
        let maxHeight : CGFloat = 1080.0 * scale
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        
        if (actualHeight > maxHeight || actualWidth > maxWidth) {
            if(imgRatio < maxRatio) {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            } else if(imgRatio > maxRatio) {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            } else {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect = CGRect(x: 0, y: 0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size);
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        return img
    }
    
    func fixOrientation(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImageOrientation.up {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return image
        }
    }
    
    func compressTo(_ expectedSizeInMb:Float, image: UIImage, callback : @escaping ((Data?)->Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            var imageData = UIImagePNGRepresentation(image)
            let sizeInBytes = expectedSizeInMb * 1024.0 * 1024.0
            if let realSizeInBytes = imageData?.count {
                
                if Float(realSizeInBytes) > sizeInBytes {
                    let dataImage = self.resizeImageToFullHd(image: image)
                    let fixImage = self.fixOrientation(image: dataImage!)
                    imageData = UIImagePNGRepresentation(fixImage)
                    
                    if let resizeInBytes = imageData?.count {
                        var needCompress:Bool = (Float(resizeInBytes) <= sizeInBytes) ? false : true
                        var compressingValue:CGFloat = 1.0
                        while (needCompress && compressingValue > 0.0) {
                            
                            if let data:Data = UIImageJPEGRepresentation(self.fixOrientation(image: image), compressingValue){
                                
                                if Float(data.count) < sizeInBytes {
                                    needCompress = false
                                    imageData = data
                                    break
                                } else {
                                    compressingValue -= 0.05
                                }
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                callback(imageData)
            }
        }
    }
}

extension Int {
    func convert(unit: ByteCountFormatter.Units = .useMB) -> Float {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [unit]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self))
        
        if let range = string.range(of: "\\d+(\\.\\d*)?", options: .regularExpression)
        {
            let result = string[range]
            return (result.isEmpty) ? 0 : Float(result)!
        }
        return 2.0
    }
}

