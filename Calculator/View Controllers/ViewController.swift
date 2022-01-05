//
//  ViewController.swift
//  Calculator
//
//  Created by Jared Kozar on 5/8/21.
//
 
import UIKit
import AVFoundation
import SwiftyMathParser

class ViewController: UIViewController {

    
    @IBOutlet var numberButtons: [CustomCalcButton]!
    
    @IBOutlet var operatorButtons: [CustomCalcButton]!
    
    let nc = NotificationCenter.default
    var historyNumsList = [String]()
    
    @IBOutlet weak var equation: UILabel!
    
    @IBOutlet var backspaceButton: UIButton!
    
    @IBOutlet var equalsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifications()
        setupButtons()

        //sets the tint color when the app is started.
        
        NotificationCenter.default.post(name: Notification.Name( "updateTint"), object: nil)
        
        NotificationCenter.default.post(name: Notification.Name( "updateFont"), object: nil)
        // Do any additional setup after loading the view.

        equation.adjustsFontSizeToFitWidth = true
    }
    
    func notifications() {
        //sends out notifications to functions in the ViewController class
        NotificationCenter.default.addObserver(self, selector: #selector(updateFont(_:)), name: NSNotification.Name( "updateFont"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateTint(_:)), name: NSNotification.Name( "updateTint"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateText(_:)), name: NSNotification.Name( "updateText"), object: nil)

    }
    
    func setupButtons() {
        //sets up the backspace button for when the app launches
        backspaceButton.isEnabled = false
        backspaceButton.alpha = 0.5
        equalsButton.isEnabled = false
        equalsButton.alpha = 0.5
    }
    
    @IBAction func tapNumbers(_ sender: UIButton) {
  
        //when the app is first started, "Enter a number" is displayed. When the users taps on a number, answer is set to that number. If the user selected an operation to perform, then answer.text displays the numbers that are tapped, and the operation that the user is performing
        
        checkAnswer()
        
        self.equation.text!.append(String(sender.tag-1))
        
//        mediumHaptics()
        backspaceButton.isEnabled = true
        backspaceButton.alpha = 1.0
    }
    
    @IBAction func decimalInsert(_ sender: UIButton) {
        //If anser.text is blank, and the user taps the decimal button, a decimal is inserted. Otherwise, the decimal is inserted after the current number.
        checkAnswer()
        
        self.equation.text!.append(".")
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        //if the clear button is tapped, the answer displays the default text ("Enter a number"), and the previous number, the currentNumber, the operation, and the answer, are all set to 0.
        
        equation.text = "Enter a number"
        
        setupButtons()
        
    }
    
    @IBAction func buttonSound(_ sender: UIButton) {
        //if a button is tapped, thr function finds what sound is saved using UserDefaults and plays that sound.

        playSoundEffect(selectedSound: selectedSound)
    }
    
    @IBAction func operationButtonTapped(_ sender: UIButton) {
        //this function enables the equals button when an operator button is tapped, and appends the operator that is tapped to the answer.
        checkAnswer()
        
        self.equation.text!.append(sender.currentTitle!)
        equalsButton.isEnabled = true
        equalsButton.alpha = 1.0

    }

    @IBAction func equalsButtonTapped(_ sender: Any) {
        //parse equation using SwiftyMathParser
        equation.text?.append(contentsOf: " = \(Parser.parseEquation(equation: equation.text!).round(places: roundingPlaces))")
        historyNums.append(equation.text!)
    }

    
    @objc func updateTint(_ notification: Notification) {
        //gets the current tint color of the number/operator buttons to the current theme's operator color and number color respectively. It also sets the navigation bar's tint color to the current theme's number color.
        
        numberButtons.forEach({$0.backgroundColor = currenttheme.regularcolor})

        operatorButtons.forEach({$0.backgroundColor = currenttheme.operatorcolor})
        
        view.tintColor = currenttheme.regularcolor
        navigationController?.navigationBar.tintColor = currenttheme.regularcolor
    }
    
    @objc func updateFont(_ notification: Notification) {
        //gets the currently selected font from the FontPickerController class, and if a font is selected, it sets the answer.text font to the selected font. Dynamic Text is enabled.
        
        if selectedFont != "" {
            let customFont = UIFont(name: "\(selectedFont)", size: 30)
            equation.adjustsFontSizeToFitWidth = true
            equation.font = UIFontMetrics.default.scaledFont(for: customFont!)
        }
    }
    
    @IBAction func backspaceTapped(_ sender: Any) {
        //if the backspace button is tapped, the last character in the answer is removed, and checkAnswer() is called to see if the answer is empty; if it is, the backspace button is disabled.
        equation.text!.removeLast()
        checkAnswer()
    }
    
    func checkAnswer() {
        //ifn the answer field is empty, disable the backspace button  and the equals button and prompt the user to enter a number
        if equation.text == "" {
            setupButtons()
            equation.text = "Enter a number"
        } else if equation.text == "Enter a number" {
            equation.text = ""
        }
    }
    
    @IBAction func moreOpsButton(_ sender: Any) {
        //brings up the More Operators sheet
        let vc = MoreOperatorsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let navigationController = UINavigationController(rootViewController: vc)
          
        if #available(iOS 15, *) {
            if let picker = navigationController.presentationController as? UISheetPresentationController {
                picker.detents = [.medium()]
                picker.prefersGrabberVisible = true
                picker.preferredCornerRadius = 5.0
                }
        } else {
            navigationController.modalPresentationStyle = UIModalPresentationStyle.popover
            navigationController.preferredContentSize = CGSize(width: 350, height: 100)
        }
           
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func updateText(_ notification: Notification) {
        //adds the special operator selected in the MoreOperatorsViewController class to the equation.
        checkAnswer()
        equation.text?.append(selectedSpecialOp)
    }
}
