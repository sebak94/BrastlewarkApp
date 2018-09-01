//
//  CitizenDetailViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit
import Kingfisher

protocol CitizenDetailView {
	func setCitizenInformation( _ citizen: CitizenToDisplay )
}

class CitizenDetailViewController: ObservableViewController, CitizenDetailView {

	@IBOutlet weak var friendsViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var citizenImageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var friendsTitleLabel: UILabel!
	@IBOutlet weak var professionsTitleLabel: UILabel!
	@IBOutlet weak var citizenImageViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var friendsLabel: UILabel!
	@IBOutlet weak var professionsLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var citizenImageView: UIImageView!
	@IBOutlet weak var professionsView: UIView!
	@IBOutlet weak var basicInfoView: UIView!
	@IBOutlet weak var friendsView: UIView!
	@IBOutlet weak var hairColorView: UIView!
	@IBOutlet weak var genderLabel: UILabel!
	
	var originalImageView : UIImageView?
	
	func setCitizenInformation(_ citizen: CitizenToDisplay) {
		navigationItem.title = citizen.name
		weightLabel.text = citizen.weight
		heightLabel.text = citizen.height
		ageLabel.text = citizen.age
		setCitizenImage(url: citizen.imageURL)
		setProfessions(citizen.professions)
		setFriends(citizen.friends)
		setHairColor(citizen.hairColor)
		setupBackgroundViews()
		genderLabel.text = citizen.genderDescription
	}

	func setHairColor(_ color: UIColor) {
		hairColorView.layer.cornerRadius = 4
		hairColorView.backgroundColor = color
	}

	func setupBackgroundViews() {
		friendsView.layer.cornerRadius = 20
		basicInfoView.layer.cornerRadius = 20
		professionsView.layer.cornerRadius = 20
	}

	func setProfessions(_ professions: String) {
		guard professions.count > 0 else {
			professionsLabel.isHidden = true
			professionsTitleLabel.isHidden = true
			professionsView.isHidden = true
			friendsViewTopConstraint.constant = -90
			return
		}
		professionsLabel.text = professions
	}

	func setFriends(_ friends: String) {
		guard friends.count > 0 else {
			friendsLabel.isHidden = true
			friendsTitleLabel.isHidden = true
			friendsView.isHidden = true
			citizenImageViewTopConstraint.constant = -90
			return
		}
		friendsLabel.text = friends
	}

	func setCitizenImage( url: URL ) {
		citizenImageView.kf.setImage(with: url) { [weak self] image,_,_,_ in
			guard let sSelf = self,
					let image = image
			else { return }
			sSelf.citizenImageView.layer.cornerRadius = 20
			let ratio = image.size.height / image.size.width
			sSelf.citizenImageViewHeightConstraint.constant = (UIScreen.main.bounds.width - 32) * ratio
			sSelf.view.layoutSubviews()
		}
	}
}
