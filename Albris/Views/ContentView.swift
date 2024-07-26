import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TetrisViewModel()
    
    var body: some View {
        ZStack {
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
            
            if viewModel.isGameOver {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Tu puntuación ha sido de: \(viewModel.score)")
                        .font(.title)
                        .padding()
                    Text("El record es de: \(viewModel.highScore)")
                        .font(.title)
                        .padding()
                    Button(action: {
                        viewModel.startGame()
                    }) {
                        Text("Reintentar")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
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



/*
 Solo me gustaría trabajar un poco la estética. Por ejemplo. Me gustaría que los botones Left Rotate Right y Down se mostraran correctamente. Actualmente se ven como apretados, creo que es por el constraint que sufren entre NetTetromino y ReserveTetromino, no me gustaría que le afectase... Por otro lado, me gustaría que el fondo blanco, fuese de un gris oscuro, como el modo oscuro de chat gpt, mientras que el gameBoard fuese negro. 
 */
