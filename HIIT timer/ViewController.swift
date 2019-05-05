//
//  ViewController.swift
//  HIIT timer
//
//  Created by Kashyap Kopparam on 14/4/19.
//  Copyright © 2019 Kashyap Kopparam. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    @IBOutlet weak var workIntervalInput: UITextField!
    @IBOutlet weak var restIntervalInput: UITextField!
    @IBOutlet weak var setWorkoutButton: UIButton!
    func workIntervalInput(_ workIntervalInput: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func restIntervalInput(_ restIntervalInput: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        workIntervalInput.placeholder = "40"
        workIntervalInput.keyboardType = .numberPad
        restIntervalInput.placeholder = "20"
        restIntervalInput.keyboardType = .numberPad
        
        setWorkoutButton.addTarget(self, action: #selector(sendWorkout), for: .touchUpInside)
    }

    @objc func sendWorkout() {
        if (WCSession.default.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            let message = ["workoutInterval": Int(workIntervalInput.text ?? "0"), "restInterval": Int(restIntervalInput.text ?? "0")]
            WCSession.default.sendMessage(message as [String : Any], replyHandler: nil)
        }
    }
}
