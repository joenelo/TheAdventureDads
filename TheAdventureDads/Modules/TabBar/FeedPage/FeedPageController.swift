//
//  FeedPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit

struct Feed: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    
//    init (json: [String: Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["username"] as? String ?? ""
//        imageUrl = json["profile_picture"] as? String ?? ""
//    }
}

final class FeedPageController: UIViewController {
    
    @IBAction func switchCustomTableViewAction(_ sender: UISegmentedControl) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instaApiCall()
    }
      
    
    func instaApiCall () {
        
        let apiToContact = "https://api.instagram.com/v1/users/self/?access_token=7309771784.8bca4b4.8699a750c408415282a19a5214953605"
        
        guard let url = URL(string: apiToContact) else { return}
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let feed = try
                    JSONDecoder().decode(Feed.self, from: data)
                print(feed)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
        
        }
    
    
    
}
