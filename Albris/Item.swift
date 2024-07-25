//
//  Item.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 25/7/24.
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
