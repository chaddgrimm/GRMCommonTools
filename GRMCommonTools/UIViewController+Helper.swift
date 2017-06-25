//
//  UIViewController+Helper.swift
//  Pods
//
//  Created by Frederick Lee on 24/06/2017.
//
//

import UIKit

extension UIViewController {

    public var statusBarFrame:CGRect {
        let statusBarFrame = UIApplication.shared.statusBarFrame
        return statusBarFrame
    }

    public var navigationBarFrame:CGRect? {
        return navigationController?.navigationBar.frame
    }

}
