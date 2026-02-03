//
//  SettingsViewController.swift
//  Chess
//
//  Created by Philips Jose on 30/01/26.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupData()
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func handleToggle(_ sender: UISwitch) {
        // Logic to save setting (e.g., UserDefaults)
        print("Setting changed: \(sender.isOn)")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView Methods
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = item.details.title
        cell.imageView?.image = UIImage(systemName: item.details.icon)
        cell.imageView?.tintColor = .link

        switch item.details.type {
        case .toggle:
            let switchView = UISwitch()
            switchView.isOn = true
            switchView.addTarget(self, action: #selector(handleToggle(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            cell.selectionStyle = .none
        case .navigation:
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = self.viewModel.sections[indexPath.section].items[indexPath.row]
        if setting.details.type == .navigation {
            let sb = UIStoryboard(name: Storyboards.settings, bundle: .main)
            if let vc = sb.instantiateViewController(withIdentifier: Storyboards.Identifiers.settingsDetailVC) as? SettingsDetailViewController {
                vc.viewModel.currentSetting = setting
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
