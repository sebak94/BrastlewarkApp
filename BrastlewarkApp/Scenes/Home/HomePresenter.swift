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
	let disposeBag = DisposeBag()

	init(
		state: AppState,
		view: HomeView,
		eventsEmitter: HomeViewEventsEmitter
	) {
		self.view = view
		self.eventsEmitter = eventsEmitter
		self.state = state
	}

	override func subscribeToViewEvents() {
		subscribeToCitizenSelectedObservable()
		view.setCitizens(state.citizenRepository.citizens)
	}

	func subscribeToCitizenSelectedObservable() {
		eventsEmitter.citizenSelectedObservable
			.subscribe( onNext: { [weak self] citizen in
				self?.navigation?.presentCitizenDetail(citizen: citizen)
			}).disposed( by: disposeBag )
	}
}
