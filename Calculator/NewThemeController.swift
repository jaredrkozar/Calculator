//
//  NewThemeController.swift
//  NewThemeController
//
//  Created by Jared Kozar on 9/12/21.
//

import UIKit

class NewThemeController: UIViewController {
    let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTheme))
    
    var newthemeName: String = ""
    static var themeRegularColor: UIColor!
    static var themeOperatorColor: UIColor!
    
    @IBOutlet var nameTextField: UITextField!
    
    let regularColorWell: UIColorWell = {
        let colorwell = UIColorWell()
        colorwell.supportsAlpha = false
       
        colorwell.title = "Regular Color"
        colorwell.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 270, width: 40, height: 40)

        return colorwell
    }()
    
    let operatorColorWell: UIColorWell = {
        let colorwell = UIColorWell()
        colorwell.supportsAlpha = false
        
        colorwell.title = "Operator Color"
        colorwell.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 380, width: 40, height: 40)
        return colorwell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isCurrentlyEditingTheme == true {
            title = "Edit \( listofthemes[UserDefaults.standard.integer(forKey: "row")].name)"
            saveButton.isEnabled = true
            regularColorWell.selectedColor = NewThemeController.themeRegularColor
            operatorColorWell.selectedColor = NewThemeController.themeOperatorColor
        } else {
            title = "Add New Theme"
            saveButton.isEnabled = false
            regularColorWell.selectedColor = currenttheme.regularcolor
            operatorColorWell.selectedColor = currenttheme.operatorcolor
        }
        
        // Do any additional setup after loading the view.
        
        
        view.addSubview(regularColorWell)
        view.addSubview(operatorColorWell)
        
        constraints()
        nameTextField!.text = newthemeName ?? ""
        
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            
            operatorColorWell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
    
    @IBAction func beganEditing(_ sender: UITextField) {
        
        let dismissKeyboard = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),  style: .plain, target: self, action: #selector(endEditing))
        dismissKeyboard.accessibilityLabel = "Dismiss Keyboard"
        navigationItem.rightBarButtonItem = dismissKeyboard
        
    }
    
    @objc func endEditing() {
        //dismisses the keyboard
        saveButton.isEnabled = true
        view.resignFirstResponder()
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveTheme() {
        if isCurrentlyEditingTheme == true {
            listofthemes[UserDefaults.standard.integer(forKey: "row")] = Themes(name: nameTextField!.text!, regularcolor: regularColorWell.selectedColor!, operatorcolor: operatorColorWell.selectedColor!)
        } else {
            listofthemes.append( Themes(name: nameTextField!.text!, regularcolor: regularColorWell.selectedColor!, operatorcolor: operatorColorWell.selectedColor!))
        }
        
        NotificationCenter.default.post(name: Notification.Name( "newThemeAdded"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
}
