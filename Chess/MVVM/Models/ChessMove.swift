//
//  ChessMove.swift
//  Chess
//
//  Created by Philips Jose on 11/11/25.
//

struct ChessMove {
    let startLocation: ChessBoardLocation
    let endLocation: ChessBoardLocation
    let piece: ChessPiece
    var isAttacking: Bool
    var capturedPiece: ChessPiece?
    var isPawnDoubleStep: Bool
    var isEnPassant: Bool
    var isCastling: Bool
    var isPromotion: Bool
    var promotionType: ChessPieceType?
    
    init(start: ChessBoardLocation,
             end: ChessBoardLocation,
             piece: ChessPiece,
             isAttacking: Bool = false,
             capturedPiece: ChessPiece? = nil,
             isPawnDoubleStep: Bool = false,
             isEnPassant: Bool = false,
             isCastling: Bool = false,
             isPromotion: Bool = false,
             promotionType: ChessPieceType? = nil)
        {
            self.startLocation = start
            self.endLocation = end
            self.piece = piece
            self.isAttacking = isAttacking
            self.capturedPiece = capturedPiece
            self.isPawnDoubleStep = isPawnDoubleStep
            self.isEnPassant = isEnPassant
            self.isCastling = isCastling
            self.isPromotion = isPromotion
            self.promotionType = promotionType
        }
}
