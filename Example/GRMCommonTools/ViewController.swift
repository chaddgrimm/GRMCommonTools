//
//  ViewController.swift
//  GRMTools
//
//  Created by Chad on 06/21/2017.
//  Copyright (c) 2017 Chad. All rights reserved.
//

import UIKit
import GRMCommonTools

class ViewController: CollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataSource()
        self.title = "A Simple Collection View"

        refreshHandler = {
            print("Refresh the Collection View")
        }
    }

    override func headerSize(_ section: Int) -> CGSize {
        return .zero//CGSize(width: self.view.frame.width, height:30)
    }

    override func footerSize(_ section: Int) -> CGSize {
        return .zero//CGSize(width: self.view.frame.width, height:30)
    }

    override func cellSize(_ indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height:100)
    }

    
}

