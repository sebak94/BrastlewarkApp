//
//  CitizenDetailPresenterTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 27/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift

@testable import BrastlewarkApp

class CitizenDetailPresenterTests: QuickSpec {

	override func spec() {

		context("when the presenter is created") {
			let (presenter, view) = createPresenter()

			context("when subscribeToViewEvents is called") {
				beforeEach {
					presenter.subscribeToViewEvents()
				}
				it("sets the citizen information to the view") {
					expect(view.setCitizenInformationWasCalled).to(beTrue())
				}
			}
		}

	}

	func createPresenter() ->
		(
		CitizenDetailPresenter, CitizenDetailViewMock
		) {
			let view = CitizenDetailViewMock()
			let presenter = CitizenDetailPresenter(citizen: CitizenFactory.citizen(), view: view)

			return (presenter, view)
	}
}

// MARK: Mocks
class CitizenDetailViewMock: CitizenDetailView {
	var setCitizenInformationWasCalled = false
	func setCitizenInformation(_ citizen: Citizen) {
		setCitizenInformationWasCalled = true
	}
}
