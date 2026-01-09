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
        self.view.backgroundColor = .clear
        PlayerMode.allCases.forEach { mode in
            let button = UIButton(type: .system)
            button.setTitle(mode.rawValue, for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
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
        self.stackView.layer.cornerRadius = 8
        self.stackView.arrangedSubviews.forEach { $0.layer.cornerRadius = 8 }
    }
    
    @objc func didTapModeButton(_ sender: UIButton) {
        if let text = sender.titleLabel?.text,
            let mode = PlayerMode(rawValue: text) {
            setMode?(mode)
        }
        dismiss(animated: true)
    }

}
