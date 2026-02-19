//
//  ProfileViewController.swift
//  Chess
//
//  Created by Philips Jose on 02/02/26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setupData()
        self.setupBackgroundTap()
        self.setupKeyboardObservers()
    }
    
    private func setupBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func backgroundTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let settings = UIStoryboard(name: Storyboards.settings, bundle: .main)
        let settingsVC = settings.instantiateInitialViewController() ?? UIViewController()
        settingsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = getHeaderCell(for: indexPath)
        default:
            cell = getTextFieldCell(for: indexPath)
        }
        return cell
    }
    
    private func getHeaderCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIDs.ProfileCellWithAvatar, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(avatar: self.viewModel.currentUser.avatar)
        cell.didTapOnAvatar = handleAvatarTap
        return cell
    }
    
    private func getTextFieldCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIDs.ProfileCellWithText, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(item: self.viewModel.items[indexPath.row - 1])
        return cell
    }
    
    func handleAvatarTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
}

extension ProfileViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.tableView.contentInset = contentInsets
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = .zero
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            self.viewModel.currentUser.avatar = selectedImage
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        self.dismiss(animated: true)
    }
}
