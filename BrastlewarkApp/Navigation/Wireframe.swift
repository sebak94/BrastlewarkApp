//
//  Wireframe.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

enum WireframeViewControllerError: Error {
	case viewControllerWithoutWireframe
}

enum WireframePresentationError : Error {
	case nilSelfViewController
	case nilOverViewController
	case notNavigationController
	case nilChildViewController
}

protocol ViewControllerWithWireframe {
	weak var wireframe: Wireframe? { get set }
}

class WireframeViewController : UIViewController, ViewControllerWithWireframe {
	weak var wireframe: Wireframe?

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		wireframe?.viewControllerWillAppear()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)

		wireframe?.viewControllerDidDisappear()
	}
}

class Wireframe {
	//TODO: remove unused methods
	var viewController : UIViewController? {
		didSet {
			if var wireframeVC = viewController as? ViewControllerWithWireframe {
				wireframeVC.wireframe = self
			}
		}
	}
	var navigationController : BaseNavigationController? {
		return self.viewController?.navigationController as? BaseNavigationController
	}

	var waitingPopupController: UIAlertController?
	var navigation: Navigation
	var presenting : Wireframe? = nil
	weak var presentedBy : Wireframe? = nil
	weak var parent: Wireframe? = nil
	var children: [Wireframe] = []

	required init(navigation: Navigation) {
		self.navigation = navigation
	}

	func setAsRootWireframe( inNavigation: Bool = false ) throws {
		guard let selfVC = self.viewController else {
			throw WireframePresentationError.nilSelfViewController
		}

		let vcToPresent = inNavigation ? try createNavigationController() : selfVC

		navigation.window.rootViewController = vcToPresent
		navigation.rootWireframe = self
	}

	// Modal
	func present( over: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil ) throws {
		guard let selfVC = self.viewController else { throw WireframePresentationError.nilSelfViewController }
		guard let overVC = over.viewController else { throw WireframePresentationError.nilOverViewController }

		overVC.present( selfVC, animated: animated, completion: completion )

		over.presenting  = self
		self.presentedBy = over
	}

	func presentInNavigation( over: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil ) throws {
		guard let overVC = over.viewController else { throw WireframePresentationError.nilOverViewController }

		let selfNVC = try createNavigationController()
		overVC.present( selfNVC, animated: animated, completion: completion )

		over.presenting  = self
		self.presentedBy = over
	}
    
    func presentModally (over: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil) throws {
        guard let overVC = over.viewController else { return }
        guard let selfVC = self.viewController else { throw WireframePresentationError.nilSelfViewController }
        
        selfVC.modalPresentationStyle = .overCurrentContext
        selfVC.modalTransitionStyle = .crossDissolve
        
        overVC.present(selfVC, animated: animated, completion: completion)
        
        over.presenting = self
        self.presentedBy = over
    }
	
	func presentFullscreen (over: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil) throws {
		guard let overVC = navigation.window.rootViewController else { return }
		guard let selfVC = self.viewController else { throw WireframePresentationError.nilSelfViewController }
		
		selfVC.modalPresentationStyle = .overCurrentContext
		selfVC.modalTransitionStyle = .crossDissolve
		
		overVC.present(selfVC, animated: animated, completion: completion)
		
		over.presenting = self
		self.presentedBy = over
	}
	
	func presentFullscreenInNavigation (
		over: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil
	) throws {
		guard let overVC = navigation.window.rootViewController else { return }
		
		let selfNVC = try createNavigationController()
		selfNVC.modalPresentationStyle = .overCurrentContext
		selfNVC.modalTransitionStyle = .crossDissolve
		
		overVC.present(selfNVC, animated: animated, completion: completion)
		
		over.presenting = self
		self.presentedBy = over
	}

	func dismiss (animated: Bool = true, completion: (() -> Void)? = nil ) throws {
		guard let selfVC = self.viewController else { throw WireframePresentationError.nilSelfViewController }

		selfVC.dismiss(animated: animated, completion: completion)

		self.presentedBy?.presenting = nil
	}
	
	func dismissPresentedWireframe (animated: Bool = true, completion: (() -> Void)? = nil) throws {
		if let wireframe = presenting {
			try wireframe.dismiss(animated: animated, completion: completion)
			return
		}
		
		if let wireframe = children.first(where: { $0.presenting != nil } )?.presenting {
			try wireframe.dismiss(animated: animated, completion: completion)
			return
		}
		
		completion? ()
	}

