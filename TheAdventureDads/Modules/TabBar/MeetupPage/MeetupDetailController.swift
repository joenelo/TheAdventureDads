//
//  MeetupDetailController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-06-17.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {
    var detailModal = [Any]()
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var directionsButton: UIButton!
    
    // -- Lat and Long come in as decimals,  set to Doubles -- //
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
    }
    
    
    
}
