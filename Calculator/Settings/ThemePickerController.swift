//
//  ThemeTableViewController.swift
//  Calculator
//
//  Created by Jared Kozar on 5/22/21.
//

import UIKit

class ThemePickerController: UITableViewController {
    var themes = ["Match System Theme", "Light", "Dark"]
    
    override func viewDidLoad() {
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //finds the first instance of the currently selected theme in the themes array. If the index.row value equals the place of the currently selected theme value in the array, that row is given a checkmark accessory
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
        
        cell.textLabel?.text = themes[indexPath.row]
        
        let indexTheme = themes.firstIndex(of: "\(themes)")

        if indexPath.row == indexTheme {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //sets the theme of the app; keep the app in dark/light mode, or have it match the iOS' current theme. It also sets selectedTheme to the text of the row the user tapped. This is sent to the SettingsView, where it updates the label in the Theme cell.
        if indexPath.row == 0 {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified
            }
        } else if indexPath.row == 1 {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        } else if indexPath.row == 2 {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        
        themeName = themes[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
}
