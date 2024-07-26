//
//  Model.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 26/7/24.
//

import Foundation
import SwiftUI

struct Block: Identifiable {
    let id = UUID()
    var x: Int
    var y: Int
    var color: Color
}

struct Tetromino {
    var blocks: [Block]
    var type: TetrominoType
    
    mutating func move(byX xOffset: Int, byY yOffset: Int) {
        for i in 0..<blocks.count {
            blocks[i].x += xOffset
            blocks[i].y += yOffset
        }
    }
    
    mutating func rotate() {
        // Rotación 90 grados
        let pivot = blocks[1]
        for i in 0..<blocks.count {
            let dx = blocks[i].x - pivot.x
            let dy = blocks[i].y - pivot.y
            blocks[i].x = pivot.x - dy
            blocks[i].y = pivot.y + dx
        }
    }
}

enum TetrominoType {
    case I, O, T, S, Z, J, L
    
    var color: Color {
        switch self {
        case .I: return .cyan
        case .O: return .yellow
        case .T: return .purple
        case .S: return .green
        case .Z: return .red
        case .J: return .blue
        case .L: return .orange
        }
    }
    
    var initialBlocks: [Block] {
        switch self {
        case .I:
            return [Block(x: 3, y: 0, color: self.color),
                    Block(x: 4, y: 0, color: self.color),
                    Block(x: 5, y: 0, color: self.color),
                    Block(x: 6, y: 0, color: self.color)]
        case .O:
            return [Block(x: 4, y: 0, color: self.color),
                    Block(x: 5, y: 0, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 5, y: 1, color: self.color)]
        case .T:
            return [Block(x: 4, y: 0, color: self.color),
                    Block(x: 3, y: 1, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 5, y: 1, color: self.color)]
        case .S:
            return [Block(x: 5, y: 0, color: self.color),
                    Block(x: 4, y: 0, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 3, y: 1, color: self.color)]
        case .Z:
            return [Block(x: 3, y: 0, color: self.color),
                    Block(x: 4, y: 0, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 5, y: 1, color: self.color)]
        case .J:
            return [Block(x: 3, y: 0, color: self.color),
                    Block(x: 3, y: 1, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 5, y: 1, color: self.color)]
        case .L:
            return [Block(x: 5, y: 0, color: self.color),
                    Block(x: 3, y: 1, color: self.color),
                    Block(x: 4, y: 1, color: self.color),
                    Block(x: 5, y: 1, color: self.color)]
        }
    }
}
