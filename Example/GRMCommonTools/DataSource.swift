//
//  DataSource.swift
//  Bloater
//
//  Created by Frederick Lee on 20/06/2017.
//  Copyright © 2017 Grimmsoft. All rights reserved.
//

import Foundation
import GRMCommonTools

class DataSource: CollectionViewDataSource {

    let users = ["Cell #1", "Cell #2", "Cell #3"]

    override func cellClasses() -> [CollectionViewCell.Type] {
        return [DefaultCell.self]
    }

    override func headerClasses() -> [CollectionViewCell.Type]? {
        return [HeaderCell.self]
    }

    override func footerClasses() -> [CollectionViewCell.Type]? {
        return [FooterCell.self]
    }

    override func sections() -> [[Any]]? {
        return [users]
    }

    override func item(_ indexPath: IndexPath) -> Any? {
        return self.users[indexPath.item]
    }

}
