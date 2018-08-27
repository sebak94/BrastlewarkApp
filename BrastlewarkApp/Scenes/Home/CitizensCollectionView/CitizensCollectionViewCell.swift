//
//  CitizensCollectionViewCell.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//
import Kingfisher
import UIKit

class CitizensCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var citizenImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!

	var citizen : Citizen?
	
	public func reload() {
		guard let citizen = citizen else { return }
		nameLabel.text = citizen.name
		citizenImageView.kf.setImage(with: citizen.imageURL)
	}

}
