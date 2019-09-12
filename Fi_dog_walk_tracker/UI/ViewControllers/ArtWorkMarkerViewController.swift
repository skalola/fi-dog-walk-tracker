//
//  ArtWorkMarkerViewController.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/12/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        if let imageName = artwork.imageName {
            glyphImage = UIImage(named: "dogPin")
        } else {
            glyphImage = nil
        }
    }
}
