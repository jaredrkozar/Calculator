//
//  RoundingTableViewController.swift
//  Calculator
//
//  Created by Jared Kozar on 5/20/21.
//

import UIKit
import Communicator

class RoundingPickerController: UITableViewController {

    @IBOutlet var roundValue: UILabel!
    @IBOutlet var roundSlider: UISlider!
    
    var selectedRound: String = ""
    var selectedRoundValue: Double = 0
    
    override func viewDidLoad() {
        
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()
        
        //gets the number of decimal places, and sets the UISlider to that value.
        roundSlider.minimumTrackTintColor = currenttheme.regularcolor
        roundSlider.value = Float(roundingPlaces)
        roundValue.text = "Number of Decimal Places: \(roundingPlaces)"
    }
    
    @IBAction func roundSliderChanged(_ sender: UISlider) {
        roundingPlaces = Int(roundSlider.value)
        //when the slider is changed, the roundvalue.text is set to the value is slider is at, and this value is saved in selectedRound
        roundValue.text = "Number of Decimal Places: \(roundingPlaces)"
        
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        UserDefaults.standard.set(roundSlider.value, forKey: "roundSlider")
        
        
        if matchPhoneRoundingValue == true {
            
             let message = ImmediateMessage(identifier: "message", content: ["roundingPlaces": roundingPlaces])
             
             Communicator.shared.send(message) { error in
                 print("Error sending immediate message", error)
             }
        }
       
        
    }
    

}
