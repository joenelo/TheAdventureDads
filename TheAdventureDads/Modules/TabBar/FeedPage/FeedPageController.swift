//
//  FeedPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


final class FeedPageController: UIViewController {
    
    var feedItems = [InstagramFeed]()
    var didSetHeight = false
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        
      
    }
    
    @IBOutlet var tableView: UITableView!

    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            self.tableView.reloadData()
        }
        instaApiCall()
    }
    
   
    //--------------------------------------------------------
    // --- Start the API CALL to retreive Data from Instagram
    //--------------------------------------------------------
    func instaApiCall () {
        
        // Key.
        let aT = "7309771784.8bca4b4.8699a750c408415282a19a5214953605"
        
        // API Call.
        Alamofire.request("https://api.instagram.com/v1/users/self/media/recent/?access_token=\(aT)").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                // Loop through to get the good stuff...
                for (_, item) in json["data"] {
                    
                    // Define Feed variables.
                    var feedImageUrl: String!
                    var feedText: String!
                    
                    // ---------------- Image.
                    if let images = item["images"].dictionaryObject {
                        let images = JSON(images)
                        
                        if let image = images["standard_resolution"].dictionaryObject {
                            let image = JSON(image)
                            
                            // HERE'S WHERE YOU GRAB THE IMAGE URL.
                            feedImageUrl = image["url"].string
                        }
                    }
                    
                    // ---------------- Text.
                    if let caption = item["caption"].dictionaryObject {
                        let caption = JSON(caption)
                        
                        // HERE'S WHERE YOU GRAB THE TEXT
                        feedText = caption["text"].string
                    }
                    
                    // Append image and text to array.
                    self.feedItems.append(InstagramFeed(feedImageUrl: feedImageUrl, feedText: feedText))
                }
                
                // Refresh tableview
                self.tableView.reloadData()
                
                // If there was an error retrieving JSON...
                case .failure(let error):
                    print(error)
                }
            }
        }
}

extension FeedPageController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 1000
//    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        
        // set cell's image.
        cell.feedImage.kf.setImage(with: URL(string: feedItems[indexPath.row].feedImageUrl))
        
        cell.feedImage.kf.setImage(with: URL(string: feedItems[indexPath.row].feedImageUrl), placeholder: nil, options: nil, progressBlock: nil) { (_, _, _, _) in
            if self.didSetHeight == false {
                tableView.reloadData()
                self.didSetHeight = true
            }
        }
        // set set cell's text
        cell.feedText.text = feedItems[indexPath.row].feedText

        return cell
    }
}
