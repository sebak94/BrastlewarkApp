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
			let (navigation, presenter, view) = createPresenter()

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
		}

	}

	func createPresenter() ->
		(
			HomeNavigationMock, HomePresenter, HomeViewMock
		) {
			let navigation = HomeNavigationMock()
			let state = AppState(citizenRepository: CitizenRepository(citizens: []))
			let view = HomeViewMock()
			let presenter = HomePresenter(state: state, view: view)
			presenter.navigation = navigation

			return (navigation, presenter, view)
	}
}

// MARK: Mocks
class HomeNavigationMock: HomeNavigation {
	func presentCitizenDetail(citizen: Citizen) {}
}

class HomeViewMock: HomeView {
	var citizens : [Citizen]? = nil
	func setCitizens(_ citizens: [Citizen]) {
		self.citizens = citizens
	}
}
