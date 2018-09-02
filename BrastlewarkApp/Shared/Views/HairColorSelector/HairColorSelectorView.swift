//
//  HairColorSelectorView.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 02/09/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

class HairColorSelectorView: ViewWithXib {

	@IBOutlet weak var colorStackView: UIStackView!

	func setColors( _ colors: [HairColor]) {
		colorStackView.distribution = .fillEqually
		colorStackView.alignment = .fill
		colorStackView.spacing = 10
		colorStackView.translatesAutoresizingMaskIntoConstraints = false
		for color in colors {
			let view = HairColorView(
				frame: CGRect(
					x: 0,
					y: 0,
					width: colorStackView.frame.height,
					height: colorStackView.frame.height
				),
				color: color
			)
			colorStackView.addArrangedSubview(view)
		}
	}

	func getSelectedColors() -> [HairColor] {
		return colorStackView.arrangedSubviews
			.map({ $0 as! HairColorView })
			.filter({ $0.isSelected })
			.flatMap({ $0.hairColor	})
	}

	func clearSelections() {
		_ = colorStackView.arrangedSubviews
			.map({ ($0 as! HairColorView).isSelected = false })
	}
}

class HairColorView: SelectableColorView {
	var hairColor: HairColor

	init(frame: CGRect, selected: Bool = false, color: HairColor) {
		hairColor = color
		super.init (frame: frame, selected: selected)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func setupView() {
		super.setupView()
		backgroundColor = hairColor.color() 
	}
}

class SelectableColorView: UIView {
	var isSelected : Bool {
		didSet {
			setSelection()
		}
	}

	init(frame: CGRect, selected: Bool = false) {
		isSelected = selected
		super.init (frame: frame)
		setupView()
	}

	init (selected: Bool = false) {
		isSelected = selected
		super.init (frame: .zero)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		self.layer.cornerRadius = 5
		self.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		let tapGR = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
		self.addGestureRecognizer(tapGR)
		setSelection()
	}

	@objc func viewTapped() {
		isSelected = !isSelected
	}

	func setSelection() {
		self.layer.borderWidth = isSelected ? 3 : 0
	}

}
