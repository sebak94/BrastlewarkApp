//
//  UIImageViewHelper.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 27/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	var contentClippingRect: CGRect {
		guard let image = image else { return bounds }
		guard contentMode == .scaleAspectFit else { return bounds }
		guard let imageWidthInt = image.cgImage?.width,
				let imageHeightInt = image.cgImage?.height,
			imageWidthInt > 0 && imageHeightInt > 0,
				let scale = scale
		else { return bounds }

		let imageWidth = CGFloat(imageWidthInt)
		let imageHeight = CGFloat(imageHeightInt)

		let size = CGSize(width: imageWidth * scale, height: imageHeight * scale)
		let x = (bounds.width - size.width) / 2.0
		let y = (bounds.height - size.height) / 2.0

		return CGRect(x: x, y: y, width: size.width, height: size.height)
	}

	var scale: CGFloat? {
		guard let image = image,
				let imageWidthInt = image.cgImage?.width,
				let imageHeightInt = image.cgImage?.height,
				imageWidthInt > 0 && imageHeightInt > 0 else { return nil }
				let scale: CGFloat

			let imageWidth = CGFloat(imageWidthInt)
			let imageHeight = CGFloat(imageHeightInt)

			if imageWidth > imageHeight {
				scale = bounds.width / imageWidth
			} else {
				scale = bounds.height / imageHeight
			}

			return scale
	}
}
