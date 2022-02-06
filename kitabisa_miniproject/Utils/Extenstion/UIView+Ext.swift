//
//  UIView+Ext.swift
//  kitabisa_miniproject
//
//  Created by Galang Aji Susanto on 05/02/22.
//

import UIKit

extension UIView {
    
    func addCorner(cornerRadius: CornerOptions, shadow: Shadow){
        setupCorners(cornerRadius: cornerRadius)
        whichShadow(shadow)
    }
    
    private func setupCorners(cornerRadius: CornerOptions) {
        switch cornerRadius {
        case .small:
            layer.cornerRadius = 6
        case .medium:
            layer.cornerRadius = 12
        case .large:
            layer.cornerRadius = 33
        case .circle:
            layer.cornerRadius = frame.height / 2
        }
        let borderColor: UIColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    private func whichShadow(_ shadow: Shadow) {
        switch shadow {
        case .little:
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .zero
            layer.shadowRadius = 4.0
            layer.shadowOpacity = 0.2
            layer.masksToBounds = false
        case .medium:
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 4.0
            layer.shadowOpacity = 0.2
            layer.masksToBounds = false
        case .heavy:
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowRadius = 7.0
            layer.shadowOpacity = 0.2
            layer.masksToBounds = false
        case .none:
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .zero
            layer.shadowRadius = 0.0
            layer.shadowOpacity = 0.0
            layer.masksToBounds = false
        }
    }
}

enum CornerOptions {
    case small
    case medium
    case large
    case circle
}

enum Shadow {
    case little
    case medium
    case heavy
    case none
}
