//
//  CustomCalcButton.swift
//  Calculator
//
//  Created by JaredKozar on 1/5/22.
//

import UIKit

class CustomCalcButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 9.0
    }

    func changeColors(color: UIColor) {
        self.backgroundColor = color
    }
}
