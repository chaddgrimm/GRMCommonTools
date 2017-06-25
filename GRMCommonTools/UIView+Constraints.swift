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
        let constraint = self.constraintsAffectingLayout(for: .vertical).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .height}.first
        return constraint
    }

    public var widthConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .width}.first
        return constraint
    }

    public var topConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .vertical).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .top}.first
        return constraint
    }

    public var bottomConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .vertical).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .bottom}.first
        return constraint
    }

    public var leftConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .left}.first
        return constraint
    }

    public var rightConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .right}.first
        return constraint
    }

    public var leadingConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .leading}.first
        return constraint
    }

    public var trailingConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .trailing}.first
        return constraint
    }

    public var centerXConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .centerX}.first
        return constraint
    }

    // Gets the view where this has a center X constraint
    public var centerXConstraintView:UIView? {
        let constraint = self.constraintsAffectingLayout(for: .horizontal).filter{type(of:$0.firstItem) == type(of:self) && $0.secondAttribute == .centerX}.first
        return constraint?.secondItem as? UIView
    }

    public var centerYConstraint:NSLayoutConstraint? {
        let constraint = self.constraintsAffectingLayout(for: .vertical).filter{type(of:$0.firstItem) == type(of:self) && $0.firstAttribute == .centerY}.first
        return constraint
    }

    // Gets the view where this has a center Y constraint
    public var centerYConstraintView:UIView? {
        let constraint = self.constraintsAffectingLayout(for: .vertical).filter{type(of:$0.firstItem) == type(of:self) && $0.secondAttribute == .centerY}.first
        return constraint?.secondItem as? UIView
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


    public func fillToSuperview(_ superview: UIView? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        var view = superview == nil ? self.superview : superview
        if let view = view {
            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
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

    @discardableResult
    public func anchorCenterXToSuperview(_ view:UIView? = nil, constant: CGFloat = 0) -> NSLayoutConstraint?  {
        translatesAutoresizingMaskIntoConstraints = false

        self.centerXConstraint?.isActive = false

        if let anchor = view?.centerXAnchor {
            let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
            constraint.isActive = true
            return constraint
        } else {
            if let anchor = superview?.centerXAnchor {
                let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
                constraint.isActive = true
                return constraint
            }
        }
        return nil
    }

    @discardableResult
    public func anchorCenterYToSuperview(_ view:UIView? = nil, constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false

        self.centerYConstraint?.isActive = false

        if let anchor = view?.centerYAnchor {
            let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
            constraint.isActive = true
            return constraint
        } else {
            if let anchor = superview?.centerYAnchor {
                let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
                constraint.isActive = true
                return constraint
            }
        }
        return nil
    }

    @discardableResult
    public func anchorCenterToSuperview(_ view:UIView? = nil,  constant: CGFloat = 0) -> [NSLayoutConstraint] {
        var anchors = [NSLayoutConstraint]()
        guard let xAnchors = anchorCenterXToSuperview(view, constant:constant), let yAnchors = anchorCenterYToSuperview(view, constant:constant) else {
            return anchors
        }
        return [xAnchors, yAnchors]
    }
}
