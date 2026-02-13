//
//  UIViewController+Extension.swift
//  Chess
//
//  Created by Philips Jose on 13/02/26.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String = "", completion: ((Bool) -> Void)? = nil) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: Strings.Common.ok,
                                     style: .default) { _ in
            completion?(true)
        }
        alertVC.addAction(okAction)
        
        if completion != nil {
            let cancelAction = UIAlertAction(title: Strings.Common.cancel,
                                             style: .cancel) { _ in
                completion?(false)
            }
            alertVC.addAction(cancelAction)
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
