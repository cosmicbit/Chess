//
//  ViewController.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var chessBoardCollectionView: UICollectionView!
    @IBOutlet weak var resetBoardButton: UIButton!
    
    private let viewModel = ChessViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    func setupUI() {
        resetBoardButton.layer.cornerRadius = 12
    }
    
    func bindViewModel() {
        
        viewModel.updateUI = { [weak self] in
            self?.chessBoardCollectionView.reloadData()
            
        }
    }

    @IBAction func resetBoardButtonTapped(_ sender: Any) {
        viewModel.resetAll()
    }
}

extension ViewController: UICollectionViewDataSource {
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
