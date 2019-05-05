//
//  InterfaceController.swift
//  HIIT timer WatchKit Extension
//
//  Created by Kashyap Kopparam on 14/4/19.
//  Copyright © 2019 Kashyap Kopparam. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var workInterval = 4.0
    var restInterval = 1.0
    var workCount = 0
    var restCount = 0
    var reset = false
    
    @IBOutlet weak var WorkoutLabel: WKInterfaceLabel!
    @IBOutlet weak var activityLabel: WKInterfaceLabel!

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
        WorkoutLabel.setText("Work: \(message["workoutInterval"] ?? "?") Rest: \(message["restInterval"] ?? "?")")
        workInterval = Double(message["workoutInterval"] as! Int)
        restInterval = Double(message["restInterval"]! as! Int)
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        activityLabel.setText("")
        WorkoutLabel.setText("Set a workout on the app")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    fileprivate func startWorkout(_ totalInterval: Double) {
        activityLabel.setText("Work \(workCount)")
        Timer.scheduledTimer( withTimeInterval: totalInterval, repeats: true) { timer in
            if self.reset {
                timer.invalidate()
            } else {
                self.workCount = self.workCount + 1
                self.activityLabel.setText("Work \(self.workCount)")
            }
        }
        Timer.scheduledTimer(withTimeInterval: workInterval, repeats: false) { timer in
            self.restCount = self.restCount + 1
            self.activityLabel.setText("Rest \(self.restCount)")
            Timer.scheduledTimer(withTimeInterval: totalInterval, repeats: true) { restTimer in
                if self.reset {
                    restTimer.invalidate()
                } else {
                    self.restCount = self.restCount + 1
                    self.activityLabel.setText("Rest \(self.restCount)")
                }
            }
            timer.invalidate()
        }
    }
    
    fileprivate func prepareForWorkout() {
        activityLabel.setText("Get ready!")
        
        var readyCountdown = 3
        Timer.scheduledTimer( withTimeInterval: 1.0, repeats: true) { timer in
            if readyCountdown == 0 {
                timer.invalidate()
                self.startWorkout(self.workInterval+self.restInterval)
            } else {
                self.activityLabel.setText("\(readyCountdown)")
                readyCountdown = readyCountdown - 1
            }
        }
    }
    
    @IBAction func startButton() {
        reset = false
        workCount = workCount + 1
        
        prepareForWorkout()
    }
    @IBAction func stopButton() {
        activityLabel.setText("Great workout!")
        reset = true
        workCount = 0
        restCount = 0
    }
}
