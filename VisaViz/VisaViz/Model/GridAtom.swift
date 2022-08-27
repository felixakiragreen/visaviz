//
//  GridAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//


import Atoms
import Foundation

struct GridAtom: StateAtom, Hashable {
	func defaultValue(context: Context) -> GridParams {
		return GridParams()
	}
}

struct GridParams: Hashable {
	var columns: Int = 100
	var rows: Int = GridParams.minRows
	
	static let minRows = 10

	var container: CGSize = .zero
	var cellCount: Int = 0
	
	var cellWidth: CGFloat = 0
	var cellPadding: CGFloat = 0

	@inlinable
	mutating func calcRows(count: Int) {
		print("calcRows, c: \(count)")
		cellCount = count
		let rowsMax = Int(
			ceil(
				Double(count) / Double(columns)
			)
		)
		rows = max(GridParams.minRows, rowsMax)
	}
	
	@inlinable
	mutating func recalcRows() {
		print("recalcRows")
		let rowsMax = Int(
			ceil(
				Double(cellCount) / Double(columns)
			)
		)
		rows = max(GridParams.minRows, rowsMax)
	}
	
	@inlinable
	mutating func calcCells(size: CGSize) {
		print("calcCells, w:\(size.width) h:\(size.height)")
		container = size
		cellWidth = size.width / CGFloat(columns)
		cellPadding = cellWidth / 10
	}
	
	@inlinable
	mutating func recalcCells() {
		print("recalcCells, w: \(container.width)")
		cellWidth = container.width / CGFloat(columns)
		cellPadding = cellWidth / 10
	}
}
