//
//  Item.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
