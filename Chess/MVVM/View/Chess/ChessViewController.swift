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
            return self.viewModel.getNonZeroPiecesCount(in: self.viewModel.playerOneCapturedPieces)
        case playerTwoCollectionView:
            return self.viewModel.getNonZeroPiecesCount(in: self.viewModel.playerTwoCapturedPieces)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case boardCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChessBoardCollectionViewCell.id, for: indexPath) as? ChessBoardCollectionViewCell {
                let chessBoardCell = self.viewModel.getCell(for: indexPath)
                let piece = self.viewModel.getPiece(for: indexPath)
                cell.configure(cell: chessBoardCell, piece: piece)
                return cell
            }
        case playerOneCollectionView:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCellIDS.PlayerOneCPCell,
                for: indexPath) as? CapturedPieceCell {
                cell.configure(with: UIImage(systemName: "person.fill"))
                return cell
            }
        case playerTwoCollectionView:
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCellIDS.PlayerTwoCPCell,
                for: indexPath) as? CapturedPieceCell {
                cell.configure(with: UIImage(systemName: "person.fill"))
                return cell
            }
        default:
            break
        }
        return UICollectionViewCell()
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
            return CGSize(width: 40, height: 40)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing: CGFloat = 0.5
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}

extension ChessViewController: ChessViewModelDelegate {
    
    func viewModelDidChangeBoard(_ viewModel: ChessViewModel) {
        self.boardCollectionView.reloadData()
    }
}
