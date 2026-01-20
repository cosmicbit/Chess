//
//  ModeSelectionViewController.swift
//  Chess
//
//  Created by Philips Jose on 09/01/26.
//

import UIKit

enum PlayerMode: String, CaseIterable {
    case passAndPlay="Pass and Play"
    case vsComputer="vs Computer"
}

class ModeSelectionViewController: UIViewController {
    
    private var optionButtons: [UIButton] = []
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return view
    }()
    
    var setMode: ((PlayerMode)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(stackView)
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.0)
        self.stackView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0)
        PlayerMode.allCases.forEach { mode in
            let button = UIButton(type: .custom)
            button.setTitle(mode.rawValue, for: .normal)
            button.backgroundColor = UIColor(red: 0.24, green: 0.35, blue: 0.90, alpha: 1.0)
            let titleColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0)
            button.setTitleColor(titleColor, for: .normal)
            button.addTarget(self, action: #selector(didTapModeButton(_ :)), for: .touchUpInside)
            self.optionButtons.append(button)
            self.stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            
            self.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            self.stackView.widthAnchor.constraint(equalToConstant: 250),
            self.stackView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.stackView.arrangedSubviews.forEach { $0.layer.cornerRadius = 12 }
        self.stackView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).cgColor
        self.stackView.layer.borderWidth = 0.5
        self.stackView.layer.cornerRadius = 24
        self.stackView.layer.shadowRadius = 15
        self.stackView.layer.shadowOpacity = 0.12
        self.stackView.layer.shadowColor = UIColor.black.cgColor
        self.stackView.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    
    @objc func didTapModeButton(_ sender: UIButton) {
        if let text = sender.titleLabel?.text,
            let mode = PlayerMode(rawValue: text) {
            setMode?(mode)
        }
        dismiss(animated: true)
    }

}
