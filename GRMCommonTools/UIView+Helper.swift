//
//  UIView+Helper.swift
//  Pods
//
//  Created by Frederick Lee on 22/06/2017.
//
//

import UIKit

extension UIView {
    public var angle:CGFloat {
        let radians = atan2f(Float(self.transform.b), Float(self.transform.a))
        let degrees = radians * (180/Float.pi)
        return CGFloat(degrees)
    }

    open func rotateView(degrees:Float) {
        guard degrees != 0 else {
            self.transform = CGAffineTransform(rotationAngle: 0)
            return
        }
        let transformB = Float(self.transform.b)
        let transformA = Float(self.transform.a)
        let radians = atan2f(transformB, transformA)
        let currentDegrees = radians.toDegrees

        let angle = CGFloat((degrees + currentDegrees).toRadians)
        
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
}

extension Float {

    public var toRadians:Float {
        return self * .pi / 180
    }
    public var toDegrees:Float {
        return self * 180 / .pi
    }
}
