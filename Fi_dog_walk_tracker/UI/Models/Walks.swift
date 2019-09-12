//
//  Walks.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/11/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import Foundation
import UIKit

struct Walks {
    var altitude: Int
    var course: Int
    var horizontalAccuracy: Int
    var latitude: Int
    var longitude: Int
    var speed: Int
    var timestamp: String
    var verticalAccuracy: Int
    
    init(altitude: Int, course: Int, horizontalAccuracy: Int, latitude: Int, longitude: Int, speed: Int, timestamp: String, verticalAccuracy: Int) {
        self.altitude = altitude
        self.course = course
        self.horizontalAccuracy = horizontalAccuracy
        self.latitude = latitude
        self.longitude = longitude
        self.speed = speed
        self.timestamp = timestamp
        self.verticalAccuracy = verticalAccuracy
    }
}

// MARK: - FirebaseConvertible
extension Walks: FirebaseConvertible {
    var json: [String: Any] {
        return [
            "altitude": altitude,
            "course": course,
            "horizontalAccuracy": horizontalAccuracy,
            "latitude": latitude,
            "longitude": longitude,
            "speed": speed,
            "timestamp": timestamp,
            "verticalAccuracy": verticalAccuracy
        ]
    }
    
    init(dictionary: [String: Any]) {
        guard let altitude = dictionary["altitude"] as? Int else { fatalError() }
        self.altitude = altitude
        guard let course = dictionary["course"] as? Int else { fatalError() }
        self.course = course
        guard let horizontalAccuracy = dictionary["horizontalAccuracy"] as? Int else { fatalError() }
        self.horizontalAccuracy = horizontalAccuracy
        guard let latitude = dictionary["latitude"] as? Int else { fatalError() }
        self.latitude = latitude
        guard let longitude = dictionary["longitude"] as? Int else { fatalError() }
        self.longitude = longitude
        guard let speed = dictionary["speed"] as? Int else { fatalError() }
        self.speed = speed
        guard let timestamp = dictionary["timestamp"] as? String else { fatalError() }
        self.timestamp = timestamp
        guard let verticalAccuracy = dictionary["verticalAccuracy"] as? Int else { fatalError() }
        self.verticalAccuracy = verticalAccuracy
    }
}



