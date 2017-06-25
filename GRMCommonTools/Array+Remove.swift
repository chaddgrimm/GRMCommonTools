//
//  Array+Remove.swift
//  Pods
//
//  Created by Frederick Lee on 23/06/2017.
//
//

import Foundation

extension Array {
    @discardableResult
    public mutating func removeItem<U: Equatable>(_ item: U?) -> Bool {
        if let item = item {
            for (idx, objectToCompare) in self.enumerated() {  //in old swift use enumerate(self)
                if let to = objectToCompare as? U {
                    if item == to {
                        self.remove(at: idx)
                        return true
                    }
                }
            }
        }
        return false
    }
}
