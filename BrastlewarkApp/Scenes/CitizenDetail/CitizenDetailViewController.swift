//
//  CitizenDetailViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

protocol CitizenDetailView {
	func setCitizenInformation( _ citizen: Citizen )
}

class CitizenDetailViewController: ObservableViewController, CitizenDetailView {
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	func setCitizenInformation(_ citizen: Citizen) {
		navigationItem.title = citizen.name
	}
}
