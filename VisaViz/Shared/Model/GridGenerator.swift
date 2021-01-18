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

class GridGenerator: ObservableObject {

	var cellCount: Int /// total number of blocks
	var spaceSize: CGSize /// dimensions of the available space to fill
	
	var cellSize: CGFloat /// calculate width/height of each cell
	var cellSpace: CGFloat /// space between each cell
	var xCellCount: Int /// calculated number of cells along x-axis
	var yCellCount: Int /// calculated number of cells along y-axis
	
	var idCounter: Int = 0
	func tallyId() -> Void { self.idCounter += 1 }
	
//	var block
	
	init() {
		self.cellCount = 0
		self.spaceSize = .zero
		self.cellSize = 0
		self.cellSpace = 0
		self.xCellCount = 0
		self.yCellCount = 0
	}
	
	init(cellCount: Int, spaceSize: CGSize) {
		self.cellCount = cellCount
		self.spaceSize = spaceSize
		self.cellSize = 0
		self.cellSpace = 0
		self.xCellCount = 0
		self.yCellCount = 0
	}
	
//	(x: Int, y: Int)
	
	/// Run at the beginning
	func calculateCounts(cellCount: Int, spaceSize: CGSize) -> Void {
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
	
//	func calculateSize()
	
	/// Run when tweets are loaded
	func generate(tweets: [Tweet]) -> [[Block]] {

		var grid = Array(
			repeating: Array(
				repeating: Block(id: 0), count: xCellCount
			),
			count: yCellCount
		)
		
		for i in grid.indices {
			for j in grid[i].indices {
				
				if idCounter < cellCount {
					grid[i][j] = Block(
						id: idCounter,
						tweet: tweets[idCounter],
						cell: (x: j, y: i)
//						xCell: j,
//						yCell: i
//						offset: CGSize
//						color: <#T##ColorPreset?#>
					)
					
					tallyId()
				}
			}
		}
		
		return grid
	}
	
}



struct Block: Identifiable {
	let id: Int
	var tweet: Tweet?
	var cell: (x: Int, y: Int) = (0, 0)
//	var xCell: Int = 0
//	var yCell: Int = 0
//	var offset: CGSize = .zero - (can be calculated in the view)
	var color: ColorPreset?
}

struct BlockRect: Identifiable, Equatable {
	let id: Int
	let x: CGFloat
	let y: CGFloat
	let w: CGFloat
	let h: CGFloat
	let t: Tweet
}

func gridToRect(grid: [[Block]], size: CGFloat, pad: CGFloat) -> [BlockRect] {
	var rects = [BlockRect]()
	
	for i in grid.indices {
		for j in grid[i].indices {
			if let tweet = grid[i][j].tweet {
				rects.append(
					BlockRect(
						id: grid[i][j].id,
						x: CGFloat(grid[i][j].cell.x) * (size + pad),
						y: CGFloat(grid[i][j].cell.y) * (size + pad),
						w: size, h: size,
						t: tweet
					)
				)
			}
		}
	}
	
	return rects
}
