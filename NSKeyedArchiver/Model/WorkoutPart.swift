//
//  WorkoutPart.swift
//  NSKeyedArchiver
//
//  Created by Drew Westcott on 19/02/2018.
//  Copyright © 2018 Drew Westcott. All rights reserved.
//

import UIKit

enum WorkoutPart: String, EnumCollection {
    
    case warmup = "Warm Up"
    case run = "Run"
    case walk = "Walk"
    case cooldown = "Cooldown"
    
}

class WorkoutSection: NSObject, NSCoding {
    
    var _sectionType : WorkoutPart!
    var _sectionLength : Int!
    var _workoutDetails: WorkoutDetails!
    
    required init(sectionType: WorkoutPart, sectionLength: Int, details: WorkoutDetails) {
        _sectionType = sectionType
        _sectionLength = sectionLength
        _workoutDetails = details
        super.init()
    }
    
    //MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        _sectionType = WorkoutPart(rawValue: (aDecoder.decodeObject(forKey: "sectionType") as! String))!
        _sectionLength = aDecoder.decodeInteger(forKey: "sectionLength")
        _workoutDetails = aDecoder.decodeObject(forKey: "workoutDetails") as! WorkoutDetails
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_sectionType.rawValue, forKey: "sectionType")
        aCoder.encode(_sectionLength!, forKey: "sectionLength")
        aCoder.encode(_workoutDetails, forKey: "workoutDetails")
    }
}

