//
//  SplashEventsHandlerTests.swift
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

class SplashEventsHandlerTests: QuickSpec {

	override func spec() {

		context("when the eventsHandler is created") {
			let (navigation, fetchPopulation, eventsHandler) = createEventsHandler()

			context("when the view is loaded") {
				beforeEach{ eventsHandler.viewDidLoad() }

				it ("calls the fetcher") {
					expect(fetchPopulation.executeWasCalled).to(beTrue())
				}

				context ("when the fetcher responds successfully") {
					beforeEach {
						fetchPopulation.citizensToReturnObserver.onNext([CitizenFactory.citizen()])
					}

					it ("tells navigation to present home with an app state containing fetched citizens") {
						expect (navigation.state?.citizenRepository.citizens.first?.id) == CitizenFactory.citizen().id
					}
				}

				context ("when the fetcher has an error") {
					beforeEach { fetchPopulation.citizensToReturnObserver.onError(NSError()) }

					it("shows the error popup") {
						expect (navigation.popupWasShownWithAction).notTo(beNil())
					}

					context("when the user presses the ok button") {
						beforeEach {
							fetchPopulation.executeWasCalled = false
							navigation.popupWasShownWithAction?()
						}

						it ("calls the fetcher again") {
							expect(fetchPopulation.executeWasCalled).to(beTrue())
						}
					}

				}
			}
		}

	}

	func createEventsHandler() ->
		(
		SplashNavigationNavigationMock,
		FetchPopulationMock, SplashEventsHandler
		) {
			let navigation = SplashNavigationNavigationMock()
			let fetchPopulation = FetchPopulationMock()
			let eventsHandler =
				SplashEventsHandler(fetchPopulation: fetchPopulation)
			eventsHandler.navigation = navigation

			return (navigation, fetchPopulation, eventsHandler)
	}
}

// MARK: Mocks
class SplashNavigationNavigationMock: SplashNavigation {

	var state: AppState?
	var popupWasShownWithAction: (() -> Void)?

	func presentHome(for state: AppState) {
		self.state = state
	}

	func presentInformationPopup(
		title: String?,
		message: String,
		animated: Bool,
		action: (() -> Void)?
	) {
		popupWasShownWithAction = action
	}
}

class FetchPopulationMock: FetchPopulation {
	var executeWasCalled: Bool = false
	var citizensToReturnObserver: AnyObserver<[Citizen]>!
	private var _citizensToReturnObservable: Observable<[Citizen]>!

	init () {
		_citizensToReturnObservable = Observable.create { observer in
			self.citizensToReturnObserver = observer
			return Disposables.create ()
		}
	}

	func execute() -> Observable<[Citizen]> {
		executeWasCalled = true
		return _citizensToReturnObservable
	}
}

