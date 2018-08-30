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
import SideMenu

protocol HomeView {
	func setCitizens( _ citizens: [Citizen] )
	func setRanges(
		ageMax: Float,
		ageMin: Float,
		heightMax: Float,
		heightMin: Float,
		weightMax: Float,
		weightMin: Float
	)
}

protocol HomeViewEventsEmitter {
	var citizenSelectedObservable: Observable<Citizen> { get }
	var filterAppliedObservable: Observable<[Filter]> { get }
}

class HomeViewController:
	ObservableViewController,
	HomeView,
	HomeViewEventsEmitter,
	FilterViewDelegate
{
	@IBOutlet weak var citizensCollectionView: CitizensCollectionView!
	@IBOutlet weak var emptyView: UIView!

	var citizenSelectedObservable: Observable<Citizen> {
		return citizensCollectionView.selectedCitizenObservable
	}

	var filterAppliedObservable: Observable<[Filter]> { return _filterAppliedObservable }
	var _filterAppliedObserver : AnyObserver<[Filter]>?
	var _filterAppliedObservable: Observable<[Filter]>!

	let filterViewController = FilterViewController()

	override func viewDidLoad() {
		createFilterAppliedObservable()
		super.viewDidLoad()
		navigationItem.title = "Brastlewark"
		setupFilterView()
	}

	func createFilterAppliedObservable () {
		_filterAppliedObservable = Observable.create { [weak self] observer in
			self?._filterAppliedObserver = observer
			return Disposables.create()
			}.share()
	}

	func setupFilterView() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: UIBarButtonSystemItem.search,
			target: self,
			action: #selector(filterTapped)
		)
		navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

		let menuRightNavigationController = UISideMenuNavigationController(
			rootViewController: filterViewController
		)
		guard let font = UIFont(name: "Futura", size: 21) else { return }
		menuRightNavigationController.navigationBar.titleTextAttributes = [
			NSAttributedStringKey.font: font,
			NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3978005052, green: 0.3978720903, blue: 0.3977910876, alpha: 1)
		]
		menuRightNavigationController.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		menuRightNavigationController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		menuRightNavigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		menuRightNavigationController.navigationBar.shadowImage = UIImage()
		SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
		SideMenuManager.default.menuFadeStatusBar = false
		SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.85
		SideMenuManager.default.menuEnableSwipeGestures = false
		filterViewController.delegate = self
	}

	func filtersApplied(with filters: [Filter]) {
		_filterAppliedObserver?.onNext(filters)
	}

	@objc func filterTapped() {
		guard let rightMenu = SideMenuManager.default.menuRightNavigationController else { return }
		present(
			rightMenu,
			animated: true,
			completion: nil
		)
	}
	
	func setCitizens( _ citizens: [Citizen] ) {
		emptyView.isHidden = !(citizens.count == 0)
		citizensCollectionView.citizens = citizens
		citizensCollectionView.reloadData()
	}

	//MARK: FilterView
	func setRanges(
		ageMax: Float,
		ageMin: Float,
		heightMax: Float,
		heightMin: Float,
		weightMax: Float,
		weightMin: Float
	) {
		filterViewController.setRanges(
			ageMax: ageMax,
			ageMin: ageMin,
			heightMax: heightMax,
			heightMin: heightMin,
			weightMax: weightMax,
			weightMin: weightMin
		)
	}
}
