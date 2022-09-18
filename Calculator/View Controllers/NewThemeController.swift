//
//  NewThemeController.swift
//  NewThemeController
//
//  Created by Jared Kozar on 9/12/21.
//

import UIKit

class NewThemeController: UIViewController {

    let saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTheme))
        
        return button
    }()
    
    let closeKeyboardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),  style: .plain, target: self, action: #selector(endEditing))
        
        return button
    }()
    
    var index: Int?
    var newthemeName: String = ""
    static var themeRegularColor: UIColor!
    static var themeOperatorColor: UIColor!
    
    var customLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }
    
    var customStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        return stackView
    }
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 6.0
        textField.addTarget(self, action: #selector(beganEditing), for: .allEditingEvents)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Theme Name"
        return textField
    }()
    
    let regularColorWell: UIColorWell = {
        let colorwell = UIColorWell()
        colorwell.supportsAlpha = false
       
        colorwell.title = "Regular Color"
        colorwell.translatesAutoresizingMaskIntoConstraints = false

        return colorwell
    }()
    
    let operatorColorWell: UIColorWell = {
        let colorwell = UIColorWell()
        colorwell.supportsAlpha = false
        
        colorwell.title = "Operator Color"
        colorwell.translatesAutoresizingMaskIntoConstraints = false
        return colorwell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
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
        
        let nameLabel = customLabel
        nameLabel.text = "Name"
        
        let operatorLabel = customLabel
        operatorLabel.text = "Operator Color"
        
        let numberLabel = customLabel
        numberLabel.text = "Number Color"
        
        let textStackView = customStackView
        textStackView.alignment = .leading
        textStackView.addArrangedSubview(numberLabel)
        textStackView.addArrangedSubview(operatorLabel)
        textStackView.addArrangedSubview(nameLabel)
        
        let controlsStackView = customStackView
        controlsStackView.alignment = .trailing
        controlsStackView.addArrangedSubview(nameTextField)
        controlsStackView.addArrangedSubview(operatorColorWell)
        controlsStackView.addArrangedSubview(regularColorWell)
        
        view.addSubview(controlsStackView)
        view.addSubview(textStackView)
        nameTextField.text = newthemeName ?? ""
        
        navigationItem.rightBarButtonItem = saveButton
        
        NSLayoutConstraint.activate([
                   
                   nameTextField.widthAnchor.constraint(equalToConstant: 240),
                   nameTextField.heightAnchor.constraint(equalToConstant: 50),
                   
                   textStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                   textStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   textStackView.widthAnchor.constraint(equalToConstant: 250),
                   textStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                   
                   controlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                   controlsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   controlsStackView.leadingAnchor.constraint(equalTo: textStackView.trailingAnchor, constant: 0),
                   controlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
                   
                   
               ])
    }
    
    @objc func beganEditing() {
        
        let dismissKeyboard = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),  style: .plain, target: self, action: #selector(endEditing))
        dismissKeyboard.accessibilityLabel = "Dismiss Keyboard"
        navigationItem.rightBarButtonItem = dismissKeyboard
        
    }
    
    @objc func endEditing() {
        //dismisses the keyboard
        saveButton.isEnabled = true
        view.endEditing(true)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveTheme() {
        if isCurrentlyEditingTheme == true {
            listofthemes[UserDefaults.standard.integer(forKey: "row")] = Themes(name: nameTextField.text!, regularcolor: regularColorWell.selectedColor!, operatorcolor: operatorColorWell.selectedColor!)
        } else {
            listofthemes.append( Themes(name: nameTextField.text!, regularcolor: regularColorWell.selectedColor!, operatorcolor: operatorColorWell.selectedColor!))
        }
        
        NotificationCenter.default.post(name: Notification.Name( "newThemeAdded"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
}
