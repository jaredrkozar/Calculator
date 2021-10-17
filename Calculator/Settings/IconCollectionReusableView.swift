//
//  IconCollectionReusableView.swift
//  IconCollectionReusableView
//
//  Created by JaredKozar on 10/17/21.
//

import UIKit

class IconCollectionReusableView: UICollectionReusableView {
    static let identifier = "IconCollectionReusableView"
    
    static func nib() -> UINib {
        return UINib(nibName: "IconCollectionReusableView", bundle: nil)
    }
    
    public let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        
        return label
    }()
    
    public func configure() {
        backgroundColor = .clear
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
