//
//  ObservableViewWireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

class ObservableViewWireframe<P: ObserverPresenter>: Wireframe {
	let presenter: P
	
	override var viewController: UIViewController? {
		didSet {
			if let viewController = viewController as? ObservableViewController {
				viewController.viewObserver = self.presenter
			}
		}
	}
	
	init(navigation: Navigation, presenter: P) {
		self.presenter = presenter
		super.init(navigation: navigation)
	}
	
	required init(navigation: Navigation) {
		fatalError("init(navigation:) has not been implemented")
	}
}
