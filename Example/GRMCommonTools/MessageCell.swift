//
//  DefaultCell.swift
//  GRMTools
//
//  Created by Frederick Lee on 21/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import GRMCommonTools

class MessageCell:CollectionViewCell {

    override var item: Any? {
        didSet {
            guard let item = item as? String else {
                return
            }
            //label.text = item
        }
    }

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.font = UIFont.systemFont(ofSize: 18)
        //label.backgroundColor = .orange
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "You have one new message from your friend."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        //label.backgroundColor = .purple
        return label
    }()

    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()


    override func setupViews() {
        super.setupViews()

        addSubview(profileImageView)

        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 68, heightConstant: 68)

        profileImageView.anchorCenterYToSuperview()


        addSubview(dividerLineView)

        setupContainerView()
        //addSubview(label)
        //separatorLineView.alignmentRectInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        separatorLineView.isHidden = false
        //label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        separatorLineView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        backgroundColor = .white
    }

    func setupContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        addSubview(containerView)
        containerView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 90, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        containerView.anchorCenterYToSuperview()

        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)



//        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
//
//        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
//
//        containerView.addConstraintsWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
//
//        containerView.addConstraintsWithFormat("V:|[v0(24)]", views: timeLabel)
//
//        containerView.addConstraintsWithFormat("V:[v0(20)]|", views: hasReadImageView)

        timeLabel.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 80, heightConstant: 24)
        nameLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: timeLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        hasReadImageView.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 20, heightConstant: 20)


        messageLabel.anchor(top: nameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: hasReadImageView.leftAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)





    }

}
