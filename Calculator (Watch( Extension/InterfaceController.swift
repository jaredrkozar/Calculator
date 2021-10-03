//
//  InterfaceController.swift
//  Calculator (Watch( Extension
//
//  Created by Jared Kozar on 9/16/21.
//

import WatchKit
import Foundation
import SwiftyMathParser

class InterfaceController: WKInterfaceController {
    @IBOutlet var equation: WKInterfaceLabel!
    @IBOutlet var clearButton: WKInterfaceButton!
    var equationText: String = ""
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        equationText = "Enter a number"
        equation.setText(equationText)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        NotificationCenter.default.addObserver(self, selector: #selector(MessageReceived), name: NSNotification.Name("MessageReceived"), object: nil)
    }
    
    @objc func MessageReceived() {
        if UserDefaults.standard.integer(forKey: "matchPhoneTint") == 1 {
            clearButton.setBackgroundColor(UserDefaults.standard.color(forKey: "regularColor")?.withAlphaComponent(0.7))
        } else {
            clearButton.setBackgroundColor(UIColor.darkGray.withAlphaComponent(1.0))
        }
        
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    //append numbers
    @IBAction func zeroTapped() {
        numberTapped(number: "0")
    }
    
    @IBAction func oneTapped() {
        numberTapped(number: "1")
    }
    
    @IBAction func twoTapped() {
        numberTapped(number: "2")
    }
    
    @IBAction func threeTapped() {
        numberTapped(number: "3")
    }
    
    @IBAction func fourTapped() {
        numberTapped(number: "4")
    }
    
    @IBAction func fiveTapped() {
         numberTapped(number: "5")
    }
    
    @IBAction func sixTapped() {
        numberTapped(number: "6")
    }
    
    @IBAction func sevenTapped() {
        numberTapped(number: "7")
    }
    
    @IBAction func eightTapped() {
        numberTapped(number: "8")
    }
    
    @IBAction func nineTapped() {
        numberTapped(number: "9")
    }
    
    //append operators
    
    
    @IBAction func appendDecimal() {
        numberTapped(number: ".")
    }
    @IBAction func divideTapped() {
        numberTapped(number: "/")
    }
    
    @IBAction func multiplyTapped() {
        numberTapped(number: "*")
    }
    
    @IBAction func subtractTapped() {
        numberTapped(number: "-")
    }
    
    @IBAction func addTapped() {
        numberTapped(number: "+")
    }
    
    @IBAction func clearButtonTapped() {
        equationText = "Enter a number"
        equation.setText(equationText)
    }
    
    func numberTapped(number: String) {
        if equationText == "Enter a number" {
            equationText = ""
           equation.setText(equationText)
        }
        
        equationText.append("\(number)")
        
       equation.setText(equationText)
    }
    
    @IBAction func equalsButtonTapped() {
        
        equation.setText("\(equationText) = \(Parser.parseEquation(equation: equationText))")
    }
}
