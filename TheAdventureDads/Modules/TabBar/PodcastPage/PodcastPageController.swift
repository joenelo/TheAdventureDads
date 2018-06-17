//
//  PodcastPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import Alamofire
import YouTubePlayer
import SwiftyJSON
import Kingfisher

final class PodcastController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    var podcastItems = [PodcastFeed]()
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        podcastApiCall()
    }
    
    //--------------------------------------------------------
    // --- Start the API CALL to retreive Data from Youtube
    //--------------------------------------------------------
    func podcastApiCall () {
        
        let parameters: Parameters = ["part":"snippet",
                                      "playlistId":"PLuu6fDad2eJyWPm9dQfuorm2uuYHBZDCB",
                                      "key":"AIzaSyCiErgUhkZUyMHnQLvV8YTGuAiBVBxP_kU",
                                      "maxResults": "25"]
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
                        print(item)
                        
                        // Define Video Variables
                        var podcastID: String!
                        
                        // ---------------- Video ID.
                        if let snippet = item["snippet"].dictionaryObject {
                            let snippet = JSON(snippet)
                            
                            if let resourceId = snippet["resourceId"].dictionaryObject {
                                let resourceId = JSON(resourceId)
                                
                                // HERE'S WHERE YOU GRAB THE VIDEO URL.
                                podcastID = resourceId["videoId"].string
                            }
                        }
                        
                        
                         //Append image and text to array.
                        self.podcastItems.append(PodcastFeed(podcastId: podcastID))
                    }
                    
                    // Refresh tableview
                    self.collectionView.reloadData()
                    
                // If there was an error retrieving JSON...
                case .failure(let error):
                    print(error)
                }
                
            })
    }
}

extension PodcastController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YouTubePlayerDelegate {
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "PodcastCell", for: indexPath) as! PodcastCell
        cell.podcastPlayer.delegate = self
        cell.podcastPlayer.loadVideoID(podcastItems[indexPath.row].podcastId)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcastItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimention = UIScreen.main.bounds.width/2 - 20
        let size = CGSize(width: dimention, height: dimention+20)
        return size
    }

    
    // When video is finished loading, hide loading spinner.
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        activityIndicator.stopAnimating()
    }
}




