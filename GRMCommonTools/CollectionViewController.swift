//
//  CollectionViewController.swift
//  Bloater
//
//  Created by Frederick Lee on 18/06/2017.
//  Copyright © 2017 Grimmsoft. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
open class CollectionViewCell: UICollectionViewCell {
    open var item: Any?
    open weak var controller: CollectionViewController?

    open var width:CGFloat?
    open var height:CGFloat = 50

    open let separatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        lineView.isHidden = true
        return lineView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    open func setupViews() {
        backgroundColor = .white
        clipsToBounds = true
        addSubview(self.separatorLineView)
        separatorLineView.anchor(top:nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

}

@available(iOS 10.0, *)
open class CollectionViewDataSource: NSObject {

    public var items: [Any]?

    open func cellClasses() -> [CollectionViewCell.Type] {
        return []
    }

    // Use this for custom setup of your cells
    open func cellClass(_ indexPath: IndexPath) -> CollectionViewCell.Type? {
        return nil
    }

    // Return header classes you'll use here
    open func headerClasses() -> [CollectionViewCell.Type]? {
        return []
    }

    /// Return footer classes you'll use here
    open func footerClasses() -> [CollectionViewCell.Type]? {
        return []
    }

    open func sections() -> [[Any]]? {
        return nil
    }

    open func item(_ indexPath: IndexPath) -> Any? {
        return items?[indexPath.item]
    }

    // Return custom header items here
    open func headerItem(_ section: Int) -> Any? {
        return nil
    }

    // Return custom footer items here
    open func footerItem(_ section: Int) -> Any? {
        return nil
    }


}

@available(iOS 10.0, *)
open class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented, you must be one of those who hate the Interface Builder.")
    }

    public init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    private struct Constants {
        static let defaultItemCellHeight:CGFloat = 150
        static let defaultHeaderHeight:CGFloat = 50
        static let defaultFooterHeight:CGFloat = 50
    }

    fileprivate class DefaultHeader: DefaultCell {

        override var item: Any? {
            didSet {
                if item == nil {
                    label.text = ""
                }
            }
        }

        override func setupViews() {
            super.setupViews()
            label.text = "Header Cell"
            label.textAlignment = .center
        }
    }

    fileprivate class DefaultFooter: DefaultCell {

        override var item: Any? {
            didSet {
                if item == nil {
                    label.text = ""
                }
            }
        }

        override func setupViews() {
            super.setupViews()
            label.text = "Footer Cell"
            label.textAlignment = .center
        }
    }

    fileprivate class DefaultCell: CollectionViewCell {

        override var item: Any? {
            didSet {
                if let text = item as? String {
                    label.text = text
                } else {
                    label.text = item.debugDescription
                }
            }
        }

        let label = UILabel()

        override func setupViews() {
            super.setupViews()
            addSubview(label)
            label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        }
    }

    fileprivate let headerCellId = "CollectionViewHeaderCell"
    fileprivate let itemCellId   = "CollectionViewItemCell"
    fileprivate let footerCellId = "CollectionViewFooterCell"

    open let activityIndicator:UIActivityIndicatorView = {
        let indicator              = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.hidesWhenStopped = true
        indicator.color            = .black
        return indicator
    }()

    open var layout: UICollectionViewFlowLayout? {
        get {
            return collectionViewLayout as? UICollectionViewFlowLayout
        }
    }

    open var refreshHandler:(()->())? {
        willSet {
            if newValue == nil {
                self.collectionView?.refreshControl = nil
            } else {
                let refreshControl = UIRefreshControl()
                refreshControl.layer.zPosition = -1
                refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
                self.collectionView?.refreshControl = refreshControl
            }
        }
    }

    open var dataSource: CollectionViewDataSource? {
        didSet {

            if let cellClasses = dataSource?.cellClasses() {
                for cellClass in cellClasses {
                    collectionView?.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
                }
            }

            if let headerClasses = dataSource?.headerClasses() {
                for headerClass in headerClasses {
                    collectionView?.register(headerClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(headerClass))
                }
            }

            if let footerClasses = dataSource?.footerClasses() {
                for footerClass in footerClasses {
                    collectionView?.register(footerClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: NSStringFromClass(footerClass))
                }
            }

            collectionView?.reloadData()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor      = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        self.collectionView?.alwaysBounceVertical = true

        self.view.addSubview(activityIndicator)
        self.activityIndicator.anchorCenterXToSuperview()
        self.activityIndicator.anchorCenterYToSuperview()

        self.collectionView?.register(DefaultCell.self, forCellWithReuseIdentifier: itemCellId)
        self.collectionView?.register(DefaultHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
        self.collectionView?.register(DefaultFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerCellId)

    }

    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.sections()?.count ?? 1
    }

    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.sections()?[section].count ?? 0
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // TODO: Always override this or else size will not be invoked
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = self.cellSize(indexPath)
        size.width = size.width == 0 ? self.view.frame.width : size.width
        if let dynamicHeight = self.dynamicHeightForIndexPath(indexPath) {
            return CGSize(width: size.width, height: dynamicHeight)
        }
        return size
    }

    open func dynamicHeightForIndexPath(_ indexPath:IndexPath) -> CGFloat? {
        return nil
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        var size = self.headerSize(section)
        size.width = size.width == 0 ? self.view.frame.width : size.width
        return size
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        var size = self.footerSize(section)
        size.width = size.width == 0 ? self.view.frame.width : size.width
        return size
    }

    open func cellSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: Constants.defaultItemCellHeight)
    }

    open func headerSize(_ section: Int) -> CGSize {
        return CGSize(width: 0, height: Constants.defaultHeaderHeight)
    }

    open func footerSize(_ section: Int) -> CGSize {
        return CGSize(width: 0, height: Constants.defaultFooterHeight)
    }

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:CollectionViewCell

        if let cls = dataSource?.cellClass(indexPath) {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! CollectionViewCell
        } else if let cellClasses = dataSource?.cellClasses(), cellClasses.count > indexPath.section {
            let cls = cellClasses[indexPath.section]
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! CollectionViewCell
        } else if let cls = dataSource?.cellClasses().first {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! CollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! CollectionViewCell
        }

        cell.controller = self
        cell.item = dataSource?.item(indexPath)
        return cell
    }



    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)

    }

    open override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView: CollectionViewCell
        if kind == UICollectionElementKindSectionHeader {
            if let classes = dataSource?.headerClasses(), classes.count > indexPath.section {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(classes[indexPath.section]), for: indexPath) as! CollectionViewCell
            } else if let cls = dataSource?.headerClasses()?.first {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! CollectionViewCell
            } else {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for:indexPath) as! CollectionViewCell
            }
            reusableView.item = dataSource?.headerItem(indexPath.section)
        } else {
            if let classes = dataSource?.footerClasses(), classes.count > indexPath.section {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(classes[indexPath.section]), for: indexPath) as! CollectionViewCell
            } else if let cls = dataSource?.footerClasses()?.first {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(cls), for: indexPath) as! CollectionViewCell
            } else {
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath) as! CollectionViewCell
            }
            reusableView.item = dataSource?.footerItem(indexPath.section)
        }
        reusableView.controller = self
        return reusableView
    }

    @objc private func refreshCollectionView() {
        refreshHandler?()
        collectionView?.refreshControl?.endRefreshing()
    }

}




