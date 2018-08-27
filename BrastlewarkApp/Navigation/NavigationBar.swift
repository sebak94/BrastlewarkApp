//
//  NavigationBar.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


import UIKit

class NavigationBar: UINavigationBar {

	override init(frame: CGRect) {
		super.init(frame: frame)

		initNavigationBar()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		initNavigationBar()
	}

	func initNavigationBar() {
		applyStyles()
	}

	func applyStyles() {
		backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}
}

extension BaseNavigationController {
	static func withNavigationBar(rootViewController: UIViewController)
		-> BaseNavigationController
	{
		let navigationController =
			BaseNavigationController(
				navigationBarClass: NavigationBar.self, toolbarClass: nil
		)

		navigationController.viewControllers = [rootViewController]
		return navigationController
	}
}

