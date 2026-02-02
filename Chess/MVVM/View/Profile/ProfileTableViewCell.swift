//
//  ProfileTextFieldTableViewCell.swift
//  Chess
//
//  Created by Philips Jose on 02/02/26.
//

import UIKit

class ProfileTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    public func configure(title: String) {
        label?.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
