//
//  TripsPageController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-05-23.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit

final class TripsPageController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var images = [UIImage]()
    var mountainName = [String]()
    var routeName = [String]()
    var date = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    images = [UIImage(named: "mtAssiniboine.jpg")!, UIImage(named: "mtCurrie.jpg")!, UIImage(named: "alcoholicsTraverse.jpg")!, UIImage(named: "mtRobson.jpg")!, UIImage(named: "mtWaddington.jpg")!]
        
    mountainName = ["Mt Assiniboine", "Mt Currie", "Alcoholics Traverse", "Mt Robson", "Mt Waddington"]
    
     routeName = ["North Ridge", "Mt. Currie Trail", "Full Traverse", "Wishbone Arete", "South Face"]
        
    date = ["July 15, 2018", "July 31, 2018", "August 15, 2018", "June 21, 2019", "July 17, 2019"]
        
    }
}

extension TripsPageController: UITableViewDelegate, UITableViewDataSource  {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
        
        // set cell's image.
        cell.cellImageView.image = images[indexPath.row]
        cell.cellMountainName.text = mountainName[indexPath.row]
        cell.cellRouteDesired.text = routeName[indexPath.row]
        cell.cellDateProposed.text = date[indexPath.row]
       
        return cell
    }

}
