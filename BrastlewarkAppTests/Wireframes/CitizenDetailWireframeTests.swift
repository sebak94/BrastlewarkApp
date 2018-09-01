//
//  CitizenDetailWireframeTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 27/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import BrastlewarkApp

class CitizenDetailWireframeTests: QuickSpec {

	override func spec() {
		describe("init") {
			let (_, wireframe) = createWireframe()

			it("creates the view and sets it as wireframes viewController") {
				guard
					let viewController = wireframe.viewController
						as? CitizenDetailViewController
					else { fail();	return }
				expect(viewController).to(be(wireframe.viewController))
			}
		}
	}

	func createWireframe() -> (Navigation, CitizenDetailWireframe) {
		let navigation = Navigation(window: UIWindow (frame: CGRect.zero))
		let repo = CitizenRepository(citizens: [])
		let wireframe = CitizenDetailWireframe(
			navigation: navigation,
			citizen: CitizenFactory.citizen(),
			citizenRepository: repo
		)

		try! wireframe.setAsRootWireframe(inNavigation: true)

		return (navigation, wireframe)
	}
}
