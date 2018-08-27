//
//  CitizenDetailPresenter.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import RxSwift

class CitizenDetailPresenter: ObserverPresenter {
	let citizen : Citizen
	let view : CitizenDetailView

	init(
		citizen: Citizen,
		view: CitizenDetailView
		) {
		self.view = view
		self.citizen = citizen
	}

	override func subscribeToViewEvents() {
		view.setCitizenInformation(citizen)
	}
}

