//
//  ProfileTextFieldTableViewCell.swift
//  Chess
//
//  Created by Philips Jose on 02/02/26.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let id: String = "ProfileTableViewCell"
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    private var item: ProfileItem?
    private var avatar: UIImage?
    
    public func configure(item: ProfileItem? = nil, avatar: UIImage? = nil) {
        self.item = item
        self.avatar = avatar
        self.setupUI()
    }
    
    private func setupUI() {
        label?.text = item?.label
        textField?.text = item?.textField
        avatarImageView?.image = avatar
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
