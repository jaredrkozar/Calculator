//
//  Themes.swift
//  Themes
//
//  Created by Jared Kozar on 9/11/21.
//

import UIKit

public class Themes: NSObject, NSCoding {
    var name: String
    var regularcolor: UIColor
    var operatorcolor: UIColor
    
    init (name: String, regularcolor: UIColor, operatorcolor: UIColor) {
        self.name = name
        self.regularcolor = regularcolor
        self.operatorcolor = operatorcolor
    }
    
    required public init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        regularcolor = (aDecoder.decodeObject(forKey: "regularcolor") as? UIColor)!
        operatorcolor = (aDecoder.decodeObject(forKey: "operatorcolor") as? UIColor)!
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(regularcolor, forKey: "regularcolor")
        aCoder.encode(operatorcolor, forKey: "operatorcolor")
    }
}
