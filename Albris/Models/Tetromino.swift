//
//  Tetromino.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 26/7/24.
//

import Foundation


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
    
    mutating func adjustPosition(within width: Int, height: Int) {
        var xOffset = 0
        var yOffset = 0
        
        for block in blocks {
            if block.x < 0 {
                xOffset = max(xOffset, -block.x)
            } else if block.x >= width {
                xOffset = min(xOffset, width - 1 - block.x)
            }
            
            if block.y < 0 {
                yOffset = max(yOffset, -block.y)
            } else if block.y >= height {
                yOffset = min(yOffset, height - 1 - block.y)
            }
        }
        
        move(byX: xOffset, byY: yOffset)
    }
}
