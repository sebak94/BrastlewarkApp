//
//  ViewWithXib.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 02/09/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


import UIKit

class ViewWithXib: UIView {
	@IBOutlet weak var view: UIView!

	init () {
		super.init (frame: .zero)
		loadXib()
	}

	override init (frame: CGRect) {
		super.init (frame: frame)
		loadXib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadXib()
	}

	func loadXib () {
		let xibName = String(describing: type(of: self))
		view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)!.first! as! UIView
		addSubview(view)
		addConstraintsToFillParent()
	}

	func addConstraintsToFillParent() {
		view.translatesAutoresizingMaskIntoConstraints = false

		let constraintAttrs: [NSLayoutAttribute] = [.top, .bottom, .leading, .trailing]
		constraintAttrs.forEach { attribute in
			let eqConstraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal,
															  toItem: self, attribute: attribute, multiplier: 1, constant: 0)
			addConstraint(eqConstraint)
		}
	}
}
