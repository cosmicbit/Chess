//
//  ViewController.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var resetBoardButton: UIButton!
    
    private let viewModel = ChessViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showModeSelection()
    }
    
    func setupUI() {
        resetBoardButton.layer.cornerRadius = 12
    }
    
    private func showModeSelection() {
        let vc = ModeSelectionViewController()
        vc.setMode = {
            self.viewModel.mode = $0
        }
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func animatePiece(from startPath: IndexPath, to endPath: IndexPath) {
        // 1. Get the starting cell and the piece's view (e.g., ImageView)
        guard let startViewCell = collectionView.cellForItem(at: startPath) as? ChessBoardCollectionViewCell,
              let startPieceView = startViewCell.chessPieceImageView else { return }
        
        guard let endViewCell = collectionView.cellForItem(at: endPath) as? ChessBoardCollectionViewCell,
              let endPieceView = endViewCell.chessPieceImageView else { return }
        
        // 2. Determine the destination frame (in the collectionView's coordinate space)
        let endFrame = collectionView.convert(endPieceView.frame, from: endViewCell.contentView)

        // 3. Move the piece view from the cell to the collectionView's root view layer
        let animatingPieceView = UIImageView(image: startPieceView.image)
        animatingPieceView.frame = collectionView.convert(startPieceView.frame, from: startViewCell.contentView)
        collectionView.addSubview(animatingPieceView)
        
        // 4. Hide the piece in the starting cell immediately
        startPieceView.isHidden = true
        
        // 5. Animate the piece
        UIView.animate(withDuration: 0.3, animations: {
            // Move the animating view to the target cell's frame
            animatingPieceView.frame = endFrame
        }, completion: { _ in
           
            animatingPieceView.removeFromSuperview()
            self.collectionView.reloadData()//reloadItems(at: [startPath, endPath])
            
        })
    }

    @IBAction func resetBoardButtonTapped(_ sender: Any) {
        viewModel.resetAll()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.board.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChessBoardCollectionViewCell.id, for: indexPath) as? ChessBoardCollectionViewCell {
            let chessBoardCell = viewModel.getCell(for: indexPath)
            cell.configure(cell: chessBoardCell)
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCollectionViewCell,
              let currentTappedCell = cell.chessBoardCell
        else { return }
        viewModel.didTapOnCell(currentTappedCell)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize(for: collectionView.bounds)
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

extension ViewController: ChessViewModelDelegate {
    func viewModelDidChangeBoard(_ viewModel: ChessViewModel) {
        self.collectionView.reloadData()
    }
}
