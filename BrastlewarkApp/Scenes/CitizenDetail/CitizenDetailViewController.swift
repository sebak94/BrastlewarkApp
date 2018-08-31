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
	func setCitizenInformation( _ citizen: Citizen )
}

//	I decided to use a scroll view so i could show the image full size, and still display
//	the information in a nice size. I placed the image at the bottom because if the image was
//	first, citizen information was at the bottom of the scroll view and the user could miss it.
class CitizenDetailViewController: ObservableViewController, CitizenDetailView {

	@IBOutlet weak var friendsViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var citizenImageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var friendsTitleLabel: UILabel!
	@IBOutlet weak var professionsTitleLabel: UILabel!
	@IBOutlet weak var citizenImageViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var friendsLabel: UILabel!
	@IBOutlet weak var professionsLabel: UILabel!
	@IBOutlet weak var hairColorLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var citizenImageView: UIImageView!
	@IBOutlet weak var professionsView: UIView!
	@IBOutlet weak var basicInfoView: UIView!
	@IBOutlet weak var friendsView: UIView!

	var originalImageView : UIImageView?
	
	func setCitizenInformation(_ citizen: Citizen) {
		navigationItem.title = citizen.name
		friendsLabel.text = citizen.friends.joined(separator: ", ")
		hairColorLabel.text = citizen.hairColor
		weightLabel.text = citizen.weight.description(decimalPlaces: 2)
		heightLabel.text = citizen.height.description(decimalPlaces: 2)
		ageLabel.text = citizen.age.description
		setCitizenImage(url: citizen.imageURL)
		setProfessions(citizen.professions)
		setFriends(citizen.friends)
		setupBackgroundViews()
	}

	func setupBackgroundViews() {
		friendsView.layer.cornerRadius = 20
		basicInfoView.layer.cornerRadius = 20
		professionsView.layer.cornerRadius = 20
	}

	func setProfessions(_ professions: [String]) {
		guard professions.count > 0 else {
			professionsLabel.isHidden = true
			professionsTitleLabel.isHidden = true
			professionsView.isHidden = true
			friendsViewTopConstraint.constant = -90
			return
		}
		professionsLabel.text = professions.joined(separator: " | ")
	}

	func setFriends(_ friends: [String]) {
		guard friends.count > 0 else {
			friendsLabel.isHidden = true
			friendsTitleLabel.isHidden = true
			friendsView.isHidden = true
			citizenImageViewTopConstraint.constant = -60
			return
		}
		friendsLabel.text = friends.joined(separator: " | ")
	}

	func setCitizenImage( url: URL ) {
		citizenImageView.kf.setImage(with: url) { [weak self] image,_,_,_ in
			guard let sSelf = self,
					let image = image
			else { return }
			sSelf.citizenImageView.layer.cornerRadius = 20
			let ratio = image.size.height / image.size.width
			sSelf.citizenImageViewHeightConstraint.constant =
				sSelf.citizenImageView.frame.width * ratio
			sSelf.view.layoutSubviews()
		}
	}
}
