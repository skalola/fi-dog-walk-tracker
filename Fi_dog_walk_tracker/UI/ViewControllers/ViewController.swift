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
    
    var walks: [Walks] = []
    var walksRef = Database.database().reference().child("walks")
    var handles: [DatabaseHandle] = []
    var keyArray:[String] = []
    var store = Storage.storage()
    var storeRef = Storage.storage().reference()
}

extension WalksViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set title and navigation bar and title color
        title = "Walks"
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Table view delegate
        walksTableView.delegate = self
        walksTableView.dataSource = self
        
        // Clear User defaults snippet
        //        let domain = Bundle.main.bundleIdentifier!
        //        UserDefaults.standard.removePersistentDomain(forName: domain)
        //        UserDefaults.standard.synchronize()
        
        // set default rows
        walksTableView.tableFooterView = UIView()
        
        walksTableView.register(UINib(nibName: "WalksTableViewCell", bundle: nil), forCellReuseIdentifier: "WalksTableViewCell")
        
        // Populate table with game ids from Firebase
        walksRef.observe(.childAdded, with: { snapshot in
            guard let walksDict = snapshot.value as? [String: Any] else { return print("couldn't cast") }
            let walk = Walks(dictionary: walksDict)
            self.walks.append(walk)
            self.walksRef.keepSynced(true)
            self.walksTableView.insertRows(at: [IndexPath(row: self.walks.count - 1, section: 0)], with: .automatic)
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
        return self.walks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Setup table cells
        let cell = walksTableView.dequeueReusableCell(withIdentifier: "WalksTableViewCell", for: indexPath as IndexPath) as! WalksTableViewCell
        
        // Get away team data
        walksRef.queryOrdered(byChild: "walks").queryEqual(toValue: walks[indexPath.row]).observe(.value, with: { snapshot in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let walkInfo = snap.value as? [String : AnyObject] ?? [:]
                cell.altitudeLabel?.text = walkInfo["altitude"] as? String
                cell.horizontalAccuracyLabel?.text = walkInfo["horizontalAccuracy"] as? String
                cell.verticalAccuracyLabel?.text = walkInfo["verticalAccuracy"] as? String
                cell.courseLabel?.text = walkInfo["course"] as? String
                cell.timeStampLabel?.text = walkInfo["timestamp"] as? String
                cell.speedLabel?.text = walkInfo["speed"] as? String
                cell.latitudeLabel?.text = walkInfo["latitude"] as? String
                cell.longitudeLabel?.text = walkInfo["longitude"] as? String
            }
        })

        return cell
        

    }
    
    /* NAVIGATION */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


