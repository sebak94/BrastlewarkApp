//
//  HomeViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

protocol HomeView {
	func setCitizens( _ citizens: [Citizen] )
}

class HomeViewController: ObservableViewController, HomeView {
	@IBOutlet weak var citizensCollectionView: CitizensCollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Brastlewark"
	}

	func setCitizens( _ citizens: [Citizen] ) {
		citizensCollectionView.citizens = citizens
		citizensCollectionView.reloadData()
	}
}
