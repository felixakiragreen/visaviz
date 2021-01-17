//
//  GridGenerator.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/17/21.
//

import Foundation

/**

TODO: move color randomization to HERE

! HOLY SHIT
- when calculating colors, because I'll know the grid, when I can also try not to do adjacent colors (to the top, not just to the left)
*/

class GridGenerator {

	var cellCount: Int /// total number of blocks
	var spaceSize: CGSize /// dimensions of the available space to fill
	
	var cellSize: CGFloat /// calculate width/height of each cell
	var cellSpace: CGFloat /// space between each cell
	var xCellCount: Int /// calculated number of cells along x-axis
	var yCellCount: Int /// calculated number of cells along y-axis
	
	
	
	
//	var block
	
	init() {
		self.cellCount = 0
		self.spaceSize = .zero
		self.cellSize = 0
		self.cellSpace = 0
		self.xCellCount = 0
		self.yCellCount = 0
	}
	
	
	
	func calculateSize(cellCount: Int, spaceSize: CGSize) -> Void {
		print("calculateSize(cellCount:\(cellCount), spaceSize:", spaceSize)
		self.cellCount = cellCount
		self.spaceSize = spaceSize
	
		let aspectRatio = spaceSize.width / spaceSize.height
		
		/// 1. calculate X & Y
		let x = sqrt(CGFloat(cellCount) * aspectRatio)
		let y = x / aspectRatio
		
//		print("calculateSize", x, y, aspectRatio)
		
		if x.isNormal && y.isNormal {
//			print("NORMAL")
			xCellCount = Int(ceil(x))
			yCellCount = Int(ceil(y))
		}
		
		
	}
	
	
	
//	func generate() -> [[Block]] {
//
//
//		return [[]]
//	}
	
}



struct Block {
	var tweet: Tweet
	
	// dimensions
}
