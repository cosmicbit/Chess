//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoard {
    let numberOfCells = 64
    let numberOfPieces = 32
    let numberOfPawns = 16
    let numberOfRooks = 4
    let numberOfKnights = 4
    let numberOfBishops = 4
    let numberOfQueens = 2
    let numberOfKings = 2
    let numberCellsColors = 2
    let numberOfPieceColors = 2
    let rowRange = 0..<8
    let columnRange = 0..<8
    
    var cells: [[ChessBoardCell]]
    var blackPieces: [ChessPiece]
    var whitePieces: [ChessPiece]
    var chessPieces: [ChessPiece]
    
    init() {
        self.blackPieces = ChessPiece.getBlackPieces()
        self.whitePieces = ChessPiece.getWhitePieces()
        self.chessPieces = blackPieces + whitePieces
        cells = []
        for i in 0..<8 {
            var row: [ChessBoardCell] = []
            for j in 0..<8 {
                let cell = ChessBoardCell(location: ChessBoardLocation(row: i, column: j))
                row.append(cell)
            }
            cells.append(row)
        }
        //cells = cells.sorted(by: { $0.location < $1.location })
        
        print("Chess Board is initialized with \(cells[0].count) cells.")
        chessPieces.forEach { piece in
            let i = piece.location.row
            let j = piece.location.column
            cells[i][j].piece = piece

        }
    }
    
    func snapshot() {
        print("--- Board Info: -----")
        print("Cell count: ", cells.count)
        print("Pieces Count:", chessPieces.count)
        for i in 0..<8 {
            for j in 0..<8 {
                print("\(cells[i][j].location.getLocationAsString()) has ", terminator: "")
                if let piece = cells[i][j].piece {
                    print("Piece = \(piece.color.rawValue) \(piece.type.rawValue)")
                } else {
                    print("Piece = Blank")
                }
            }
        }
    }
}

