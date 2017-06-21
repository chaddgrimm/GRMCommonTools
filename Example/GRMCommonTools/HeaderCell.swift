//
//  HeaderCell.swift
//  GRMTools
//
//  Created by Frederick Lee on 21/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import GRMCommonTools

class HeaderCell:CollectionViewCell{
    override var item: Any? {
        didSet {
            guard let item = item as? String else {
                return
            }
            label.text = item
        }
    }

    let label:UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    override func setupViews() {
        super.setupViews()
        separatorLineView.isHidden = false
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
}
