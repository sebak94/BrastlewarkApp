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

		guard let font = UIFont(name: "Futura", size: 21) else { return }
		self.navigationBar.titleTextAttributes = [
			NSAttributedStringKey.font: font,
			NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3978005052, green: 0.3978720903, blue: 0.3977910876, alpha: 1)
		]
	}

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
		navItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
	}
	
	func removeBottomBorder() {
		navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationBar.shadowImage = UIImage()
	}
}
