//
//  WalksViewController.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/11/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage


final class WalksViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var walksTableView: UITableView!
    
    var walksRef = Database.database().reference().child("walks")
    var handles: [DatabaseHandle] = []
    var store = Storage.storage()
    var storeRef = Storage.storage().reference()
    var dogWalkDict = [NSDictionary]()
}

extension WalksViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title and navigation bar and title color
        title = "Walks"
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // Table view delegate
        walksTableView.delegate = self
        walksTableView.dataSource = self
    
        // Register reusable cell
        walksTableView.register(UINib(nibName: "WalksTableViewCell", bundle: nil), forCellReuseIdentifier: "WalksTableViewCell")
        
        // Populate table with game ids from Firebase
        walksRef.observe(.childAdded, with: { snapshot in
            let walksDict = snapshot.value  as! NSDictionary
            self.dogWalkDict.append(walksDict)
            self.walksTableView.insertRows(at: [IndexPath(row: self.dogWalkDict.count - 1, section: 0)], with: .automatic)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        // Reload table data
        self.walksTableView.reloadData()
    }
}


//// MARK: - UITableViewDataSource
extension WalksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogWalkDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Setup table cells
        let cell = walksTableView.dequeueReusableCell(withIdentifier: "WalksTableViewCell", for: indexPath as IndexPath) as! WalksTableViewCell
        
        let timestamp = dogWalkDict[indexPath.row]["timestamp"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateFormatter.date(from: timestamp as! String)
        dateFormatter.dateFormat = "h:mm a"
        var calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        let monthName = DateFormatter().monthSymbols[month - 1]
        let day = calendar.component(.day, from: date!)
        let localTime = dateFormatter.string(from: date!)
        cell.timeStampLabel?.text = "\(monthName) \(day), \(year) \(localTime)"

        return cell
 
    }
    
    /* NAVIGATION */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Setup data to pass to next view
        let mapView = MapViewController()
        mapView.timestamp = "\(dogWalkDict[indexPath.row]["timestamp"] ?? "timestamp")"
        mapView.altitude = "\(dogWalkDict[indexPath.row]["altitude"] ?? "altitude")"
        mapView.speed = "\(dogWalkDict[indexPath.row]["speed"] ?? "speed")"
        mapView.course = "\(dogWalkDict[indexPath.row]["course"] ?? "course")"
        mapView.latitude = "\(dogWalkDict[indexPath.row]["latitude"] ?? "latitude")"
        mapView.longitude = "\(dogWalkDict[indexPath.row]["longitude"] ?? "longitude")"
        mapView.horizontalAccuracy = "\(dogWalkDict[indexPath.row]["horizontalAccuracy"] ?? "horizontalAccuracy")"
        mapView.verticalAccuracy = "\(dogWalkDict[indexPath.row]["verticalAccurcacy"] ?? "verticalAccuracy")"

        let navBar = UINavigationController(rootViewController: mapView)
        self.present(navBar,animated: true, completion: nil)
        
    }
}
