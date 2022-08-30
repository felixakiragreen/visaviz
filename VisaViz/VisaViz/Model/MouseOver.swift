//
//  MouseOver.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import SwiftUI

struct MouseOver: Hashable {
	var window: CGSize
	var grid: GridParams
	var scroll: CGFloat
	var hover: CGPoint

	enum Quadrant {
		case topLeft, topRight, bottomLeft, bottomRight
	}

	func getHoverQuadrant() -> Quadrant {
		let isLeft = hover.x < grid.container.width / 2
		let isTop = hover.y < grid.container.height / 2

		if isTop {
			return isLeft ? .topLeft : .topRight
		}
		else {
			return isLeft ? .bottomLeft : .bottomRight
		}
	}

	func getQuadrantOffset() -> CGSize {
		let quadrant = getHoverQuadrant()

		let forRight: CGFloat = 0
		let forLeft: CGFloat = hover.x
		let forBottom: CGFloat = 0
		let forTop: CGFloat = hover.y

		switch quadrant {
			case .topLeft: return CGSize(width: forLeft, height: forTop)
			case .topRight: return CGSize(width: forRight, height: forTop)
			case .bottomLeft: return CGSize(width: forLeft, height: forBottom)
			case .bottomRight: return CGSize(width: forRight, height: forBottom)
		}
	}

	func getQuadrantSize() -> CGSize {
		let quadrant = getHoverQuadrant()

		if window == .zero {
			return .zero
		}

		let forLeft: CGFloat = window.width - hover.x
		let forRight: CGFloat = hover.x
		let forTop: CGFloat = window.height - hover.y
		let forBottom: CGFloat = hover.y
		
		if forLeft < 0 || forRight < 0 || forTop < 0 || forBottom < 0 {
			print("break")
		}

		switch quadrant {
			case .topLeft: return CGSize(width: forLeft, height: forTop)
			case .topRight: return CGSize(width: forRight, height: forTop)
			case .bottomLeft: return CGSize(width: forLeft, height: forBottom)
			case .bottomRight: return CGSize(width: forRight, height: forBottom)
		}
	}

	func getQuadrantAlignment() -> Alignment {
		let quadrant = getHoverQuadrant()

		switch quadrant {
			case .topLeft: return .topLeading
			case .topRight: return .topTrailing
			case .bottomLeft: return .bottomLeading
			case .bottomRight: return .bottomTrailing
		}
	}

	func getCellSlot() -> (Int, Int) {
		let columnIndex = Int(floor(
			hover.x / grid.cellWidth
		))
		let rowIndex = Int(floor(
			(hover.y - scroll) / grid.cellWidth
		))

		return (columnIndex, rowIndex)
	}

	func getTweetIndex() -> Int {
		let slot = getCellSlot()
		let columnIndex = slot.0
		let rowIndex = slot.1

		let index = columnIndex + (rowIndex * grid.columns)

		return index
	}
}
