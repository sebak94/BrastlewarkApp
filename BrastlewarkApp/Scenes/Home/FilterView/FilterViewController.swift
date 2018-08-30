//
//  FilterViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 29/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit
import TTRangeSlider
import RxSwift

struct FilterParameters {
	var friend: String
	var profession: String
	var name: String
	var hairColor: String
	var ageMin: Float
	var ageMax: Float
	var heightMin: Float
	var heightMax: Float
	var weightMin: Float
	var weightMax: Float
}

protocol FilterViewDelegate: class {
	func filtersApplied(with filters: [Filter])
}

class FilterViewController: UIViewController {
	weak var delegate: FilterViewDelegate?

	@IBOutlet weak var applyView: UIView!
	@IBOutlet weak var friendTextField: UITextField!
	@IBOutlet weak var professionTextField: UITextField!
	@IBOutlet weak var hairColorTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var ageRangeSlider: TTRangeSlider!
	@IBOutlet weak var heightRangeSlider: TTRangeSlider!
	@IBOutlet weak var weightRangeSlider: TTRangeSlider!

	var ageMax: Float?
	var ageMin: Float?
	var heightMax: Float?
	var heightMin: Float?
	var weightMax: Float?
	var weightMin: Float?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Filter"
		setupApplyButton()
		setupBackgroundTapGestureRecognizer()
		setupRangeSliders()
		setupTextFields()
		setupClearButton()
	}

	func setupClearButton() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: UIBarButtonSystemItem.trash,
			target: self,
			action: #selector(clearTapped)
		)
		navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
	}

	@objc func clearTapped() {
		setupRangeSliders()
		nameTextField.text = nil
		professionTextField.text = nil
		friendTextField.text = nil
		hairColorTextField.text = nil
	}

	func setupTextFields() {
		nameTextField.delegate = self
		professionTextField.delegate = self
		friendTextField.delegate = self
		hairColorTextField.delegate = self
	}

	func setupBackgroundTapGestureRecognizer() {
		let tapGR = UITapGestureRecognizer(target: self, action: #selector(backgroundWasTapped))
		self.view.addGestureRecognizer(tapGR)
	}

	@objc func backgroundWasTapped() {
		nameTextField.resignFirstResponder()
		professionTextField.resignFirstResponder()
		friendTextField.resignFirstResponder()
		hairColorTextField.resignFirstResponder()
	}

	func setupApplyButton() {
		let tapGR = UITapGestureRecognizer(target: self, action: #selector(applyButtonWasTapped))
		applyView.addGestureRecognizer(tapGR)
	}

	@objc func applyButtonWasTapped() {
		let filters = [
			Filter.ageRange([Int(ageRangeSlider.selectedMinimum),Int(ageRangeSlider.selectedMaximum)]),
			Filter.heightRange([Double(heightRangeSlider.selectedMinimum),Double(heightRangeSlider.selectedMaximum)]),
			Filter.weightRange([Double(weightRangeSlider.selectedMinimum),Double(weightRangeSlider.selectedMaximum)]),
			Filter.friend(friendTextField.text ?? ""),
			Filter.profession(professionTextField.text ?? ""),
			Filter.name(nameTextField.text ?? ""),
			Filter.hairColor(hairColorTextField.text ?? "")
		]
		delegate?.filtersApplied(with: filters)
		dismiss(animated: true, completion: nil)
	}

	func setRanges(
		ageMax: Float,
		ageMin: Float,
		heightMax: Float,
		heightMin: Float,
		weightMax: Float,
		weightMin: Float
	) {
		self.ageMax = ageMax
		self.ageMin = ageMin
		self.heightMax = heightMax
		self.heightMin = heightMin
		self.weightMax = weightMax
		self.weightMin = weightMin
	}

	func setupRangeSliders() {
		guard let ageMax = ageMax,
				let ageMin = ageMin,
				let heightMax = heightMax,
				let heightMin = heightMin,
				let weightMax = weightMax,
				let weightMin = weightMin
		else { return }
		ageRangeSlider.maxValue = ageMax
		ageRangeSlider.minValue = ageMin
		ageRangeSlider.selectedMaximum = ageMax
		ageRangeSlider.selectedMinimum = ageMin
		heightRangeSlider.maxValue = heightMax
		heightRangeSlider.minValue = heightMin
		heightRangeSlider.selectedMaximum = heightMax
		heightRangeSlider.selectedMinimum = heightMin
		weightRangeSlider.maxValue = weightMax
		weightRangeSlider.minValue = weightMin
		weightRangeSlider.selectedMaximum = weightMax
		weightRangeSlider.selectedMinimum = weightMin
	}
}

extension FilterViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
