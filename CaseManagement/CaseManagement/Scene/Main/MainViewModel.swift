//
//  MainViewModel.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation
protocol MainViewModelDelegate {
    func changeIndex()
}
class MainViewModel {
    var list : [CaseRequest] = []
    var delegate : MainViewModelDelegate!
    var index  = 0 {
        didSet{
            self.delegate.changeIndex()
        }
    }
    
    func downloadImage(_ url : URL,type : String ,completionHandler : @escaping (_ data : Data?)->Void)
    {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(data)
            }
        }).resume()
        
    }
    func downloadFile(url : URL , type : String , completionHandler : @escaping (_ path : String?)->Void){
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileName = url.getQueryStringParameter(param: "name") ?? url.lastPathComponent
    documentsURL.appendPathComponent( fileName + "." + type)
    if FileManager.default.fileExists(atPath: documentsURL.relativePath)
    {
        completionHandler(documentsURL.relativePath)
    }
    else
    {
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                completionHandler(localURL.absoluteString)
            }
        }
        
        task.resume()

    }
    }
}
