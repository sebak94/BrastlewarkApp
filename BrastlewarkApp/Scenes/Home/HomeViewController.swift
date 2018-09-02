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
	func setCitizens( _ citizens: [CitizenToDisplay] )
	func setRanges(
		ageMax: Float,
		ageMin: Float,
		heightMax: Float,
		heightMin: Float,
		weightMax: Float,
		weightMin: Float
	)
	func setFilterHairColors(_ colors: [HairColor])
}

protocol HomeViewEventsEmitter {
	var citizenSelectedObservable: Observable<CitizenToDisplay> { get }
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

	var citizenSelectedObservable: Observable<CitizenToDisplay> {
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
		setupSideMenu()
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
		navigationItem.rightBarButtonItem?.tintColor = AppStyle.default.colors.foreground
		filterViewController.delegate = self
	}

	func setupSideMenu() {
		let menuNavigationController = UISideMenuNavigationController(
			rootViewController: filterViewController
		)
		menuNavigationController.navigationBar.titleTextAttributes = [
			NSAttributedStringKey.font: AppStyle.default.fonts.futura,
			NSAttributedStringKey.foregroundColor: AppStyle.default.colors.foreground
		]
		menuNavigationController.navigationBar.backgroundColor = AppStyle.default.colors.background
		menuNavigationController.navigationBar.barTintColor = AppStyle.default.colors.background
		menuNavigationController.navigationBar.setBackgroundImage(
			UIImage(), for: UIBarMetrics.default
		)
		menuNavigationController.navigationBar.shadowImage = UIImage()
		SideMenuManager.default.menuRightNavigationController = menuNavigationController
		SideMenuManager.default.menuFadeStatusBar = false
		SideMenuManager.default.menuWidth = UIScreen.main.bounds.width * 0.85
		SideMenuManager.default.menuEnableSwipeGestures = false
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
	
	func setCitizens( _ citizens: [CitizenToDisplay] ) {
		//Shows a view notifying when there were no results
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

	func setFilterHairColors(_ colors: [HairColor]) {
		filterViewController.setHairColors(colors)
	}
}
