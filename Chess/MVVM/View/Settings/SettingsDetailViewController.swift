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

extension SettingsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentSettingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonCell.id, for: indexPath) as? RadioButtonCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
