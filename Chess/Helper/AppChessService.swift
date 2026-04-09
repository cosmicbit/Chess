//
//  AppChessService.swift
//  Chess
//
//  Created by Philips Jose on 08/04/26.
//

import ChessEngine

class AppChessService {

    static let shared = AppChessService()
    
    init () {
        self.initializeDelegate()
    }
    
    private func initializeDelegate() {
        ChessService.shared().delegate = self
    }
    
    public func printBoard() {
        ChessService.shared().printBoard()
    }
    
    public func startNewGame() {
        ChessService.shared().startNewGame()
    }
}

extension AppChessService: ChessServiceDelegate {
    
    func chessService(_ engine: ChessEngine.ChessService, didUpdateBoard fen: String, error: ChessEngine.ChessError?) {
        print("[INFO]: didUpdateBoard")
    }
    
    func chessService(_ engine: ChessEngine.ChessService, didFindBestMove move: String, error: ChessEngine.ChessError?) {
        print("[INFO]: didFindBestMove")
    }
    
    func chessService(_ engine: ChessEngine.ChessService, didGameOver winner: String?, error: ChessEngine.ChessError?) {
        print("[INFO]: didGameOver")
    }
    
    
}
