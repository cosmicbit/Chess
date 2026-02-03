//
//  SettingsDetailViewController.swift
//  Chess
//
//  Created by Philips Jose on 03/02/26.
//

import UIKit

class SettingsDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    public var viewModel = SettingsDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.titleLabel.text = self.viewModel.currentSetting.details.title
    }
   
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
