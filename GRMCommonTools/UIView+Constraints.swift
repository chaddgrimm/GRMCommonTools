//
//  UIView+Constraints.swift
//  Pods
//
//  Created by Frederick Lee on 21/06/2017.
//
//

import UIKit

@available(iOS 10.0, *)
extension UIView {

    public var heightConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .height}.first
    }

    public var widthConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .width}.first
    }

    public var topConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .top}.first
    }

    public var bottomConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .bottom}.first
    }

    public var leftConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .left}.first
    }

    public var rightConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .right}.first
    }

    public var leadingConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .leading}.first
    }

    public var trailingConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .trailing}.first
    }

    public var centerXConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .centerX}.first
    }

    public var centerYConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .centerY}.first
    }

    public var lastBaselineConstraint:NSLayoutConstraint? {
        return self.constraints.filter{$0.firstAttribute == .lastBaseline}.first
    }

    public func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }

    public func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
        anchorWithReturnAnchors(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }

    @discardableResult
    public func anchorWithReturnAnchors(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})

        return anchors
    }

    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
