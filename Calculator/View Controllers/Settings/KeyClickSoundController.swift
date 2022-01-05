//
//  KeyClickPicker.swift
//  Calculator
//
//  Created by Jared Kozar on 6/10/21.
//

import UIKit

class KeyClickSoundController: UITableViewController {
    var sounds = ["None", "Click", "Typewriter", "Coin"]

    override func viewDidLoad() {
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //finds the first instance of the currently selected sound in the sounds array. If the index.row value equals the place of the currently selected sound in the array, that row is given a checkmark accessory
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
        cell.textLabel?.text = sounds[indexPath.row]

        let soundIndex = sounds.firstIndex(of: "\(selectedSound)")

        if indexPath.row == soundIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //sets the sound effect when the user taps a key. This is sent to the playSoundEffect method in the GlobalSettings class.

         selectedSound = sounds[indexPath.row]
        
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}
