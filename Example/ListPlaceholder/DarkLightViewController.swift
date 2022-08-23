//
//  DarkLightViewController.swift
//  Example
//
//  Created by Chung Tran on 07/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class DarkLightViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    var mode: UIUserInterfaceStyle = .light {
        didSet {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = mode
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white.onDarkMode(.red)
        stackView.showLoader()
    }

    @IBAction func changeModeButtonDidTouch(_ sender: Any) {
        mode = mode == .dark ? .light : .dark
    }

    private var userInterfaceStyle: UIUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let currentUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        guard currentUserInterfaceStyle != userInterfaceStyle else { return }
        userInterfaceStyle = currentUserInterfaceStyle
        NotificationCenter.default.post(name: Notification.Name("trait_collection_style_changed"), object: nil)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

@available(iOS 13.0, *)
private extension UIColor {
    func onDarkMode(_ color: UIColor) -> UIColor {
        let lightColor = self
        return UIColor { trait in
            trait.userInterfaceStyle == .dark ? color : lightColor
        }
    }
}
