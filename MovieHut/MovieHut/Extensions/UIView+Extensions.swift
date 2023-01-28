//
//  UIView+Extensions.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
}
