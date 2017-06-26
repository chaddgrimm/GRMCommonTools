//
//  UIColor+Helper.swift
//  Bloater
//
//  Created by Frederick Lee on 19/06/2017.
//  Copyright © 2017 Grimmsoft. All rights reserved.
//

import UIKit

extension UIColor {

    var r:CGFloat {
        return CIColor(color: self).red
    }

    var g: CGFloat{
        return CIColor(color: self).green
    }

    var b: CGFloat{
        return CIColor(color: self).blue
    }

    var alpha: CGFloat{
        return CIColor(color: self).alpha
    }

    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }

    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

    convenience public init(hex:Int) {
        let red = CGFloat(UInt8((hex >> 16) & 0xff)) / 255.0
        let green = CGFloat(UInt8((hex >> 8) & 0xff)) / 255.0
        let blue = CGFloat(UInt8(hex & 0xff)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }

    // Returns black or white color based on the color provided (typically a background color)
    convenience public init(contrastForColor color:UIColor) {
        var space:CGFloat = 0
        // count the perceptive luminance (human eye favors green color)
        let luminance = Double(1 - ((0.299 * color.r) + (0.587 * color.g) + (0.114 * color.b)))
        if luminance < 0.5 {
            // bright colors there for, black font
            space = 0.0
        } else {
            // dark colors there for, white font
            space = 1.0
        }
        self.init(red:space, green:space, blue:space, alpha:1.0)
    }
}

extension CGColor {
    public class func colorWithHex(hex: Int) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
}
