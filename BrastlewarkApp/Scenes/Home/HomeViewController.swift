//
//  HomeViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeView {
	func setCitizens( _ citizens: [Citizen] )
}

protocol HomeViewEventsEmitter {
	var citizenSelectedObservable: Observable<Citizen> { get }
}

class HomeViewController: ObservableViewController, HomeView, HomeViewEventsEmitter {
	@IBOutlet weak var citizensCollectionView: CitizensCollectionView!

	var citizenSelectedObservable: Observable<Citizen> {
		return citizensCollectionView.selectedCitizenObservable
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Brastlewark"
	}
	
	func setCitizens( _ citizens: [Citizen] ) {
		citizensCollectionView.citizens = citizens
		citizensCollectionView.reloadData()
	}
}
