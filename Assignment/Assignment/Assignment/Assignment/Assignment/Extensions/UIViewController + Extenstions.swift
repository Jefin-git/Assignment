//
//  UIViewController + Extenstions.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertController(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        controller.addAction(okAction)
        navigationController?.present(controller, animated: true, completion: nil)
    }
}
