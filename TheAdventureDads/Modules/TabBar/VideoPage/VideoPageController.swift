//
//  VideoPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import YouTubePlayer



final class VideoPageController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var youTubeItems = [YoutubeFeed]()
    @IBOutlet var tableView: UITableView!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        youtubeApiCall()
    }
    
    //--------------------------------------------------------
    // --- Start the API CALL to retreive Data from Youtube
    //--------------------------------------------------------
    func youtubeApiCall () {
        
        let parameters: Parameters = ["part":"snippet",
                                      "playlistId":"PLdxn7s5TKRAjhnwliI5guf6yfJ10KaiAg",
                                      "key":"AIzaSyCiErgUhkZUyMHnQLvV8YTGuAiBVBxP_kU"]
        let url = "https://www.googleapis.com/youtube/v3/playlistItems"
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default)
            .responseData(completionHandler: { response in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)

                        // Loop through to start getting the data
                        for (_, item) in json["items"] {
                            //print(item)
                            
                            // Define Video Variables
                            var videoID: String!
                            
                            // ---------------- Video ID.
                            if let snippet = item["snippet"].dictionaryObject {
                                   let snippet = JSON(snippet)
                                
                                if let resourceId = snippet["resourceId"].dictionaryObject {
                                    let resourceId = JSON(resourceId)
                                    
                                    // HERE'S WHERE YOU GRAB THE VIDEO URL.
                                    videoID = resourceId["videoId"].string
                                }
                            }
                            
                            // Append image and text to array.
                            self.youTubeItems.append(YoutubeFeed(ytVideoId: videoID))
                        }
                    
                        // Refresh tableview
                        self.tableView.reloadData()

                // If there was an error retrieving JSON...
                case .failure(let error):
                    print(error)
                }
                
            })
    }
}

extension VideoPageController: UITableViewDelegate, UITableViewDataSource, YouTubePlayerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        cell.videoPlayer.delegate = self
        cell.videoPlayer.loadVideoID(youTubeItems[indexPath.row].ytVideoId)
        
        return cell
    }
    
    
    // When video is finished loading, hide loading spinner.
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        activityIndicator.stopAnimating()
    }
    
}








