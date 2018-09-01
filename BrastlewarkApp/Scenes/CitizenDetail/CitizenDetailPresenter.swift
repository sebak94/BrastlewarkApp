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
	let genderInteractor: GetGenderInteractor

	init(
		citizen: Citizen,
		view: CitizenDetailView,
		genderInteractor: GetGenderInteractor
	) {
		self.view = view
		self.citizen = citizen
		self.genderInteractor = genderInteractor
	}

	override func subscribeToViewEvents() {
		var citizenToDisplay = CitizenToDisplay(citizen: citizen)
		citizenToDisplay.gender = genderInteractor.calculateGender(for: citizen)
		view.setCitizenInformation(citizenToDisplay)
	}
}

