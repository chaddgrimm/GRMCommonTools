//
//  UIColor+Helper.swift
//  Bloater
//
//  Created by Frederick Lee on 19/06/2017.
//  Copyright © 2017 Grimmsoft. All rights reserved.
//

import UIKit

extension UIColor {

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
}

extension CGColor {
    public class func colorWithHex(hex: Int) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
}
