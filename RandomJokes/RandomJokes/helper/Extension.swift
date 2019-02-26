//
//  Extension.swift
//  RandomJokes
//
//  Created by Ahmed Ateek on 2/26/19.
//  Copyright © 2019 Ahmed-Ateek. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func alertUser(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }}
