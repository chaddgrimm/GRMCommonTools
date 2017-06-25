//
//  AnimateViewController.swift
//  GRMCommonTools
//
//  Created by Frederick Lee on 21/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import GRMCommonTools

class AnimateViewController: CollectionViewController {

    let leftContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let centerContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let rightContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()


    let buttonImageView:UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage.circle(diameter: 30, color:UIColor.black.withAlphaComponent(0.6))
        view.backgroundColor = .clear
        return view
    }()

    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "pier")
        //view.blur(radius: 3)
        view.contentMode = .scaleAspectFill
        return view
    }()

    let buttonContainerView:UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()

    let carretButton:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "caret").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .gray
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(pressCarret), for: .touchUpInside)
        return button
    }()

    let leftButton:UIButton = {
        let button = UIButton(type:.custom)


        let image = UIImage.circle(diameter: 30, color:UIColor.black.withAlphaComponent(0.4)).withRenderingMode(.alwaysTemplate)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hex: 0x6e6e6e)
        button.alpha = 1
        button.setTitle("A", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.anchorCenterToSuperview()
        button.alpha = 0
        return button
    }()

    let centerButton:UIButton = {
        let button = UIButton(type:.custom)


        let image = UIImage.circle(diameter: 30, color:UIColor.black.withAlphaComponent(0.4)).withRenderingMode(.alwaysTemplate)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hex: 0x6e6e6e)
        button.alpha = 1
        button.setTitle("B", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.anchorCenterToSuperview()
        button.alpha = 0
        return button
    }()

    let rightButton:UIButton = {
        let button = UIButton(type:.custom)
        let image = UIImage.circle(diameter: 30, color:UIColor.black.withAlphaComponent(0.4)).withRenderingMode(.alwaysTemplate)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hex: 0x6e6e6e)
        button.alpha = 1
        button.setTitle("C", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.anchorCenterToSuperview()
        button.alpha = 0
        return button
    }()

    let animateView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSubviews()
        setupBackgroundImage()
        configureButtons()
        setupCaretButton()
        dataSource = DataSource()
        self.title = "A Simple Collection View"

        refreshHandler = {
            print("Refresh the Collection View")
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        
    }

    override func headerSize(_ section: Int) -> CGSize {
        return .zero
    }

    override func footerSize(_ section: Int) -> CGSize {
        return .zero
    }

    override func cellSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height:100)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollOffset = scrollView.contentOffset.y
        let percentage = CGFloat(scrollOffset/250)
        let value = CGFloat(250 * percentage)

        if let navBar = self.navigationController?.navigationBar, let cell = collectionView?.cellForItem(at: IndexPath(item: 0, section: 0)){

            let rect = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: view.bounds.width, height: view.bounds.height)
            let rectA = cell.convert(rect, to: nil)
            let rectB = navBar.convert(navBar.bounds, to: nil)
            let intersect = rectA.intersects(rectB)

            if intersect {
                navigationController?.navigationBar.isOpaque = true
                navigationController?.navigationBar.barTintColor = .white
                navigationController?.navigationBar.backgroundColor = .white
                navigationController?.navigationBar.isTranslucent = false
                extendedLayoutIncludesOpaqueBars = false
                self.imageView.isHidden = true
            } else {
                navigationController?.navigationBar.isOpaque = false
                navigationController?.navigationBar.barTintColor = .clear
                navigationController?.navigationBar.backgroundColor = .clear
                navigationController?.navigationBar.isTranslucent = true
                extendedLayoutIncludesOpaqueBars = true
                self.imageView.isHidden = false
            }

            self.edgesForExtendedLayout = intersect ? [] : .all

            self.imageView.topConstraint?.constant = value
            self.imageView.heightConstraint?.constant = self.imageView.frame.width - value



        }
    }

    func pressCarret() {
        // Collapse
        if self.carretButton.transform != CGAffineTransform.identity {
            UIView.animate(withDuration: 0.2) {
                [weak self] in
                self?.rotateButtons(degrees:180)
            }
            self.updateAnchorsToViews([self.buttonImageView])
            self.carretButton.topConstraint?.constant = self.buttonImageView.center.y - (self.carretButton.frame.size.height/2)
            self.buttonContainerView.heightConstraint?.constant -= 32
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
                [weak self] in
                self?.setButtonsAlpha(0)
                self?.carretButton.rotateView(degrees: 0)
                self?.buttonImageView.transform = CGAffineTransform.identity
                self?.view.layoutIfNeeded()
            }) { finished in }

        // Expand
        } else {
            self.buttonContainerView.heightConstraint?.constant += 32
            self.updateAnchorsToViews([self.leftContainerView, self.centerContainerView, self.rightContainerView])
            self.carretButton.topConstraint?.constant = 3

            UIView.animate(withDuration: 0.2) {
                [weak self] in
                self?.setButtonsAlpha(1)
                self?.buttonImageView.transform = CGAffineTransform(scaleX: 18, y: 18)
                self?.carretButton.rotateView(degrees: 180)
                self?.view.layoutIfNeeded()
            }

            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
                [weak self] in
                self?.rotateButtons(degrees: 0)
            }) { finished in }

        }
    }

    private func updateAnchorsToViews(_ views: [UIView]) {
        if views.count == 1 {
            self.leftButton.anchorCenterToSuperview(views.first)
            self.centerButton.anchorCenterToSuperview(views.first)
            self.rightButton.anchorCenterToSuperview(views.first)
        } else if views.count == 3 {
            self.leftButton.anchorCenterToSuperview(views[0])
            self.centerButton.anchorCenterToSuperview(views[1])
            self.rightButton.anchorCenterToSuperview(views[2])
        }
    }

    private func rotateButtons(degrees d:Float) {
        self.leftButton.rotateView(degrees: d)
        self.centerButton.rotateView(degrees: d)
        self.rightButton.rotateView(degrees: d)
    }

    private func setButtonsAlpha(_ alpha:CGFloat) {
        self.leftButton.alpha = alpha
        self.centerButton.alpha = alpha
        self.rightButton.alpha = alpha
    }
}
