//
//  HomeWireframeTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import BrastlewarkApp

class HomeWireframeTests: QuickSpec {

	override func spec() {
		describe("init") {
			let (_, wireframe) = createWireframe()

			it("creates the view and sets it as wireframes viewController") {
				guard
					let viewController = wireframe.viewController
						as? HomeViewController
					else { fail();	return }
				expect(viewController).to(be(wireframe.viewController))
			}

			it("sets itself as the presenters navigation") {
				guard
					let presenter = wireframe.presenter
						as? HomePresenter
					else { fail();	return }
				expect(presenter.navigation).to(be(wireframe))
			}
		}
	}

	func createWireframe() -> (Navigation, HomeWireframe) {
		let navigation = Navigation(window: UIWindow (frame: CGRect.zero))
		let appState = AppState (citizenRepository: CitizenRepository(citizens: []))
		let wireframe = HomeWireframe(navigation: navigation, state: appState)

		try! wireframe.setAsRootWireframe(inNavigation: true)

		return (navigation, wireframe)
	}
}
