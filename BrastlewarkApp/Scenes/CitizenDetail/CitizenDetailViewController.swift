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
//	the information in a nice size. I placed the image at the bottom because if the image was first,
//	citizen information was at the bottom of the scroll view and the user could miss it.
class CitizenDetailViewController: ObservableViewController, CitizenDetailView {

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
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	func setCitizenInformation(_ citizen: Citizen) {
		navigationItem.title = citizen.name
		friendsLabel.text = citizen.friends.joined(separator: ", ")
		hairColorLabel.text = citizen.hairColor
		weightLabel.text = citizen.weight.description
		heightLabel.text = citizen.height.description
		ageLabel.text = citizen.age.description
		setCitizenImage(url: citizen.imageURL)
		setProfessions(citizen.professions)
		setFriends(citizen.friends)
	}

	func setProfessions(_ professions: [String]) {
		guard professions.count > 0 else {
			professionsLabel.isHidden = true
			professionsTitleLabel.isHidden = true
			return
		}
		professionsLabel.text = professions.joined(separator: ", ")
	}

	func setFriends(_ friends: [String]) {
		guard friends.count > 0 else {
			friendsLabel.isHidden = true
			friendsTitleLabel.isHidden = true
			return
		}
		friendsLabel.text = friends.joined(separator: ", ")
	}

	//I did all this setup for the imageview to be able to display the whole image full width
	func setCitizenImage( url: URL ) {
		citizenImageView.kf.setImage(with: url)
		let imageViewRect = citizenImageView.contentClippingRect
		let ratio = imageViewRect.height / imageViewRect.width
		if imageViewRect.width < UIScreen.main.bounds.width {
			citizenImageView.contentMode = .scaleAspectFill
			citizenImageViewHeightConstraint.constant = UIScreen.main.bounds.width * ratio
		} else {
			citizenImageView.contentMode = .scaleAspectFit
			citizenImageViewHeightConstraint.constant = imageViewRect.height
		}
		view.layoutSubviews()
	}
}
