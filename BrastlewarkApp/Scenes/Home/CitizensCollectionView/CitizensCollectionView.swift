//
//  CitizensCollectionView.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit

class CitizensCollectionView: UICollectionView {
	var citizens : [CitizenToDisplay] = []

	let cellIdentifier = "CitizenCell"

	override func awakeFromNib() {
		super.awakeFromNib()
		self.dataSource = self
		self.delegate = self
		self.register(
			UINib.init(nibName: "CitizensCollectionViewCell", bundle: nil),
			forCellWithReuseIdentifier: cellIdentifier
		)
	}

	var selectedCitizenObservable: Observable<CitizenToDisplay> {
		return self.rx.itemSelected.asObservable()
			.map { indexPath in
				self.citizens[indexPath.row]
		}
	}
}

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
		guard let cell = self.dequeueReusableCell(
			withReuseIdentifier: cellIdentifier,
			for: indexPath
		) as? CitizensCollectionViewCell else { return UICollectionViewCell() }

		cell.citizen = citizens[indexPath.row]
		cell.reload()
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
