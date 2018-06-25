//
//  MeetupPageDetailController.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-06-20.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit
import MapKit

final class MeetupPageDetailController: UIViewController {

    
    @IBOutlet var fullImageView: UIImageView!
    
    @IBOutlet var tripNameLabel: UILabel!
    
    @IBOutlet var tripDetails: UITextView!
    
    @IBAction func directionButton(_ sender: UIButton) {
    }
    
    @IBOutlet var eventMap: MKMapView!
}

