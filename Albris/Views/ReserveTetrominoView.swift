//
//  ReserveTetrominoView.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 26/7/24.
//

import SwiftUI

struct ReserveTetrominoView: View {
    let tetromino: Tetromino?
    
    var body: some View {
        GeometryReader { geometry in
            if let tetromino = tetromino {
                let blockSize = min(geometry.size.width, geometry.size.height) / 4
                let offsetX = (geometry.size.width - blockSize * 4) / 2
                let offsetY = (geometry.size.height - blockSize * 4) / 2
                
                VStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<4, id: \.self) { column in
                                Rectangle()
                                    .foregroundColor(self.colorForBlock(atRow: row, column: column, tetromino: tetromino))
                                    .frame(width: blockSize, height: blockSize)
                            }
                        }
                    }
                }
                .frame(width: blockSize * 4, height: blockSize * 4)
                .background(Color.clear)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                EmptyView()
            }
        }
    }
    
    func colorForBlock(atRow row: Int, column: Int, tetromino: Tetromino) -> Color {
        // Centrar el tetromino dentro del 4x4
        let blocks = tetromino.blocks.map { ($0.x, $0.y) }
        let minX = blocks.map { $0.0 }.min() ?? 0
        let minY = blocks.map { $0.1 }.min() ?? 0
        
        if let block = tetromino.blocks.first(where: { $0.x - minX == column && $0.y - minY == row }) {
            return block.color
        } else {
            return Color.clear
        }
    }
}
