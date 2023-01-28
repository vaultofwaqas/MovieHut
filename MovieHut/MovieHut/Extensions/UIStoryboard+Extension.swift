//
//  UIStoryboard+Extension.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateViewController controller unwrapped failed")
            fatalError("Controller error")
        }
        return controller
    }

    func instantiateNavigationController<T: UINavigationController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let navigationController = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController navigation controller unwrapped failed")
            fatalError("Controller error")
        }
        return navigationController
    }
}
