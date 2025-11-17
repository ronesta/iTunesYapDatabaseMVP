//
//  GuavaDesign.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.11.2025.
//


import UIKit

class BaseNavigation: NSObject {
    weak var viewController: UIViewController?
    /// Callback to trigger when navigation was deinited
    var onDeinit: (() -> Void)?

    private weak var coordinator: BaseCoordinatable?

    init(coordinator: BaseCoordinatable? = nil) {
        self.coordinator = coordinator
    }

    deinit {
        onDeinit?()
    }

    /// Redirects user to the privacy settings of application
    func showAppPrivacySettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }

    func getCoordinator() -> BaseCoordinatable? {
        coordinator
    }
}

// MARK: BaseNavigation.AlertActionModel

extension BaseNavigation {
    struct AlertActionModel {
        let title: String?
        let style: UIAlertAction.Style
        let handler: ((UITextField?) -> Void)?

        init(
            title: String?,
            style: UIAlertAction.Style = .default,
            handler: ((UITextField?) -> Void)? = nil
        ) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }
}
