//
//  FontPickerController.swift
//  Calculator
//
//  Created by Jared Kozar on 6/12/21.
//

import UIKit

class FontPickerController: UITableViewController, UIFontPickerViewControllerDelegate {
    var fonts = ["SF Pro", "SF Pro Rounded", "Avenir", "New York", "Custom Font"]

    var font: UIFont!
    
    override func viewDidLoad() {
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()
        

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //finds the first instance of the currently selected font in the fonts array. If the index.row value equals the place of the currently selected font in the array, that row is given a checkmark accessory
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath)
        cell.textLabel?.text = fonts[indexPath.row]

        let fontIndex = fonts.firstIndex(of: "\(selectedFont)")

        if indexPath.row == fontIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //sets the currently selected font. If the user taps the "Custom Font" cell, the standard font picker appears. If the user selects a font from the list, the name of the font is stored in selectedFont, and is sent to the updateFont function in ViewController, where it is applied to answer
        
        if indexPath.row == 4 {
            let fontPicker = UIFontPickerViewController()
            fontPicker.delegate = self
            present(fontPicker, animated: true)
        } else {
            selectedFont = fonts[indexPath.row]
            NotificationCenter.default.post(name: Notification.Name( "updateFont"), object: nil)
            NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        // attempt to read the selected font descriptor, and gets the name of the font from the descriptor. The name of the font is stored in selectedFont, and is sent to the updateFont function in ViewController, where it is applied to answer.
        let descriptor = viewController.selectedFontDescriptor!
        let font = UIFont(descriptor: descriptor, size: 60)
        selectedFont = font.fontName
        
        NotificationCenter.default.post(name: Notification.Name( "updateFont"), object: nil)
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}
