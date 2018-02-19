//
//  ViewController.swift
//  NSKeyedArchiver
//
//  Created by Drew Westcott on 19/02/2018.
//  Copyright © 2018 Drew Westcott. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var sendButton: UIButton!
    
    //Create a workout area to store the sections in.
    var theWorkout = [WorkoutSection]()
    let localStorage = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let firstStage = WorkoutSection(sectionType: .warmup, sectionLength: 5)
        let secondStage = WorkoutSection(sectionType: .run, sectionLength: 25)
        let endStage = WorkoutSection(sectionType: .cooldown, sectionLength: 5)
        theWorkout.append( firstStage )
        theWorkout.append( secondStage )
        theWorkout.append( endStage )
        print(theWorkout.count)
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        let archivedWorkouts = NSKeyedArchiver.archivedData(withRootObject: theWorkout)
        localStorage.set(archivedWorkouts, forKey: "savedWorkouts")
        
        if let savedWorkouts = localStorage.object(forKey: "savedWorkouts") as? Data {
            theWorkout.removeAll()
            theWorkout = NSKeyedUnarchiver.unarchiveObject(with: savedWorkouts) as! [WorkoutSection]
            print("Read saved workouts from userdefaults with \(theWorkout.count) parts")
        }
        
    }

    @IBAction func sendAppContext() {
        //Check if session is active on to the watch.
        if ( WCSession.default.isPaired && WCSession.default.isWatchAppInstalled ) {
            
            do {
                // Archive the array to be able to send as a property list item.
                let archivedWorkouts = NSKeyedArchiver.archivedData(withRootObject: theWorkout)
                // Try sending via ApplicationContext of WatchConnectivity
                try WCSession.default.updateApplicationContext(["savedWorkouts" : archivedWorkouts as Data])
                print("Sent to watch")
            } catch {
                // TODO:  Not working, does the controller need to be aware of this?
            }
        }
    }

}


extension ViewController : WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session became active")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session became Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session deactivated")
    }
    
    
}
