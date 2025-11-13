//
//  ViewController.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet private weak var chessBoardCollectionView: UICollectionView!
    @IBOutlet weak var resetBoardButton: UIButton!
    
    private let viewModel = ChessViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    func setupUI() {
        resetBoardButton.layer.cornerRadius = 12
    }
    
    func bindViewModel() {
        viewModel.$lastTappedCell
            .receive(on: DispatchQueue.main)
            .sink { cell in
                //print("Reloading collectionView ....")
                self.chessBoardCollectionView?.reloadData()
                //self.viewModel.board.snapshot()
            }
            .store(in: &cancellables)
    }

    @IBAction func resetBoardButtonTapped(_ sender: Any) {
        viewModel.resetAll()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        viewModel.board.cells.forEach { row in
            count += row.count
        }
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChessBoardCollectionViewCell", for: indexPath) as! ChessBoardCollectionViewCell
        
        let rowIndex = indexPath.item / 8
        let columnIndex = indexPath.item % 8
        //let location = ChessBoardLocation(row: rowIndex, column: columnIndex)
        let chessBoardCell = viewModel.board.cells[rowIndex][columnIndex]
        cell.configure(cell: chessBoardCell)
        cell.backgroundColor = chessBoardCell.currentColor.uiColor
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rowIndex = indexPath.item / 8
        let columnIndex = indexPath.item % 8
        let location = ChessBoardLocation(row: rowIndex, column: columnIndex)
        print("(\(location.row), \(location.column)) => Tapped")
        
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardCollectionViewCell,
        let currentTappedCell = cell.chessBoardCell
        else { return }
        viewModel.didTapOnCell(currentTappedCell)
        
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing: CGFloat = 0.5
        let marginSpacing: CGFloat = 0
        let numberOfCellsInARow: CGFloat = 8
        let totalHorizontalSpacing = (marginSpacing * 2) + (cellSpacing * (numberOfCellsInARow - 1))
        let widthAvailableForCells = collectionView.bounds.width - totalHorizontalSpacing
        let cellWidth = widthAvailableForCells / numberOfCellsInARow
        guard cellWidth > 0 else {
                return .zero
            }
        return CGSize(width: cellWidth, height: cellWidth)
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
