//
//  HomePresenter.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import RxSwift

class HomePresenter: ObserverPresenter {
	weak var navigation : HomeNavigation?
	let state : AppState
	let view : HomeView
	let eventsEmitter: HomeViewEventsEmitter
	let genderInteractor: GetGenderInteractor
	let disposeBag = DisposeBag()

	init(
		state: AppState,
		view: HomeView,
		eventsEmitter: HomeViewEventsEmitter,
		genderInteractor: GetGenderInteractor
	) {
		self.view = view
		self.eventsEmitter = eventsEmitter
		self.genderInteractor = genderInteractor
		self.state = state
	}

	override func subscribeToViewEvents() {
		subscribeToCitizenSelectedObservable()
		subscribeToFilterAppliedObservable()
		view.setCitizens(state.citizenRepository.citizens.toDisplay())
		setupFilterViewRanges()
	}

	func setupFilterViewRanges() {
		guard let maximumAge = state.citizenRepository.citizens.map({$0.age}).max(),
				let minimumAge = state.citizenRepository.citizens.map({$0.age}).min(),
				let maximumHeight = state.citizenRepository.citizens.map({$0.height}).max(),
				let minimumHeight = state.citizenRepository.citizens.map({$0.height}).min(),
				let maximumWeight = state.citizenRepository.citizens.map({$0.weight}).max(),
				let minimumWeight = state.citizenRepository.citizens.map({$0.weight}).min()
			else {
				view.setRanges(
					ageMax: 0,
					ageMin: 0,
					heightMax: 0,
					heightMin: 0,
					weightMax: 0,
					weightMin: 0
				)
				return
		}
		view.setRanges(
			ageMax: Float(maximumAge) + 1,
			ageMin: Float(minimumAge) - 1,
			heightMax: Float(maximumHeight) + 1,
			heightMin: Float(minimumHeight) - 1,
			weightMax: Float(maximumWeight) + 1,
			weightMin: Float(minimumWeight) - 1
		)
	}

	func subscribeToCitizenSelectedObservable() {
		eventsEmitter.citizenSelectedObservable
			.subscribe( onNext: { [weak self] citizen in
				guard let sSelf = self,
						let citizen = sSelf.state.citizenRepository.citizens.filter({$0.id == citizen.id}).first
					else { return }
				self?.navigation?.presentCitizenDetail(
					citizen: citizen,
					citizenRepository: sSelf.state.citizenRepository
				)
			}).disposed( by: disposeBag )
	}

	func subscribeToFilterAppliedObservable() {
		eventsEmitter.filterAppliedObservable
			.subscribe( onNext: { [weak self] filters in
				self?.applyFilters(filters)
			}).disposed( by: disposeBag )
	}

	func applyFilters(_ filters: [Filter]) {
		let filteredCitizens = state.citizenRepository.filter(by: filters)
		view.setCitizens(filteredCitizens.toDisplay())
	}
}