extension ChessBoard {
    func getLegalMoves(for piece: ChessPiece) -> [ChessMove] {
        let potentialMoves = piece.getAllMoves()
        var legalMoves: [ChessMove] = []
        let location = piece.location
        
        switch piece.type {
            
        case .king:
            
            let sameRow = location.row
            let upRow = location.row - 1
            let downRow = location.row + 1
            
            let sameColumn = location.column
            let rightColumn = location.column + 1
            let leftColumn = location.column - 1
            
            if isThisCellValidToMove(row: upRow, column: leftColumn) {
                let endLocation = ChessBoardLocation(row: upRow, column: leftColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: upRow, column: rightColumn) {
                let endLocation = ChessBoardLocation(row: upRow, column: rightColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: downRow, column: rightColumn) {
                let endLocation = ChessBoardLocation(row: downRow, column: rightColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: downRow, column: leftColumn) {
                let endLocation = ChessBoardLocation(row: downRow, column: leftColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: upRow, column: sameColumn) {
                let endLocation = ChessBoardLocation(row: upRow, column: sameColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            
            if isThisCellValidToMove(row: sameRow, column: rightColumn) {
                let endLocation = ChessBoardLocation(row: sameRow, column: rightColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: downRow, column: sameColumn) {
                let endLocation = ChessBoardLocation(row: downRow, column: sameColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
            if isThisCellValidToMove(row: sameRow, column: leftColumn) {
                let endLocation = ChessBoardLocation(row: sameRow, column: leftColumn)
                legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
            }
            
        case .queen:
            var skipU = false
            var skipR = false
            var skipD = false
            var skipL = false
            var skipUL = false
            var skipUR = false
            var skipDL = false
            var skipDR = false
            
            for i in 1..<8 {
                
                let sameRow = location.row
                let sameColumn = location.column
                let upRow = location.row - i
                let downRow = location.row + i
                let rightColumn = location.column + i
                let leftColumn = location.column - i
                
                if isThisCellInChessBoardRange(row: upRow, column: leftColumn) &&
                   !skipUL {
                    print("UL", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipUL = true
                    }
                } else {
                    print("NO UL")
                }
                
                if isThisCellInChessBoardRange(row: upRow, column: rightColumn) &&
                   !skipUR {
                    print("UR", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipUR = true
                    }
                } else {
                    print("NO UR")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: rightColumn) &&
                   !skipDR {
                    print("DR", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipDR = true
                    }
                } else {
                    print("NO DR")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: leftColumn) &&
                   !skipDL {
                    print("DL", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipDL = true
                    }
                } else {
                    print("NO DL")
                }
                
                if isThisCellInChessBoardRange(row: upRow, column: sameColumn) &&
                   !skipU {
                    print("U", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: sameColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: sameColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipU = true
                    }
                } else {
                    print("NO U")
                }
                
                if isThisCellInChessBoardRange(row: sameRow, column: rightColumn) &&
                   !skipR {
                    print("R", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: sameRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: sameRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipR = true
                    }
                } else {
                    print("NO R")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: sameColumn) &&
                   !skipD {
                    print("D", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: sameColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: sameColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipD = true
                    }
                } else {
                    print("NO D")
                }
                
                if isThisCellInChessBoardRange(row: sameRow, column: leftColumn) &&
                   !skipL {
                    print("L", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: sameRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: sameRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipL = true
                    }
                } else {
                    print("NO L")
                }
            }
        case .bishop:
            print(location.getLocationAsString())
            
            var skipUL = false
            var skipUR = false
            var skipDL = false
            var skipDR = false
            
            for i in 1..<8 {
                
                let upRow = location.row - i
                let downRow = location.row + i
                let rightColumn = location.column + i
                let leftColumn = location.column - i
                
                if isThisCellInChessBoardRange(row: upRow, column: leftColumn) &&
                   !skipUL {
                    print("UL", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipUL = true
                    }
                } else {
                    print("NO UL")
                }
                
                if isThisCellInChessBoardRange(row: upRow, column: rightColumn) &&
                   !skipUR {
                    print("UR", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipUR = true
                    }
                } else {
                    print("NO UR")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: rightColumn) &&
                   !skipDR {
                    print("DR", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipDR = true
                    }
                } else {
                    print("NO DR")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: leftColumn) &&
                   !skipDL {
                    print("DL", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipDL = true
                    }
                } else {
                    print("NO DL")
                }
            }
            
        case .knight:
            for move in potentialMoves {
                print(move)
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        case .rook:
            print(location.getLocationAsString())
            
            var skipU = false
            var skipR = false
            var skipD = false
            var skipL = false
            
            for i in 1..<8 {
                let sameRow = location.row
                let sameColumn = location.column
                let upRow = location.row - i
                let downRow = location.row + i
                let rightColumn = location.column + i
                let leftColumn = location.column - i
                
                if isThisCellInChessBoardRange(row: upRow, column: sameColumn) &&
                   !skipU {
                    print("U", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: upRow, column: sameColumn) {
                        let endLocation = ChessBoardLocation(row: upRow, column: sameColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipU = true
                    }
                } else {
                    print("NO U")
                }
                
                if isThisCellInChessBoardRange(row: sameRow, column: rightColumn) &&
                   !skipR {
                    print("R", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: sameRow, column: rightColumn) {
                        let endLocation = ChessBoardLocation(row: sameRow, column: rightColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipR = true
                    }
                } else {
                    print("NO R")
                }
                
                if isThisCellInChessBoardRange(row: downRow, column: sameColumn) &&
                   !skipD {
                    print("D", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: downRow, column: sameColumn) {
                        let endLocation = ChessBoardLocation(row: downRow, column: sameColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipD = true
                    }
                } else {
                    print("NO D")
                }
                
                if isThisCellInChessBoardRange(row: sameRow, column: leftColumn) &&
                   !skipL {
                    print("L", terminator: " ")
                    if !isThisCellHaveAnyPieceOnIt(row: sameRow, column: leftColumn) {
                        let endLocation = ChessBoardLocation(row: sameRow, column: leftColumn)
                        legalMoves.append(ChessMove(startLocation: location, endLocation: endLocation, piece: piece))
                    } else {
                        skipL = true
                    }
                } else {
                    print("NO L")
                }
            }
        case .pawn:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        }
        
        
        
        
        return legalMoves
    }
    
    private func doesConflictWithTeam(move: ChessMove, myColor: ChessPieceColor) -> Bool {
        let i = move.endLocation.row
        let j = move.endLocation.column
        print(i ,j)
        
        if cells[i][j].piece?.color == myColor {
            return true
        } else {
            return false
        }
    }
    
    private func isThisCellHaveAnyPieceOnIt(row: Int, column: Int) -> Bool {
        print("Is Cell have Piece Check: ", row, column)
        if let _ = cells[row][column].piece {
            return true
        }
        
        return false
    }
    
    private func isThisCellInChessBoardRange(row: Int, column: Int) -> Bool {
        print("Is Cell in Board Check: ", row, column)
        return rowRange.contains(row) && columnRange.contains(column)
    }
    
    private func isThisCellValidToMove(row: Int, column: Int) -> Bool {
        if isThisCellInChessBoardRange(row: row, column: column) {
            print("UL", terminator: " ")
            if !isThisCellHaveAnyPieceOnIt(row: row, column: column) {
                return true
            }
        }
        
        return false
    }
}
