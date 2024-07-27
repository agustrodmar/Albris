//
//  TetrisTests.swift
//  AlbrisTests
//
//  Created by Agustín Rodríguez Márquez on 27/7/24.
//

import XCTest
import SwiftUI // Importar SwiftUI para el tipo Color
@testable import Albris // Importar tu módulo principal

class TetrisTests: XCTestCase {
    func testClearLines() {
        let gameBoard = GameBoard(width: 10, height: 20)
        
        // Simular un estado del tablero con 4 líneas completas en la parte inferior
        gameBoard.grid[16] = Array(repeating: Color.red, count: 10)
        gameBoard.grid[17] = Array(repeating: Color.red, count: 10)
        gameBoard.grid[18] = Array(repeating: Color.red, count: 10)
        gameBoard.grid[19] = Array(repeating: Color.red, count: 10)
        
        let linesCleared = gameBoard.clearLines()
        
        XCTAssertEqual(linesCleared, 4, "Deberían haberse eliminado 4 líneas")
        
        // Verificar que las líneas se hayan eliminado y reemplazado correctamente
        for y in 0..<4 {
            XCTAssertTrue(gameBoard.grid[y].allSatisfy({ $0 == nil }), "La fila \(y) debería estar vacía")
        }
        
        print("Test completado: Se eliminaron \(linesCleared) líneas.")
    }
}
