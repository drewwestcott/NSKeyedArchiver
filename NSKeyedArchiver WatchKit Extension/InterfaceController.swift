//
//  InterfaceController.swift
//  NSKeyedArchiver WatchKit Extension
//
//  Created by Drew Westcott on 19/02/2018.
//  Copyright © 2018 Drew Westcott. All rights reserved.
//

import WatchKit
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    var theWorkout = [WorkoutSection]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
        session?.delegate = self
        session?.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController : WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch session activation")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Context received")
        if let archivedWorkouts = applicationContext["savedWorkouts"] as? Data {
            // We have received an encode workout oject
            print(archivedWorkouts)
            // Decode the object
            NSKeyedUnarchiver.setClass(WorkoutSection.self, forClassName: "WorkoutSection")
            let theWorkout = NSKeyedUnarchiver.unarchiveObject(with: archivedWorkouts) as! [WorkoutSection]
            print("Number of sections recieved \(theWorkout.count)")
        }
    }
    
}
