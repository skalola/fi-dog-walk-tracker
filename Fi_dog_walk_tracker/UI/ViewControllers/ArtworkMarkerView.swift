//
//  ArtworkMarkerView.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/12/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}
