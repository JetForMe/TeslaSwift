//
//  LoginViewController.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 05/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let loginDone = Notification.Name("loginDone")
}

class LoginViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!

    @IBAction func webLoginAction(_ sender: AnyObject) {
        if #available(iOS 13.0, *) {
            let webloginViewController = api.authenticateWeb { (result) in

                DispatchQueue.main.async {
                    switch result {
                        case .success:
                            self.messageLabel.text = "Authentication success"
                            NotificationCenter.default.post(name: Notification.Name.loginDone, object: nil)

                            self.dismiss(animated: true, completion: nil)

                        case let .failure(error):
                            self.messageLabel.text = "Authentication failed: \(error)"
                    }
                }
            }
            guard let safeWebloginViewController = webloginViewController else { return }

            self.present(safeWebloginViewController, animated: true, completion: nil)
        }
    }
}
