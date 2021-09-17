//
//  Extensions.swift
//  Extensions
//
//  Created by Jared Kozar on 9/7/21.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()

private(set) var vc = TintPickerController()

public var selectedSpecialOp: String = ""

public var historyNums: [String] {
    //saves the color, for use throughout the app
    get{
        return UserDefaults.standard.stringArray(forKey: "historyNums") ?? [String]()
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "historyNums")
    }
}

public var isCurrentlyEditingTheme: Bool = false

public var listofthemes: [Themes] = [
    //default themes
    Themes(name: "Sunset", regularcolor: UIColor(named: "sunset-regular")!, operatorcolor: UIColor(named: "sunset-operator")!),
    Themes(name: "Ocean", regularcolor: UIColor(named: "ocean-regular")!, operatorcolor: UIColor(named: "ocean-operator")!)
]

//gets the current theme, if there's an error, load a special theme called "Error Theme
public var currenttheme: Themes = Themes(name: "", regularcolor: UIColor.clear, operatorcolor: UIColor.clear)


public var altIconName: String {
    get{
        return UserDefaults.standard.string(forKey: "altIcon") ?? "Default"
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "altIcon")
    }
}

public var themeName: String {
    get{
        return UserDefaults.standard.string(forKey: "theme") ?? "Match System Theme"
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "theme")
    }
}

public var roundingPlaces: Int {
    get{
        return UserDefaults.standard.integer(forKey: "roundingNum")
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "roundingNum")
    }
}


public var selectedSound: String {
    get{
        return UserDefaults.standard.string(forKey: "keyClickSound") ?? "None"
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "keyClickSound")
    }
}


public var selectedFont: String {
    get{
        return UserDefaults.standard.string(forKey: "font") ?? "SF Pro"
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "font")
    }
}

func mediumHaptics() {
    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
}

func playSoundEffect(selectedSound: String) {
    //plays the sound that's saved in the soundName variable (in the KeyClickPicker class)
    let pathToSound = Bundle.main.path(forResource: selectedSound, ofType: "mp3")!
    let url = URL(fileURLWithPath: pathToSound)
    
    //tries to play the sound effect, if the device can't, or an error occurs, an the console prints an error.
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer.play()
    } catch {
        print("Cannot play sound due to an internal error. Please contact Jared Kozar with details on how to reproduce the error.")
    }
}

extension Numeric {
    var data: Data {
        var bytes = self
        return Data(bytes: &bytes, count: MemoryLayout<Self>.size)
    }
}

extension Data {
    func object<T>() -> T { withUnsafeBytes{$0.load(as: T.self)} }
    var color: UIColor { .init(data: self) }
}

extension UIColor {
    convenience init(data: Data) {
        let size = MemoryLayout<CGFloat>.size
        self.init(red:   data.subdata(in: size*0..<size*1).object(),
                  green: data.subdata(in: size*1..<size*2).object(),
                  blue:  data.subdata(in: size*2..<size*3).object(),
                  alpha: data.subdata(in: size*3..<size*4).object())
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha) ?
        (red, green, blue, alpha) : nil
    }
    
    var data: Data? {
        guard let rgba = rgba else { return nil }
        return rgba.red.data + rgba.green.data + rgba.blue.data + rgba.alpha.data
    }
}

extension UserDefaults {
    func set(_ color: UIColor?, forKey defaultName: String) {
        guard let data = color?.data else {
            removeObject(forKey: defaultName)
            return
        }
        set(data, forKey: defaultName)
    }
    
    func color(forKey defaultName: String) -> UIColor? {
        data(forKey: defaultName)?.color
    }
}

extension UserDefaults {
    var backgroundColor: UIColor? {
        get { color(forKey: "backgroundColor") }
        set { set(newValue, forKey: "backgroundColor") }
    }
}

extension Array where Element == Themes {
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "listofthemes")
        }
    }
    
    mutating func load() -> [Themes] {
        if let savedThemes = UserDefaults.standard.object(forKey: "listofthemes") as? Data {
            if let decodedThemes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedThemes) as? [Themes] {
                self = decodedThemes
            }
        }
        return self
    }
}

extension Themes {
    func savecurrenttheme() {
        if let savedCurrentThemeData = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedCurrentThemeData, forKey: "currenttheme")
        }
    }
    
    func loadcurrenttheme() -> Themes {
        if let savedCurrentTheme = UserDefaults.standard.object(forKey: "currenttheme") as? Data {
            if let decodedCurrentTheme = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedCurrentTheme) as? Themes {
                currenttheme = decodedCurrentTheme
            }
        }
        return currenttheme
    }
}


