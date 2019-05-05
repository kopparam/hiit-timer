//
//  InterfaceController.swift
//  HIIT timer WatchKit Extension
//
//  Created by Kashyap Kopparam on 14/4/19.
//  Copyright © 2019 Kashyap Kopparam. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        activityLabel.setText("")
        totalInterval = workInterval + restInterval
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    let workInterval = 4.0
    let restInterval = 1.0
    var totalInterval = 0.0
    var workCount = 0
    var restCount = 0
    var reset = false
    
    @IBOutlet weak var activityLabel: WKInterfaceLabel!
    
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
                self.startWorkout(self.totalInterval)
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
