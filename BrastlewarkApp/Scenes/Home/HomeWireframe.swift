//
//  HomeWireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

protocol HomeNavigation: class {
	func presentCitizenDetail(citizen: CitizenToDisplay)
}

class HomeWireframe: ObservableViewWireframe<HomePresenter> {
	let homePresenter : HomePresenter

	required init(navigation: Navigation, state: AppState ) {
		let view = HomeViewController()

		homePresenter = HomePresenter(
			state: state,
			view: view,
			eventsEmitter: view
		)

		super.init(navigation: navigation, presenter: homePresenter)

		viewController = view
		homePresenter.navigation = self
	}

	required init(navigation: Navigation) {
		fatalError("init(navigation:) has not been implemented")
	}

	override func createNavigationController () throws -> BaseNavigationController {
		guard navigationController == nil else { return navigationController! }
		guard let selfVC = viewController else { throw WireframePresentationError.nilSelfViewController }

		return BaseNavigationController.withNavigationBar(rootViewController: selfVC)
	}
}

extension HomeWireframe: HomeNavigation {
	func presentCitizenDetail(citizen: CitizenToDisplay) {
		let citizenDetailWireframe = CitizenDetailWireframe (navigation: navigation, citizen: citizen)
		try? citizenDetailWireframe.push(inWireframe: self)
	}
}
