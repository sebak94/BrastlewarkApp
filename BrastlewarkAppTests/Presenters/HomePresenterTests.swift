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
			let (navigation, presenter) = createPresenter()

			it ("is created with its state") {
				expect(presenter.state).notTo(beNil())
			}
		}

	}

	func createPresenter() ->
		(
			HomeNavigationMock, HomePresenter
		) {
			let navigation = HomeNavigationMock()
			let state = AppState(citizenRepository: CitizenRepository(citizens: []))
			let presenter = HomePresenter(state: state)
			presenter.navigation = navigation

			return (navigation, presenter)
	}
}

// MARK: Mocks
class HomeNavigationMock: HomeNavigation {}
