//
//  GameBoard.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 26/7/24.
//

import Foundation
import SwiftUI

class GameBoard {
    var width: Int
    var height: Int
    var grid: [[Color?]]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.grid = Array(repeating: Array(repeating: nil, count: width), count: height)
    }
    
    func isValidPosition(tetromino: Tetromino) -> Bool {
        for block in tetromino.blocks {
            if block.x < 0 || block.x >= width || block.y < 0 || block.y >= height || (grid[block.y][block.x] != nil) {
                return false
            }
        }
        return true
    }
    
    func placeTetromino(tetromino: Tetromino) {
        for block in tetromino.blocks {
            grid[block.y][block.x] = block.color
        }
    }
    
    func clearLines() -> Int {
        var linesCleared = 0
        var newGrid = grid
        
        for y in (0..<height).reversed() {
            if grid[y].allSatisfy({ $0 != nil }) {
                linesCleared += 1
                newGrid.remove(at: y)
                newGrid.insert(Array(repeating: nil, count: width), at: 0)
                print("Line cleared at row: \(y)")  // Prueba de impresión
            }
        }
        
        grid = newGrid
        return linesCleared
    }
}

