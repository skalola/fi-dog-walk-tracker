//
//  WalkDetailsViewController.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/11/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage

class WalkDetailsViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var walkDetailsTableView: UITableView!
    
    var walks: [Walks] = []
    var walksRef = Database.database().reference().child("walks")
    
}

extension WalkDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title and navigation bar and title color
        title = "Walk Details"
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
//        // Add star button
//        let btn1 = UIButton()
//        btn1.setImage(UIImage(named: "star-unselected"), for: .normal)
//        btn1.setImage(UIImage(named: "star-selected"), for: .selected)
//        btn1.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        btn1.addTarget(self, action: #selector(self.starAction(sender:)), for: .touchUpInside)
//        let starButton = UIBarButtonItem()
//        starButton.customView = btn1
//        self.navigationItem.rightBarButtonItem  = starButton
        
        // add back button
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backAction))
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        // Table view delegate
        walkDetailsTableView.delegate = self
        walkDetailsTableView.dataSource = self
        
        walkDetailsTableView.tableFooterView = UIView()
        
        walkDetailsTableView.register(UINib(nibName: "WalkDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "WalkDetailsTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}


//// MARK: - UITableViewDataSource
extension WalkDetailsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Setup table cells
        let cell = walkDetailsTableView.dequeueReusableCell(withIdentifier: "WalkDetailsTableViewCell", for: indexPath as IndexPath) as! WalkDetailsTableViewCell
        
        // Select game and get away team and home team for title
       
        
        return cell
        
    }
    
}


