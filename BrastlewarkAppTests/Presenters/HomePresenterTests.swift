//
//  HomePresenterTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift

@testable import BrastlewarkApp

class HomePresenterTests: QuickSpec {

	override func spec() {

		context("when the presenter is created") {
			let (navigation, presenter, view, eventsEmitter) = createPresenter()

			it ("is created with its state") {
				expect(presenter.state).notTo(beNil())
			}

			context("when subscribeToViewEvents is called") {
				beforeEach {
					presenter.subscribeToViewEvents()
				}
				it("sets the citizens to the view") {
					expect(view.citizens).notTo(beNil())
				}
			}

			context ("when a citizen is selected") {
				beforeEach {
					eventsEmitter.citizenSelectedObserver.onNext(CitizenFactory.citizen())
				}
				it ("presents citizen detail") {
					expect(navigation.presentCitizenDetailWasCalledWithCitizen).notTo(beNil())
				}
			}
		}

	}

	func createPresenter() ->
		(
			HomeNavigationMock, HomePresenter, HomeViewMock, HomeEventsEmitterDouble
		) {
			let navigation = HomeNavigationMock()
			let state = AppState(citizenRepository: CitizenRepository(citizens: []))
			let view = HomeViewMock()
			let eventsEmitter = HomeEventsEmitterDouble()
			let presenter = HomePresenter(state: state, view: view, eventsEmitter: eventsEmitter)
			presenter.navigation = navigation

			return (navigation, presenter, view, eventsEmitter)
	}
}

// MARK: Mocks
class HomeNavigationMock: HomeNavigation {
	var presentCitizenDetailWasCalledWithCitizen : Citizen?
	func presentCitizenDetail(citizen: Citizen) {
		presentCitizenDetailWasCalledWithCitizen = citizen
	}
}

class HomeViewMock: HomeView {
	var citizens : [Citizen]? = nil
	func setCitizens(_ citizens: [Citizen]) {
		self.citizens = citizens
	}
}

class HomeEventsEmitterDouble: HomeViewEventsEmitter {
	var citizenSelectedObservable: Observable<Citizen> { return _citizenSelectedObservable }
	var citizenSelectedObserver : AnyObserver<Citizen>!
	private var _citizenSelectedObservable: Observable<Citizen>!

	init () {
		_citizenSelectedObservable = Observable.create() { observer in
			self.citizenSelectedObserver = observer
			return Disposables.create()
		}
	}
}
