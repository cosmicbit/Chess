//
//  SettingsViewController.swift
//  Chess
//
//  Created by Philips Jose on 30/01/26.
//

import UIKit

enum SettingType {
    case toggle(isOn: Bool)
    case navigation(value: String?) // For picking pieces or boards
}

struct SettingItem {
    let title: String
    let icon: String
    let type: SettingType
}

struct SettingSection {
    let title: String
    let items: [SettingItem]
}

class SettingsViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupData()
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func handleToggle(_ sender: UISwitch) {
        // Logic to save setting (e.g., UserDefaults)
        print("Setting changed: \(sender.isOn)")
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
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.imageView?.tintColor = .systemYellow

        switch item.type {
        case .toggle(let isOn):
            let switchView = UISwitch()
            switchView.isOn = isOn
            switchView.addTarget(self, action: #selector(handleToggle(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            cell.selectionStyle = .none
        case .navigation(let value):
            cell.detailTextLabel?.text = value
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}
