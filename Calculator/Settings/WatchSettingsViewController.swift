//
//  AppleWatchSettingsViewController.swift
//  AppleWatchSettingsViewController
//
//  Created by Jared Kozar on 9/17/21.
//

import UIKit
import Communicator

class WatchSettingsViewController: UITableViewController {

    @IBOutlet var matchPhoneTintSwitch: UISwitch!
    
    @IBOutlet var matchPhoneRoundingValueSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.tintColor = currenttheme.regularcolor
        
        matchPhoneTintSwitch.isOn = matchPhoneTint
        matchPhoneTintSwitch.addTarget(self, action: #selector(toggleTintSwitch), for: .valueChanged)
        
        matchPhoneRoundingValueSwitch.isOn = matchPhoneRoundingValue
        matchPhoneRoundingValueSwitch.addTarget(self, action: #selector(toggleRoundingValueSwitch), for: .valueChanged)
       
    }
    
    @objc func toggleTintSwitch() {
        if matchPhoneTintSwitch.isOn == true {
            matchPhoneTint = true
        } else {
            matchPhoneTint = false
        }
        
        let message = ImmediateMessage(identifier: "message", content: ["matchPhoneTintStatus": matchPhoneTint])
        
        Communicator.shared.send(message) { error in
            print("Error sending immediate message", error)
        }
        
    }
    
    @objc func toggleRoundingValueSwitch() {
        if matchPhoneRoundingValueSwitch.isOn == true {
            matchPhoneRoundingValue = true
        } else {
            matchPhoneRoundingValue = false
        }
        
        let message = ImmediateMessage(identifier: "message", content: ["matchPhoneRoundingValue": matchPhoneRoundingValueSwitch])
        
        Communicator.shared.send(message) { error in
            print("Error sending immediate message", error)
        }
        
    }
    
    
}
