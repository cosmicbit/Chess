//
//  ProfileTextFieldTableViewCell.swift
//  Chess
//
//  Created by Philips Jose on 02/02/26.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let id: String = "ProfileTableViewCell"
    
    @IBOutlet private weak var avatarContainerView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    private var item: ProfileItem?
    private var avatar: UIImage?
    
    var didTapOnAvatar: (() -> Void)?
    
    public func configure(item: ProfileItem? = nil, avatar: UIImage? = nil) {
        self.item = item
        self.avatar = avatar
        self.setupUI()
        self.setupUX()
    }
    
    private func setupUI() {
        self.label?.text = item?.label
        self.textField?.text = item?.textField
        self.avatarImageView?.image = avatar ?? UIImage(systemName: "person.fill")
    }
    
    private func setupUX() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        self.avatarContainerView?.addGestureRecognizer(tap)
    }
    
    @objc func avatarTapped() {
        self.didTapOnAvatar?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
