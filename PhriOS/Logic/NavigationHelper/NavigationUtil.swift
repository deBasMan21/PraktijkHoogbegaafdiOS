//
//  NavigationHelper.swift
//  PhriOS
//
//  Created by Bas Buijsen on 11/04/2022.
//

import Foundation
import SwiftUI

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.keyWindow!.rootViewController)?
            .popToRootViewController(animated: true)
    }

    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
