//
//  AltAppIconPicker.swift
//  Calculator
//
//  Created by Jared Kozar on 5/22/21.
//

import UIKit

class AltIconPickerController: UITableViewController {
    var altIcons = ["Default (Green)", "Red", "Blue", "Gray", "Black and White"]
    
    var selectedIcon: String = ""
    
    override func viewDidLoad() {
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return altIcons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //finds the first instance of the currently selected alternate icon in the altIcons array. If the index.row value equals the place of the currently selected alternate icon value in the array, that row is given a checkmark accessory
        let cell = tableView.dequeueReusableCell(withIdentifier: "altIconCell", for: indexPath)
        cell.textLabel?.text = altIcons[indexPath.row]
        
        
        let iconIndex = altIcons.firstIndex(of: "\(altIconName)")

        if indexPath.row == iconIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //sets the alternate app icon, and sets selectedIcon to the text of the row the user tapped. This is sent to the SettingsView, where it updates the label in the Alternate App Icons cell.
        if indexPath.row == 0 {
            UIApplication.shared.setAlternateIconName(nil)
        } else if indexPath.row == 1 {
            UIApplication.shared.setAlternateIconName("redicon")
        } else if indexPath.row == 2 {
            UIApplication.shared.setAlternateIconName("blueicon")
        } else if indexPath.row == 3 {
            UIApplication.shared.setAlternateIconName("grayicon")
        } else if indexPath.row == 4 {
            UIApplication.shared.setAlternateIconName("blackandwhiteicon")
            
        }
        
        selectedIcon = altIcons[indexPath.row]
        altIconName = selectedIcon
        
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
}
