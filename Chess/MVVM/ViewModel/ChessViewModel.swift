//
//  ChessViewModel.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import Foundation
import CoreGraphics

protocol ChessViewModelDelegate: AnyObject {
    func viewModelDidChangeBoard(_ viewModel: ChessViewModel)
    func viewModelDidCapturePiece(_ viewModel: ChessViewModel, capturedPieceArray: [CapturedPiece])
}

class ChessViewModel {
    
    private(set) var mode = PlayerMode.passAndPlay
    private(set) var board = ChessBoard()
    private(set) var lastTappedLocation: ChessBoardLocation?
    private(set) var playerOneCapturedPieces = [CapturedPiece]()
    private(set) var playerTwoCapturedPieces = [CapturedPiece]()
    
    public weak var delegate: ChessViewModelDelegate?
    
    init() {

    }
    
    public func getCapturedPieceCellID(isPlayerOne: Bool) -> String {
        isPlayerOne ? CollectionViewCellIDS.PlayerOneCPCell : CollectionViewCellIDS.PlayerTwoCPCell
    }
    
    public func getCapturedPieceData(isPlayerOne: Bool, index: Int) -> CapturedPiece {
        isPlayerOne ? self.playerOneCapturedPieces[index] : self.playerTwoCapturedPieces[index]
    }
    
    func setMode(mode: PlayerMode) {
        self.mode = mode
    }
    
    func getCell(for index: Int) -> ChessBoardCell {
        let rowIndex = index / 8
        let columnIndex = index % 8
        return self.board.cells[rowIndex][columnIndex]
    }
    
    func getPiece(for index: Int) -> ChessPiece? {
        let rowIndex = index / 8
        let columnIndex = index % 8
        return self.board.piece(at: .init(row: rowIndex, column: columnIndex))
    }
    
    func getPiece(in cell: ChessBoardCell) -> ChessPiece? {
        return self.board.piece(at: cell.location)
    }
    
    func getIndexPath(for location: ChessBoardLocation) -> Int {
        let item = location.row * 8 + location.column
        return item
    }
 
    func getCellSize(for collectionViewBounds: CGRect) -> CGSize {
        let cellSpacing: CGFloat = 0.5
        let marginSpacing: CGFloat = 0
        let numberOfCellsInARow: CGFloat = 8
        let totalHorizontalSpacing = (marginSpacing * 2) + (cellSpacing * (numberOfCellsInARow - 1))
        let widthAvailableForCells = collectionViewBounds.width - totalHorizontalSpacing
        let cellWidth = widthAvailableForCells / numberOfCellsInARow
        guard cellWidth > 0 else {
            return .zero
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func highlightCells(for moves: [ChessMove]) {
        moves.forEach {
            let state: ChessBoardCellState = $0.isAttacking ? .vulnerable : .highlighted
            self.board.cells[$0.endLocation.row][$0.endLocation.column].currectState = state
        }
        self.delegate?.viewModelDidChangeBoard(self)
    }
    
    func resetAll() {
        print("Reseting Board.....")
        self.board = ChessBoard()
        self.lastTappedLocation = nil
        self.delegate?.viewModelDidChangeBoard(self)
    }
    
    func didTapOnCell(_ currentTappedLocation: ChessBoardLocation) {
        
        // 1. If we tap a piece of the CURRENT player, always treat it as a "Selection"
        if let piece = self.board.piece(at: currentTappedLocation), piece.color == board.gameState.currentPlayer {
            self.board.resetCellColors()
            self.board.cells[currentTappedLocation.row][currentTappedLocation.column].currectState = .selected
            
            let legalMoves = self.board.getLegalMoves(for: piece, at: currentTappedLocation)
            self.highlightCells(for: legalMoves)
            self.lastTappedLocation = currentTappedLocation
            return
        }
        
        // 2. If we already have a selection and tap an empty square or enemy piece, try to move
        if let startLocation = lastTappedLocation {
            self.board.resetCellColors()
            let result = self.board.attemptMove(from: startLocation, to: currentTappedLocation)
            
            switch result {
            case .success(let move):
                if let capturedPiece = move.capturedPiece {
                    if capturedPiece.color == .white {
                        self.updateCapturedList(piece: capturedPiece, in: &playerOneCapturedPieces)
                        self.delegate?.viewModelDidCapturePiece(self, capturedPieceArray: playerOneCapturedPieces)
                    } else {
                        self.updateCapturedList(piece: capturedPiece, in: &playerTwoCapturedPieces)
                        self.delegate?.viewModelDidCapturePiece(self, capturedPieceArray: playerTwoCapturedPieces)
                    }
                }
                self.delegate?.viewModelDidChangeBoard(self)
            case .failure(let reason):
                print("Move Failed: \(reason)")
                self.delegate?.viewModelDidChangeBoard(self)
            }
            self.lastTappedLocation = nil
        }
    }
    
    func updateCapturedList(piece: ChessPiece, in list: inout [CapturedPiece])   {
        if let index = list.firstIndex(where: { $0.type == piece.type && $0.color == piece.color }) {
            list[index].count += 1
        } else {
            let newCaptured = CapturedPiece(type: piece.type, color: piece.color , count: 1)
            list.append(newCaptured)
        }
    }
    
}
