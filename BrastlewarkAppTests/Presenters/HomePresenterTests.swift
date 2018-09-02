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
				it("sets filter ranges") {
					expect(view.setRangesWasCalled).to(beTrue())
				}
				it("sets hair colors to filter view") {
					expect(view.setFilterHairColorsWasCalledWith).notTo(beNil())
				}
			}

			context ("when a citizen is selected") {
				beforeEach {
					eventsEmitter.citizenSelectedObserver.onNext(CitizenToDisplay(citizen:CitizenFactory.citizen()))
				}
				it ("presents citizen detail") {
					expect(navigation.presentCitizenDetailWasCalledWithCitizen).notTo(beNil())
				}
			}

			context("when filters are applied") {
				beforeEach {
					view.citizens = nil
					eventsEmitter.filterAppliedObserver.onNext([.ageRange([1,2])])
				}
				it("sets the results of the filter"){
					expect(view.citizens).notTo(beNil())
				}
			}
		}

	}

	func createPresenter() ->
		(
			HomeNavigationMock, HomePresenter, HomeViewMock, HomeEventsEmitterDouble
		) {
			let navigation = HomeNavigationMock()
			let state = AppState(citizenRepository: CitizenRepository(citizens: [CitizenFactory.citizen()]))
			let view = HomeViewMock()
			let eventsEmitter = HomeEventsEmitterDouble()
			let presenter = HomePresenter(
				state: state,
				view: view,
				eventsEmitter: eventsEmitter,
				genderInteractor: GetGenderInteractor(citizenRepository: state.citizenRepository)
			)
			presenter.navigation = navigation

			return (navigation, presenter, view, eventsEmitter)
	}
}

// MARK: Mocks
class HomeNavigationMock: HomeNavigation {

	var presentCitizenDetailWasCalledWithCitizen : Citizen?
	func presentCitizenDetail(citizen: Citizen, citizenRepository: CitizenRepository) {
		presentCitizenDetailWasCalledWithCitizen = citizen
	}
}

class HomeViewMock: HomeView {
	var setFilterHairColorsWasCalledWith: [HairColor]?
	func setFilterHairColors(_ colors: [HairColor]) {
		setFilterHairColorsWasCalledWith = colors
	}

	var setRangesWasCalled = false
	func setRanges(ageMax: Float, ageMin: Float, heightMax: Float, heightMin: Float, weightMax: Float, weightMin: Float) {
		setRangesWasCalled = true
	}

	var citizens : [CitizenToDisplay]? = nil
	func setCitizens(_ citizens: [CitizenToDisplay]) {
		self.citizens = citizens
	}
}

class HomeEventsEmitterDouble: HomeViewEventsEmitter {
	var filterAppliedObservable: Observable<[BrastlewarkApp.Filter]> { return _filterAppliedObservable }
	var filterAppliedObserver: AnyObserver<[BrastlewarkApp.Filter]>!
	private var _filterAppliedObservable: Observable<[BrastlewarkApp.Filter]>!

	var citizenSelectedObservable: Observable<CitizenToDisplay> { return _citizenSelectedObservable }
	var citizenSelectedObserver : AnyObserver<CitizenToDisplay>!
	private var _citizenSelectedObservable: Observable<CitizenToDisplay>!

	init () {
		_citizenSelectedObservable = Observable.create() { observer in
			self.citizenSelectedObserver = observer
			return Disposables.create()
		}

		_filterAppliedObservable = Observable.create() { observer in
			self.filterAppliedObserver = observer
			return Disposables.create()
		}
	}
}
