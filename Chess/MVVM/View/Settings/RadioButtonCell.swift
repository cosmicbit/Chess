//
//  RadioButtonCell.swift
//  Chess
//
//  Created by Philips Jose on 12/02/26.
//

import UIKit

class RadioButtonCell: UITableViewCell {

    static let id = TableViewCellIDs.radioButtonCellID
    
    @IBOutlet private weak var optionNameLabel: UILabel!
    @IBOutlet private weak var selectionStatusImageView: UIImageView!
    
    public func configure(viewModel: RadioButtonViewModel) {
        self.optionNameLabel.text = viewModel.optionName
        //self.selectionStatusImageView.isHighlighted = viewModel.selected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStatusImageView.image = selected ? UIImage(systemName: "circle.fill") : nil
        // Configure the view for the selected state
    }

}

struct RadioButtonViewModel {
    let optionName: String
    let selected: Bool
}
