//
//  ObservableViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewObserver: class {
	func subcribeToViewEvents ()
}

class ObservableViewController: WireframeViewController {
	weak var viewObserver: ViewObserver?

	private var _viewDidAppearObservable: Observable<NSNull>!
	private var _viewWillAppearObservable: Observable<NSNull>!
	private var _viewWillDisappearObservable: Observable<NSNull>!
	private var _viewWillAppearObserver: AnyObserver<NSNull>?
	private var _viewDidAppearObserver: AnyObserver<NSNull>?
	private var _viewWillDisappearObserver: AnyObserver<NSNull>?

	var viewWillAppearObservable: Observable<NSNull> {
		return _viewWillAppearObservable
	}

	var viewDidAppearObservable: Observable<NSNull> {
		return _viewWillAppearObservable
	}
	
	var viewWillDisappearObservable: Observable<NSNull> {
		return _viewWillDisappearObservable
	}
	
	override func viewDidLoad() {
		createViewWillAppearObservable()
		createViewDidAppearObservable()
		createViewDidDisappearObservable()
		
		super.viewDidLoad()
		
		viewObserver?.subcribeToViewEvents()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		_viewWillAppearObserver?.onNext(NSNull())
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		_viewDidAppearObserver?.onNext(NSNull())
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		_viewWillDisappearObserver?.onNext(NSNull())
	}
	
	func createViewWillAppearObservable () {
		_viewWillAppearObservable = Observable.create { [weak self] observer in
			self?._viewWillAppearObserver = observer
			return Disposables.create()
		}.share()
	}

	func createViewDidAppearObservable () {
		_viewDidAppearObservable = Observable.create { [weak self] observer in
			self?._viewDidAppearObserver = observer
			return Disposables.create()
		}.share()
	}
	
	func createViewDidDisappearObservable () {
		_viewWillDisappearObservable = Observable.create { [weak self] observer in
			self?._viewWillDisappearObserver = observer
			return Disposables.create()
		}.share()
	}
}
