//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Jared Kozar on 9/7/21.
//

import UIKit

struct Sections {
    let title: String
    var settings: [SettingsOptions]
}

struct SettingsOptions {
    let title: String
    var option: String
    let icon: UIImage?
    let iconBGColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UITableViewController {
    
    var models = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = currenttheme.regularcolor
        navigationController?.navigationBar.tintColor = currenttheme.regularcolor
        
        tableView.rowHeight = 65
        configure()
        let nib = UINib(nibName: "SettingsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SettingsCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettingsText(_:)), name: NSNotification.Name( "updateSettingsText"), object: nil)
        
    }
    
    @objc func updateSettingsText(_ notification: Notification) {
        models[0].settings[0].option = "\(currenttheme.name)"
        models[0].settings[1].option = "\(themeName)"
        models[0].settings[2].option = "\(altIconName)"
        models[1].settings[0].option = "\(roundingPlaces)"
        models[1].settings[1].option = "\(selectedSound)"
        models[1].settings[2].option = "\(selectedFont)"
        
        tableView.reloadData()
    }
    

    func configure() {
        models.append(Sections(title: "Appearance", settings: [
            SettingsOptions(title: "Tint Color", option: "\(currenttheme.name)", icon: UIImage(systemName: "eyedropper.halffull"), iconBGColor: UIColor(named: "Blue")!) {
               
                let tintSettings = self.storyboard!.instantiateViewController(withIdentifier: "tintView") as! TintPickerController
                self.show(tintSettings, sender: true)
            },
            
            SettingsOptions(title: "Theme", option: "\(themeName)", icon: UIImage(systemName: "paintbrush"), iconBGColor: UIColor(named: "Red")!) {
                let themeSettings = self.storyboard!.instantiateViewController(withIdentifier: "themeView") as! ThemePickerController
                self.show(themeSettings, sender: true)
                
            },
            
            SettingsOptions(title: "App Icon", option: "\(altIconName)", icon: UIImage(systemName: "square.grid.2x2"), iconBGColor: UIColor(named: "Orange")!) {
               
                let appIconSettings = self.storyboard!.instantiateViewController(withIdentifier: "appIconView") as! AltIconPickerController
                self.show(appIconSettings, sender: true)
                
            },
        ]))
        
        
        models.append(Sections(title: "Advanced", settings: [
            
            SettingsOptions(title: "Rounding", option: "\(roundingPlaces) decimal places", icon: UIImage(systemName: "textformat.123"), iconBGColor: UIColor(named: "Yellow")!) {
                
                let roundingSettings = self.storyboard!.instantiateViewController(withIdentifier: "roundingView") as! RoundingPickerController
                self.show(roundingSettings, sender: true)
            },
            
            SettingsOptions(title: "Key Click Sound", option: "\(selectedSound)", icon: UIImage(systemName: "speaker.wave.2"), iconBGColor: UIColor(named: "Blue")!) {
              
                let keyClickSettings = self.storyboard!.instantiateViewController(withIdentifier: "keyClickView") as! KeyClickSoundController
                self.show(keyClickSettings, sender: true)
                
            },
            
            SettingsOptions(title: "Fonts", option: "\(selectedFont)", icon: UIImage(systemName: "textformat"), iconBGColor: UIColor(named: "Gray")!) {
                
                let fontSettings = self.storyboard!.instantiateViewController(withIdentifier: "fontView") as! FontPickerController
                self.show(fontSettings, sender: true)
                
            },
            
            SettingsOptions(title: "Apple Watch", option: "", icon: UIImage(systemName: "applewatch"), iconBGColor: UIColor(named: "Black")!) {
                
                let watchSettings = self.storyboard!.instantiateViewController(withIdentifier: "watchSettingsVIew") as! WatchSettingsViewController
                self.show(watchSettings, sender: true)
                
            },
            
        ]))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  models.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return models[section].settings.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].settings[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
            fatalError("Unable to dequeue the settings cell.")
        }
        
        cell.settingsCellIcon.image = model.icon
        cell.settingsCellIconContainer.backgroundColor = model.iconBGColor
        
        cell.settingsCellSection.text = model.title
        cell.settingsCellOptionLabel.text = model.option
        
        cell.settingsCellIconContainer.layer.cornerRadius = 9.0
        cell.settingsCellIcon.tintColor = UIColor.white
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = models[indexPath.section].settings[indexPath.row]
        model.handler()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
