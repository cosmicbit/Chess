//
//  ChessViewController.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessViewController: UIViewController {
    
    @IBOutlet private weak var playerOneCollectionView: UICollectionView!
    @IBOutlet private weak var boardCollectionView: UICollectionView!
    @IBOutlet private weak var playerTwoCollectionView: UICollectionView!
    
    public let viewModel = ChessViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.showAlert(title: Strings.Alerts.chessGameExitAlertTitle,
                       message: Strings.Alerts.chessGameExitAlertMessage
        ) { [weak self] ok in
            if ok {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func resetBoardButtonTapped(_ sender: Any) {
        self.viewModel.resetAll()
    }
}

extension ChessViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case boardCollectionView:
            return self.viewModel.board.cells.flatMap { $0 }.count
        case playerOneCollectionView:
            return self.viewModel.playerOneCapturedPieces.count
        case playerTwoCollectionView:
            return self.viewModel.playerTwoCapturedPieces.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == boardCollectionView {
            return self.configureBoardCell(for: collectionView, at: indexPath)
        }
        return self.configureCapturedPieceCell(for: collectionView, at: indexPath)
    }
    
    private func configureBoardCell(for cv: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: ChessBoardCollectionViewCell.id, for: indexPath) as! ChessBoardCollectionViewCell
        cell.configure(cell: viewModel.getCell(for: indexPath.item), piece: viewModel.getPiece(for: indexPath.item))
        return cell
    }
    
    private func configureCapturedPieceCell(for cv: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let isPlayerOne = (cv == playerOneCollectionView)
        let id = viewModel.getCapturedPieceCellID(isPlayerOne: isPlayerOne)
        let data = self.viewModel.getCapturedPieceData(isPlayerOne: isPlayerOne, index: indexPath.item)
        let cell = cv.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! CapturedPieceCell
        cell.configure(with: data.type.image(color: data.color), and: data.count)
        return cell
    }
    
}

extension ChessViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCollectionViewCell,
              let currentTappedCell = cell.chessBoardCell
        else { return }
        self.viewModel.didTapOnCell(currentTappedCell.location)
    }
}

extension ChessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case boardCollectionView:
            return self.viewModel.getCellSize(for: collectionView.bounds)
        case playerOneCollectionView, playerTwoCollectionView:
            return CGSize(width: 40, height: 50)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension ChessViewController: ChessViewModelDelegate {
    
    func viewModelDidChangeBoard(_ viewModel: ChessViewModel) {
        self.boardCollectionView.reloadData()
    }
    
    func viewModelDidCapturePiece(_ viewModel: ChessViewModel, capturedPieceArray: [CapturedPiece]) {
        switch capturedPieceArray {
        case self.viewModel.playerOneCapturedPieces:
            self.playerOneCollectionView.reloadData()
        case self.viewModel.playerTwoCapturedPieces:
            self.playerTwoCollectionView.reloadData()
        default:
            break
        }
    }
}
