//
//  SplashWireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

protocol SplashNavigation: class {
	func presentHome( for state: AppState )
}

class SplashWireframe: Wireframe {

	let splashEventsHandler: SplashEventsHandler

	required init(navigation: Navigation) {
		self.splashEventsHandler = SplashEventsHandler (
			fetchPopulation: FetchPopulationInteractor.withDefaultApi
		)

		let splashView = SplashViewController()

		super.init(navigation: navigation)

		self.viewController = splashView
		splashView.eventsHandler = splashEventsHandler
		self.splashEventsHandler.navigation = self
	}
}

extension SplashWireframe: SplashNavigation {
	public func presentHome (for state: AppState) {
		let homeWireframe = HomeWireframe (navigation: navigation, state: state)
		try? homeWireframe.setAsRootWireframe(inNavigation: true)
	}
}
