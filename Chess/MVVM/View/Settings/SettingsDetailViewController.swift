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
        self.viewModel.initialSetup()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.selectRow(at: self.viewModel.getCurrentSelectedIndexPath(), animated: false, scrollPosition: .none)
    }
    
    private func setupUI() {
        self.titleLabel.text = self.viewModel.currentSetting.details.title
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupBindings() {
        self.viewModel.didChangeAppTheme = { [weak self] in
            if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.setAppTheme()
            }
        }
    }
   
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.currentSettingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RadioButtonCell.id, for: indexPath) as? RadioButtonCell {
            let cellViewModel = RadioButtonViewModel(
                optionName: self.viewModel.currentSettingOptions[indexPath.row],
                selected: self.viewModel.currentSelectedOption == indexPath.row
            )
            cell.configure(viewModel: cellViewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.setCurrentSelectedOption(indexPath.row)
    }
}
