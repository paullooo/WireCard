//
//  Router.swift
//  WireCard
//
//  Created by Claro on 03/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import UIKit

class Router {
    static func login(completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }) { (_) in
            completion?()
        }
    }
    
    static func home(completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = UINavigationController(rootViewController: OrdersViewController())
        }) { (_) in
            completion?()
        }
    }
}
