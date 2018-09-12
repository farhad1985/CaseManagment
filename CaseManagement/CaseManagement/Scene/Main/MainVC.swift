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
            tableView.addSubview(pullToRefresh)
            pullToRefresh.addTarget(self,
                                    action: #selector(refresh),
                                    for: .valueChanged)
        }
    }
    
    let pullToRefresh = UIRefreshControl()
    
    @IBOutlet weak var segment : UISegmentedControl!{
        didSet{
            segment.tintColor = CaseTheme.Segment.segmentTintColor
            segment.setTitleTextAttributes([NSAttributedStringKey.font: CaseTheme.Segment.font],
                                                    for: .normal)
            segment.addTarget(self,
                              action: #selector(actionSegment),
                              for: .valueChanged)
        }
    }
    
    var caseRequest : CaseItem?
    var caseList = [CaseItem]()
    var titleHeader : String = ""
    var viewModel = MainViewModel()
    var defualtIndexSelected : Int?
    
    var service: CaseManagementProtocol?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        service?.register(table: self.tableView)
        
        service?.getCaseItems(callBack: { (items) in
            self.viewModel.list = items
            self.viewModel.delegate = self
            self.generateSegment()
            self.segment.selectedSegmentIndex = 0
            self.getIssues()
        })
        
    }
    
    @objc
    func refresh() {
        getIssues()
    }
    
    func getIssues() {
        service?.getCases(callBack: { (caseIssueList) in
            if caseIssueList.count > 0 {
                self.viewModel.issueList.removeAll()
                for _ in self.viewModel.list {
                    self.viewModel.issueList.append([])
                }
            }
            for issue in caseIssueList {
                for item in self.viewModel.list.enumerated() {
                    if issue.issueCaseTypeCode == item.element.id {
                        self.viewModel.issueList[item.offset].append(issue)
                    }
                }
            }
            self.tableView.reloadData()
            self.pullToRefresh.endRefreshing()
        })
    }
    
    @objc
    func actionSegment() {
        print(segment.selectedSegmentIndex)
    }
    
    @IBAction func onAddClick(_ sender: Any) {
        let vc = AddCaseManagementVC.create()
        vc?.setDataSource(castRequests: self.viewModel.list)
        vc?.service = service
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func generateSegment(){
        segment.removeAllSegments()
        for (index,value) in viewModel.list.enumerated() {
            segment.insertSegment(withTitle: value.title,
                                  at: index,
                                  animated: true)
        }
        if let selectedDefault = self.defualtIndexSelected {
            segment.selectedSegmentIndex = selectedDefault
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

//extension MainVC : CaseCellDelegate {
//    func showImage(_ cell: CaseCell) {
//        guard let indexPath = self.tableView.indexPath(for: cell) else{return}
//        let caseItem = self.viewModel.list[self.viewModel.index].caseItems[indexPath.row]
//        guard let imageFile = caseItem.getImageFile(),let url = imageFile.url, let type = imageFile.type else {
//            return
//        }
//        
//            if let url = URL(string: url)
//            {
//                cell.indicatorImage.startAnimating()
//                cell.indicatorImage.isHidden = false
//                //cell..isHidden = false
//                self.viewModel.downloadImage(url, type: type) { (data) in
//                    cell.indicatorImage.stopAnimating()
//                    //cell.lblImageProgress.isHidden = true
//                    guard let validData = data else {return}
//                    self.showImage(UIImage(data: validData) ?? UIImage())
//                }
//            }
//    }

//    func playSound(_ cell: CaseCell) {
//        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
//        let caseItem = self.viewModel.list[self.viewModel.index].caseItems[indexPath.row]
//        guard let audioFile = caseItem.getAudioFile(),let url = audioFile.url, let type = audioFile.type else {return}
//
//        if let url = URL(string: url)
//        {
//            cell.indicatorAudio.startAnimating()
//            cell.indicatorAudio.isHidden = false
//            cell.lblAudioProgress.isHidden = false
//            self.viewModel.downloadFile(url: url, type: type, completionHandler: { (path) in
//                cell.indicatorAudio.stopAnimating()
//                cell.lblAudioProgress.isHidden = true
//                guard let _vPath = path else {return}
//                self.soundPlay(withPath: _vPath)
//            })
//        }
        
        
//    }

//    func soundPlay(withPath url: String)
//    {
//        let url = URL(fileURLWithPath: url)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = AVPlayer(url: url)
//        self.present(playerViewController, animated: true, completion: nil)
//
//    }
//
//    func showImage(_ image: UIImage )
//    {
//        let vc = FullImageVc.newInstance()
//        vc.path = image
//        vc.title = self.title
//        self.present(vc, animated: true, completion: nil)
//
//    }
//}


extension MainVC : UITableViewDelegate , UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.issueList.count > 0 {
            return viewModel.issueList[segment.selectedSegmentIndex].count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.issueList[segment.selectedSegmentIndex][indexPath.row]
        let cell = service?.getIssueCell(table: tableView,
                                         index: indexPath,
                                         item: model)
        return cell!
    }
}


public extension MainVC {
    public static func initail(title : String , service : CaseManagementProtocol?)->UINavigationController?{
        let bundel = Bundle(for: self)
        let story = UIStoryboard(name: "CaseManagement", bundle: bundel)
        let navigation = story.instantiateViewController(withIdentifier: "CaseNavigation") as? UINavigationController
        guard let main = navigation?.topViewController as? MainVC else {return nil}
        main.service = service
        main.titleHeader = title
//        main.defualtIndexSelected = nil
        return navigation
    }
}
