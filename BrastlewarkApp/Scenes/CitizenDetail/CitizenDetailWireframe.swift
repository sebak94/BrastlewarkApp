//
//  CitizenDetailWireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

class CitizenDetailWireframe: ObservableViewWireframe<CitizenDetailPresenter> {
	let citizenDetailPresenter : CitizenDetailPresenter

	required init(navigation: Navigation, citizen: Citizen ) {
		let view = CitizenDetailViewController()

		citizenDetailPresenter = CitizenDetailPresenter(
			citizen: citizen,
			view: view
		)

		super.init(navigation: navigation, presenter: citizenDetailPresenter)

		viewController = view
	}

	required init(navigation: Navigation) {
		fatalError("init(navigation:) has not been implemented")
	}
}