	// Push Navigation
	func push( inWireframe: Wireframe, animated: Bool = true ) throws {
		guard let inVC   = inWireframe.viewController?.navigationController else { throw WireframePresentationError.notNavigationController }
		guard let selfVC = self.viewController else { throw WireframePresentationError.nilSelfViewController }

		inVC.pushViewController( selfVC, animated: animated )

		inWireframe.presenting  = self
		self.presentedBy = inWireframe
	}

	@discardableResult
	func pop( animated: Bool ) throws -> UIViewController? {
		guard let selfNavigationVC = self.viewController?.navigationController else { throw WireframePresentationError.notNavigationController }

		return selfNavigationVC.popViewController( animated: animated )
	}

	@discardableResult
	func popToRoot (animated: Bool = true) throws -> [UIViewController]? {
		guard let selfNavigationVC = self.viewController?.navigationController else {
			throw WireframePresentationError.notNavigationController
		}

		return selfNavigationVC.popToRootViewController(animated: animated)
	}
	
	func createNavigationController () throws -> BaseNavigationController {
		guard navigationController == nil else { return navigationController! }
		guard let selfVC = viewController else { throw WireframePresentationError.nilSelfViewController }
		
		return BaseNavigationController (rootViewController: selfVC)
	}

	private var isPoppingViewController: Bool = false

	func viewControllerWillAppear () {}

	func viewControllerDidDisappear () {
		if isPoppingViewController {
			self.presentedBy?.presenting = nil
			isPoppingViewController = false
		}
	}

	func viewControllerWasPopped () {
		isPoppingViewController = true
	}
	
	// MARK: Parent / Child wireframe
	func addChildWireframe (_ wireframe: Wireframe) throws {
		guard let selfVC = viewController else { throw WireframePresentationError.nilSelfViewController }
		guard let childVC = wireframe.viewController else { throw WireframePresentationError.nilChildViewController }
		
		wireframe.parent = self
		children.append(wireframe)
		
		selfVC.addChildViewController(childVC)
	}
	
	func removeAllChildren (completion: (() -> Void)? = nil) throws {
		let childrenToRemove = self.children
		var areChildrenPresenting = false

		try childrenToRemove.forEach { child in
			if let presentingWireframe = child.presenting {
				areChildrenPresenting = true
				try? presentingWireframe.dismiss(animated: false, completion: completion)
			}

			try child.removeFromParentWireframe()
		}

		if !areChildrenPresenting { completion? () }
	}
	
	func removeFromParentWireframe () throws {
		guard let selfVC = viewController else { throw WireframePresentationError.nilSelfViewController }
		
		selfVC.removeFromParentViewController()
		
		self.parent?.removeChildWireframe(self)
		self.parent = nil
	}
	
	internal func removeChildWireframe (_ wireframe: Wireframe) {
		guard let childIndex = children.index(of: wireframe) else { return }
		children.remove(at: childIndex)
	}
}

extension Wireframe: Equatable {
	static func ==(lhs: Wireframe, rhs: Wireframe) -> Bool {
		return lhs.viewController == rhs.viewController
	}
}

extension Wireframe {
	func presentConfirmationAlert( title: String, message: String? = nil,
	                               okTitle: String = "Aceptar", cancelTitle: String = "Cancelar",
	                               okHandler: ( () -> Void)? = nil, cancelHandler: ( () -> Void)? = nil,
	                               animated: Bool = true, presented: ( () -> Void)? = nil)
	{
		let alertVC = UIAlertController( title: title, message: message, preferredStyle: .alert )

		let okAction = UIAlertAction( title: okTitle, style: .default) { action in
			okHandler? ()
		}
		let cancelAction = UIAlertAction( title: cancelTitle, style: .cancel) { action in
			cancelHandler? ()
		}

		alertVC.addAction( okAction )
		alertVC.addAction( cancelAction )

		self.viewController?.present( alertVC, animated: animated, completion: presented )
	}
	
	func showPopupAlert(
		title: String,
		message: String,
		rightButtonTitle: String,
		leftButtonTitle: String,
		rightHandler: ( () -> Void)?,
		leftHandler: ( () -> Void)?
	) {
		presentConfirmationAlert(
			title: title, message: message, okTitle: rightButtonTitle, cancelTitle: leftButtonTitle,
			okHandler: rightHandler, cancelHandler: leftHandler,
			animated: true, presented: nil
		)
	}
}

