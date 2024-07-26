import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TetrisViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("Reserve:")
                    .font(.headline)
                    .padding(.top)
                ReserveTetrominoView(tetromino: viewModel.reservedTetromino)
                    .frame(width: 60, height: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        viewModel.swapTetromino()
                    }
            }
            
            VStack {
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
                    .padding()
                
                GameBoardView(gameBoard: viewModel.gameBoard, currentTetromino: viewModel.currentTetromino)
                    .background(Color.gray)
                    .gesture(DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 20 {
                                        viewModel.moveTetromino(direction: .right)
                                    } else if gesture.translation.width < -20 {
                                        viewModel.moveTetromino(direction: .left)
                                    } else if gesture.translation.height > 20 {
                                        viewModel.moveTetromino(direction: .down)
                                    }
                                }
                                .onEnded { gesture in
                                    if gesture.translation.height < -20 {
                                        viewModel.moveTetromino(direction: .drop)
                                    }
                                }
                    )
                    .onTapGesture {
                        viewModel.rotateTetromino()
                    }
                    .padding()
                
                HStack {
                    Button(action: { viewModel.moveTetromino(direction: .left) }) {
                        Text("Left")
                    }
                    Button(action: { viewModel.rotateTetromino() }) {
                        Text("Rotate")
                    }
                    Button(action: { viewModel.moveTetromino(direction: .right) }) {
                        Text("Right")
                    }
                    Button(action: { viewModel.moveTetromino(direction: .down) }) {
                        Text("Down")
                    }
                }
                .padding()
            }
            
            VStack {
                Text("Next:")
                    .font(.headline)
                    .padding(.top)
                NextTetrominoView(tetromino: viewModel.nextTetromino)
                    .frame(width: 60, height: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct GameBoardView: View {
    let gameBoard: GameBoard
    let currentTetromino: Tetromino?
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<gameBoard.height, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<gameBoard.width, id: \.self) { column in
                        Rectangle()
                            .foregroundColor(self.colorForBlock(atRow: row, column: column))
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
    
    func colorForBlock(atRow row: Int, column: Int) -> Color {
        if let block = currentTetromino?.blocks.first(where: { $0.x == column && $0.y == row }) {
            return block.color
        } else {
            return gameBoard.grid[row][column] ?? Color.clear
        }
    }
}
