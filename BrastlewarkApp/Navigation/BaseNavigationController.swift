//
//  BaseNavigationController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


import UIKit

class BaseNavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.setupNavigationBar()
	}

	func setupNavigationBar() {
		self.navigationBar.isTranslucent = false
		
		removeBottomBorder()

		self.navigationBar.titleTextAttributes = [
			NSAttributedStringKey.font: AppStyle.default.fonts.futura,
			NSAttributedStringKey.foregroundColor: AppStyle.default.colors.foreground
		]
	}

	// I use this method to remove the default back button.
	override func pushViewController( _ viewController: UIViewController, animated: Bool ) {
		setUpBackNavigationButton()

		super.pushViewController( viewController, animated: animated )
	}

	override func popViewController(animated: Bool) -> UIViewController? {
		let poppedVC = super.popViewController(animated: animated)

		if let poppedVC = poppedVC as? WireframeViewController {
			poppedVC.wireframe?.viewControllerWasPopped()
		}

		return poppedVC
	}

	func setUpBackNavigationButton() {
		guard let navItem = self.topViewController?.navigationItem else { return }
		navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navItem.backBarButtonItem?.tintColor = AppStyle.default.colors.foreground
	}
	
	func removeBottomBorder() {
		navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationBar.shadowImage = UIImage()
	}
}
