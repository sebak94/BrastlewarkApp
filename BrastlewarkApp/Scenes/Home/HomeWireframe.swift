//
//  HomeWireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

protocol HomeNavigation: class {

}

class HomeWireframe: ObservableViewWireframe<HomePresenter> {
	let homePresenter : HomePresenter

	required init(navigation: Navigation, state: AppState ) {
		let view = HomeViewController()

		homePresenter = HomePresenter(
			state: state
		)

		super.init(navigation: navigation, presenter: homePresenter)

		viewController = view
		homePresenter.navigation = self
	}

	required init(navigation: Navigation) {
		fatalError("init(navigation:) has not been implemented")
	}
}

extension HomeWireframe: HomeNavigation {}
