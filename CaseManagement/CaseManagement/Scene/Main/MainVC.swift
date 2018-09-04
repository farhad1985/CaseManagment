//
//  MainVC.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit
import AVKit

public class MainVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            let bundel = Bundle(for: MainVC.self)
            let nib = UINib(nibName: "CaseCell", bundle: bundel)
            tableView.register(nib, forCellReuseIdentifier: "CaseCell")
        }
    }
    
    @IBOutlet weak var segment : UISegmentedControl!{
        didSet{
            segment.tintColor = CaseTheme.Segment.segmentTintColor
            segment.setTitleTextAttributes([NSAttributedStringKey.font: CaseTheme.Segment.font],
                                                    for: .normal)
        }
    }
    
    var caseRequest : CaseRequest?
    var caseList = [CaseRequest]()
    var titleHeader : String = ""
    var viewModel = MainViewModel()
    var defualtIndexSelected : Int?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.list = caseList
        self.viewModel.delegate = self
        self.generateSegment()
        
        
        
    }
    @IBAction func onAddClick(_ sender: Any) {
        let vc = AddCaseManagementVC.create()
        let _case = self.caseList[self.viewModel.index]
        vc?.setDataSource(castRequests: self.viewModel.list,defaultCase:_case)
        self.navigationController?.pushViewController(vc!, animated: true)
        //self.present(vc!, animated: true, completion: nil)
    }
    
    func generateSegment(){
        segment.removeAllSegments()
        for (index,value) in viewModel.list.enumerated() {
            segment.insertSegment(withTitle: value.title, at: index, animated: true)
        }
        if let selectedDefault = self.defualtIndexSelected {
            //segment.selectedSegmentIndex = selectedDefault
            self.viewModel.index = selectedDefault
        }
    }
    
    @IBAction func changeSegment(_ sender : Any){
        self.viewModel.index = self.segment.selectedSegmentIndex
    }
    
}
extension MainVC : MainViewModelDelegate {
    func changeIndex() {
        self.segment.selectedSegmentIndex = self.viewModel.index
        self.tableView.reloadData()
    }
}
extension MainVC : CaseCellDelegate {
    func showImage(_ cell: CaseCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else{return}
        let caseItem = self.viewModel.list[self.viewModel.index].caseItems[indexPath.row]
        guard let imageFile = caseItem.getImageFile(),let url = imageFile.url, let type = imageFile.type else {
            return
        }
        
            if let url = URL(string: url)
            {
                cell.indicatorImage.startAnimating()
                cell.indicatorImage.isHidden = false
                //cell..isHidden = false
                self.viewModel.downloadImage(url, type: type) { (data) in
                    cell.indicatorImage.stopAnimating()
                    //cell.lblImageProgress.isHidden = true
                    guard let validData = data else {return}
                    self.showImage(UIImage(data: validData) ?? UIImage())
                }
            }
    }
    
    func playSound(_ cell: CaseCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        let caseItem = self.viewModel.list[self.viewModel.index].caseItems[indexPath.row]
        guard let audioFile = caseItem.getAudioFile(),let url = audioFile.url, let type = audioFile.type else {return}
        
        if let url = URL(string: url)
        {
            cell.indicatorAudio.startAnimating()
            cell.indicatorAudio.isHidden = false
            cell.lblAudioProgress.isHidden = false
            self.viewModel.downloadFile(url: url, type: type, completionHandler: { (path) in
                cell.indicatorAudio.stopAnimating()
                cell.lblAudioProgress.isHidden = true
                guard let _vPath = path else {return}
                self.soundPlay(withPath: _vPath)
            })
        }
        
        
    }
    
    func soundPlay(withPath url: String)
    {
        let url = URL(fileURLWithPath: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        self.present(playerViewController, animated: true, completion: nil)
        
    }
    
    func showImage(_ image: UIImage )
    {
        let vc = FullImageVc.newInstance()
        vc.path = image
        vc.title = self.title
        self.present(vc, animated: true, completion: nil)
        
    }
}


extension MainVC : UITableViewDelegate , UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.caseList[self.viewModel.index].caseItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.caseList[self.viewModel.index].caseItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
        cell.configCell(caseItem: model, delegate: self)
        return UITableViewCell()
    }
}


public extension MainVC {
    public static func initail(title : String , caseList : [CaseRequest] , defaultSelected : Int? = nil)->UINavigationController?{
        let bundel = Bundle(for: self)
        let story = UIStoryboard(name: "CaseManagement", bundle: bundel)
        let navigation = story.instantiateViewController(withIdentifier: "CaseNavigation") as? UINavigationController
        guard let main = navigation?.topViewController as? MainVC else {return nil}
        main.caseList = caseList
        main.titleHeader = title
        main.defualtIndexSelected = defaultSelected
        return navigation
    }
}
