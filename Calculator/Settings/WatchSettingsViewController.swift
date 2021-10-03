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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        matchPhoneTintSwitch.onTintColor = currenttheme.regularcolor
        matchPhoneTintSwitch.isOn = matchPhoneTint
        matchPhoneTintSwitch.addTarget(self, action: #selector(toggleTintSwitch), for: .valueChanged)
       
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
    
}
