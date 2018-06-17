//
//  MeetupPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit

final class MeetupPageController: UIViewController {
    
 
    @IBOutlet var tableView: UITableView!
    
    
    var images = [UIImage]()
    var tripName = [String]()
    var date = [String]()
    var located = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [UIImage(named: "mtAssiniboine.jpg")!, UIImage(named: "mtCurrie.jpg")!, UIImage(named: "alcoholicsTraverse.jpg")!, UIImage(named: "mtRobson.jpg")!, UIImage(named: "mtWaddington.jpg")!]
        
        tripName = ["Family Take over of the Chief", "Learn to Climb in Victoria", "Family First of the Season", "Get High, Hike Mt Currie", "Step It Up on a Mountain!"]
        
        date = ["August 31, 2018", "September 7, 2018", "June 20, 2019", "July 31, 2019", "August 31, 2019"]
        
        located = ["Squamish BC", "Victoria BC", "Squamish", "Pemberton", "Alberni Inlet"]
        
        
        
    }
}

extension MeetupPageController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetupCell", for: indexPath) as! MeetupCell
        
        // set cell's image.
        cell.cellImageView.image = images[indexPath.row]
        cell.cellTripName.text = tripName[indexPath.row]
        cell.cellDate.text = date[indexPath.row]
        cell.cellLocated.text = located[indexPath.row]
        
        return cell
    }
    
}

