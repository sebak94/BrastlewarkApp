//
//  CitizensCollectionView.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

class CitizensCollectionView: UICollectionView {
	var citizens : [Citizen] = []

	override func awakeFromNib() {
		super.awakeFromNib()
		self.dataSource = self
		self.delegate = self
		self.register(
			UINib.init(nibName: "CitizensCollectionViewCell", bundle: nil),
			forCellWithReuseIdentifier: "CitizenCell"
		)
	}
}

extension CitizensCollectionView: UICollectionViewDelegate {}

extension CitizensCollectionView: UICollectionViewDataSource {
	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int
	{
		return citizens.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell
	{
		let cell = self.dequeueReusableCell(
			withReuseIdentifier: "CitizenCell",
			for: indexPath
		) as! CitizensCollectionViewCell

		cell.configure(with: citizens[indexPath.row])

		return cell
	}
}

extension CitizensCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize
	{
		let screenWidth = UIScreen.main.bounds.width
		return CGSize(width: screenWidth / 2, height: screenWidth / 2)
	}
}
