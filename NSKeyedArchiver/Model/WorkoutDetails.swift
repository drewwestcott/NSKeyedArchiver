//
//  WorkoutType.swift
//  NSKeyedArchiver
//
//  Created by Drew Westcott on 22/02/2018.
//  Copyright © 2018 Drew Westcott. All rights reserved.
//

import UIKit

class WorkoutDetails: NSObject, NSCoding {
    
    var _workoutName: String!
    
    required init(name: String) {
        super.init()
        _workoutName = name
    }
    
    //MARK: NSCoding
    required init?(coder aDecoder: NSCoder) {
        _workoutName = aDecoder.decodeObject(forKey: "workoutName") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_workoutName, forKey: "workoutName")
    }

}
