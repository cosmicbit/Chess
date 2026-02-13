//
//  ModeSelectionViewController.swift
//  Chess
//
//  Created by Philips Jose on 09/01/26.
//

import UIKit

enum PlayerMode: Int, CaseIterable {
    case online, passAndPlay, vsComputer
    
    var string: String {
        return Strings.modeTitles[self.rawValue]
    }
}

class ModeSelectionViewController: UIViewController {
    
    @IBOutlet private weak var navBar: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationStack()
        self.setupUI()
    }
    
    private func setupNavigationStack() {
        self.navigationController?.setViewControllers([self], animated: false)
    }
    
    private func setupUI() {
        self.view.addSubview(stackView)
        self.stackView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0)
        PlayerMode.allCases.forEach { mode in
            let button = UIButton(type: .custom)
            button.setTitle(mode.string, for: .normal)
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
        // Add this to your button action
        sender.showPopAnimation {
            if let text = sender.titleLabel?.text,
               let mode = PlayerMode.allCases.first(where: {$0.string == text}) {
                AppPreferences.shared.currentPlayerMode = mode
                if mode == .passAndPlay {
                    let mainSB = UIStoryboard(name: Storyboards.main, bundle: .main)
                    let chessVC = mainSB.instantiateViewController(withIdentifier: Storyboards.Identifiers.chessVC)
                    chessVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(chessVC, animated: true)
                } else {
                    
                    let alertVC = UIAlertController(
                        title: Strings.vsComputerAlert.title,
                        message: Strings.vsComputerAlert.description,
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(
                        title: Strings.Common.ok,
                        style: .default
                    )
                    
                    alertVC.addAction(okAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }

}
