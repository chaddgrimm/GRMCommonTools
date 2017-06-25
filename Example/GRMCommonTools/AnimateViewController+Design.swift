//
//  AnimateViewController+Design.swift
//  GRMCommonTools
//
//  Created by Frederick Lee on 23/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import GRMCommonTools

extension AnimateViewController {
    func setupBackgroundImage() {
        collectionView?.backgroundView = UIView()
        if let backgroundView = collectionView?.backgroundView {
            backgroundView.fillToSuperview()
            backgroundView.backgroundColor = .white
            backgroundView.addSubview(imageView)

            imageView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: nil, right: backgroundView.rightAnchor, topConstant: -264, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 800)
            imageView.anchorCenterXToSuperview()
        }
    }
    func setupSubviews() {
        collectionView?.addSubview(buttonContainerView)
        buttonContainerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 64)

        buttonContainerView.addSubview(buttonImageView)

        if let navBarHeight = self.navigationController?.navigationBar.frame.height {
            collectionView?.contentInset = UIEdgeInsets(top: (statusBarFrame.height + navBarHeight + 130), left: 0, bottom: 0, right: 0)
        }

        buttonImageView.anchor(top: buttonContainerView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        buttonImageView.anchorCenterXToSuperview()
    }

    
    func configureButtons() {

        buttonContainerView.addSubview(leftContainerView)
        buttonContainerView.addSubview(rightContainerView)
        buttonContainerView.addSubview(centerContainerView)

        leftContainerView.anchor(top: buttonImageView.topAnchor, left: nil, bottom: buttonContainerView.bottomAnchor, right: centerContainerView.leftAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)

        rightContainerView.anchor(top: buttonImageView.topAnchor, left: centerContainerView.rightAnchor, bottom: buttonContainerView.bottomAnchor, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)

        centerContainerView.anchor(top: buttonImageView.topAnchor, left: nil, bottom: buttonContainerView.bottomAnchor, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)
        centerContainerView.anchorCenterXToSuperview()

        buttonContainerView.addSubview(leftButton)
        buttonContainerView.addSubview(centerButton)
        buttonContainerView.addSubview(rightButton)

        leftButton.anchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        centerButton.anchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        rightButton.anchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)

        leftButton.anchorCenterToSuperview(buttonImageView)
        centerButton.anchorCenterToSuperview(buttonImageView)
        rightButton.anchorCenterToSuperview(buttonImageView)

        self.leftButton.rotateView(degrees: 180)
        self.centerButton.rotateView(degrees: 180)
        self.rightButton.rotateView(degrees: 180)

    }

    func setupCaretButton() {
        let buttonDimension:CGFloat = 15
        buttonContainerView.addSubview(carretButton)
        carretButton.anchor(top: buttonImageView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: buttonDimension, heightConstant: buttonDimension)
        carretButton.anchorCenterXToSuperview()

        collectionView?.layoutIfNeeded()
        self.carretButton.topConstraint?.constant = self.buttonImageView.center.y - (buttonDimension/2)
    }

    func setupNavBar() {

        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

    }

}
