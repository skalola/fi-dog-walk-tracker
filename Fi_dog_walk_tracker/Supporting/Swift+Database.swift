//
//  Swift+Database.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/11/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import Firebase

protocol FirebaseConvertible {
    var json: [String: Any] { get }
    
    init(dictionary: [String: Any])
}

extension Server {
    private static var rootRef: DatabaseReference {
        return Database.database().reference()
    }
    
    private static var walksRef: DatabaseReference {
        return Server.rootRef.child("walks")
    }

    
}
