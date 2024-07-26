import SwiftUI
import Combine


class TetrisViewModel: ObservableObject {
    @Published var gameBoard: GameBoard
    @Published var currentTetromino: Tetromino?
    @Published var score: Int = 0
    
    private var timer: AnyCancellable?
    
    init() {
        self.gameBoard = GameBoard(width: 10, height: 20)
        startGame()
    }
    
    func startGame() {
        spawnTetromino()
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().sink { _ in
            self.updateGame()
        }
    }
    
    func spawnTetromino() {
        let tetrominoTypes: [TetrominoType] = [.I, .O, .T, .S, .Z, .J, .L]
        let randomType = tetrominoTypes.randomElement()!
        let newTetromino = Tetromino(blocks: randomType.initialBlocks, type: randomType)
        
        if gameBoard.isValidPosition(tetromino: newTetromino) {
            currentTetromino = newTetromino
        } else {
            // Game over
            timer?.cancel()
        }
    }
    
    func updateGame() {
        guard let currentTetromino = currentTetromino else { return }
        
        var movedTetromino = currentTetromino
        movedTetromino.move(byX: 0, byY: 1)
        
        if gameBoard.isValidPosition(tetromino: movedTetromino) {
            self.currentTetromino = movedTetromino
        } else {
            gameBoard.placeTetromino(tetromino: currentTetromino)
            self.currentTetromino = nil
            score += gameBoard.clearLines()
            spawnTetromino()
        }
    }
    
    func moveTetromino(direction: MoveDirection) {
        guard let currentTetromino = currentTetromino else { return }
        
        var movedTetromino = currentTetromino
        switch direction {
        case .left:
            movedTetromino.move(byX: -1, byY: 0)
        case .right:
            movedTetromino.move(byX: 1, byY: 0)
        case .down:
            movedTetromino.move(byX: 0, byY: 1)
        case .drop:
            while gameBoard.isValidPosition(tetromino: movedTetromino) {
                movedTetromino.move(byX: 0, byY: 1)
            }
            movedTetromino.move(byX: 0, byY: -1)
        }
        
        if gameBoard.isValidPosition(tetromino: movedTetromino) {
            self.currentTetromino = movedTetromino
        }
    }
    
    func rotateTetromino() {
        guard let currentTetromino = currentTetromino else { return }
        
        var rotatedTetromino = currentTetromino
        rotatedTetromino.rotate()
        
        if gameBoard.isValidPosition(tetromino: rotatedTetromino) {
            self.currentTetromino = rotatedTetromino
        }
    }
}

enum MoveDirection {
    case left, right, down, drop
}
