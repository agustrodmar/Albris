import SwiftUI
import Combine

class TetrisViewModel: ObservableObject {
    @Published var gameBoard: GameBoard
    @Published var currentTetromino: Tetromino?
    @Published var nextTetromino: Tetromino?
    @Published var reservedTetromino: Tetromino?
    @Published var score: Int = 0
    
    private var timer: AnyCancellable?
    private var hasSwapped: Bool = false
    
    init() {
        self.gameBoard = GameBoard(width: 10, height: 20)
        startGame()
    }
    
    func startGame() {
        nextTetromino = generateRandomTetromino()
        spawnTetromino()
        timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().sink { _ in
            self.updateGame()
        }
    }
    
    func generateRandomTetromino() -> Tetromino {
        let tetrominoTypes: [TetrominoType] = [.I, .O, .T, .S, .Z, .J, .L]
        let randomType = tetrominoTypes.randomElement()!
        return Tetromino(blocks: randomType.initialBlocks, type: randomType)
    }
    
    func spawnTetromino() {
        if let nextTetromino = nextTetromino {
            if gameBoard.isValidPosition(tetromino: nextTetromino) {
                currentTetromino = nextTetromino
                self.nextTetromino = generateRandomTetromino()
                hasSwapped = false
            } else {
                // Game over
                timer?.cancel()
            }
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
        rotatedTetromino.adjustPosition(within: gameBoard.width, height: gameBoard.height)
        
        if gameBoard.isValidPosition(tetromino: rotatedTetromino) {
            self.currentTetromino = rotatedTetromino
        }
    }
    
    func swapTetromino() {
        guard !hasSwapped, let currentTetromino = currentTetromino else { return }
        
        if let reservedTetromino = reservedTetromino {
            self.reservedTetromino = currentTetromino
            self.currentTetromino = reservedTetromino
        } else {
            self.reservedTetromino = currentTetromino
            spawnTetromino()
        }
        hasSwapped = true
    }
}



enum MoveDirection {
    case left, right, down, drop
}
