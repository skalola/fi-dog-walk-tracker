//
//  MapViewController.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/12/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Use placeholders to receive data from last view
    var timestamp: String = ""
    var speed: String = ""
    var course: String = ""
    var altitude: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var horizontalAccuracy: String = ""
    var verticalAccuracy: String = ""

    // Dismiss view
    @objc func backAction() {
        self.dismiss(animated: true)
    }
    
}

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // Set title and navigation bar and title color
        title = "Walk Details"
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        // Add back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateFormatter.date(from: timestamp)
        dateFormatter.dateFormat = "h:mm a"
        var calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        let monthName = DateFormatter().monthSymbols[month - 1]
        let day = calendar.component(.day, from: date!)
        let localTime = dateFormatter.string(from: date!)
        
        // Show walk data
        dayLabel.text = "\(monthName) \(day)"
        timeLabel.text = "\(localTime)"
        altitudeLabel.text = "Altitude = \(altitude)"

        // Zoom in on walk location
        let initialLocation = CLLocation(latitude: Double("\(latitude)") as! CLLocationDegrees, longitude: Double("\(longitude)") as! CLLocationDegrees)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)

        // Show artwork on map
        let artwork = Artwork(title: "Your speed on this walk was \(speed).",
            coordinate: CLLocationCoordinate2D(latitude: Double("\(latitude)") as! CLLocationDegrees, longitude: Double("\(longitude)") as! CLLocationDegrees))

        mapView.addAnnotation(artwork)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "dogPin")
        return annotationView
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}

