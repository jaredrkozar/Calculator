//
//  SettingsCell.swift
//  SettingsCell
//
//  Created by Jared Kozar on 9/7/21.
//

import UIKit

class SettingsCell: UITableViewCell {

    
    @IBOutlet var settingsCellIconContainer: UIView!
    
    @IBOutlet var settingsCellIcon: UIImageView!
    
    @IBOutlet var settingsCellSection: UILabel!
    
    @IBOutlet var settingsCellOptionLabel: UILabel!
    
    func setUpContainer() {
        settingsCellIconContainer.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(with model: SettingsOptions) {
        
        settingsCellIconContainer.backgroundColor = model.iconBGColor
        settingsCellIcon.image = model.icon
        settingsCellOptionLabel.text = model.title
        settingsCellSection.text = model.option
        
    }
    
}
