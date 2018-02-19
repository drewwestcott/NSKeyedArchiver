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
    
    required init(sectionType: WorkoutPart, sectionLength: Int) {
        _sectionType = sectionType
        _sectionLength = sectionLength
        super.init()
    }
    
    //MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        _sectionType = WorkoutPart(rawValue: (aDecoder.decodeObject(forKey: "sectionType") as! String))!
        _sectionLength = aDecoder.decodeInteger(forKey: "sectionLength")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_sectionType.rawValue, forKey: "sectionType")
        aCoder.encode(_sectionLength!, forKey: "sectionLength")
    }
}

