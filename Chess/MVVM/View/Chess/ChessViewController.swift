//
//  ChessViewController.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var resetBoardButton: UIButton!
    
    public let viewModel = ChessViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.viewModel.delegate = self
    }
    
    func setupUI() {
        self.resetBoardButton.layer.cornerRadius = 12
    }
    
    func animatePiece(from startPath: IndexPath, to endPath: IndexPath) {
        // 1. Get the starting cell and the piece's view (e.g., ImageView)
        guard let startViewCell = self.collectionView.cellForItem(at: startPath) as? ChessBoardCollectionViewCell,
              let startPieceView = startViewCell.chessPieceImageView else { return }
        
        guard let endViewCell = self.collectionView.cellForItem(at: endPath) as? ChessBoardCollectionViewCell,
              let endPieceView = endViewCell.chessPieceImageView else { return }
        
        // 2. Determine the destination frame (in the collectionView's coordinate space)
        let endFrame = self.collectionView.convert(endPieceView.frame, from: endViewCell.contentView)

        // 3. Move the piece view from the cell to the collectionView's root view layer
        let animatingPieceView = UIImageView(image: startPieceView.image)
        animatingPieceView.frame = self.collectionView.convert(startPieceView.frame, from: startViewCell.contentView)
        self.collectionView.addSubview(animatingPieceView)
        
        // 4. Hide the piece in the starting cell immediately
        startPieceView.isHidden = true
        
        // 5. Animate the piece
        UIView.animate(withDuration: 0.3, animations: {
            // Move the animating view to the target cell's frame
            animatingPieceView.frame = endFrame
        }, completion: { _ in
           
            animatingPieceView.removeFromSuperview()
            self.collectionView.reloadData()
            
        })
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.showAlert(title: "Are you sure want to exit?", message: "The game progress will be lost") { [weak self] ok in
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
        return self.viewModel.board.cells.flatMap { $0 }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChessBoardCollectionViewCell.id, for: indexPath) as? ChessBoardCollectionViewCell {
            let chessBoardCell = self.viewModel.getCell(for: indexPath)
            let piece = self.viewModel.getPiece(for: indexPath)
            cell.configure(cell: chessBoardCell, piece: piece)
            return cell
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
        return self.viewModel.getCellSize(for: collectionView.bounds)
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
        self.collectionView.reloadData()
    }
}
