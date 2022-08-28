//
//  TweetCanvasView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import SwiftUI

struct TweetCanvasView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@Watch(TweetVisualsAtom())
	var visuals
	
	@WatchState(GridAtom())
	var grid
	
	@WatchState(ScrollAtom())
	var scroll
	
	var size: CGSize
	var width: CGFloat {
		size.width
	}

	var body: some View {
		VStack {
			let columnCount = grid.columns
			let rowCount = grid.rows
			
			let cellSize = grid.cellWidth
			let cellPadding = grid.cellPadding
			
			let rowsInView = ceil(size.height / cellSize) + 2 // adding 2 for buffer
			let rowsScrolled = floor(abs(scroll) / cellSize) - 1 // removing first

			// let rowCountMax = Int(ceil(Double(visuals.count) / Double(columnCount)))
			// let rowCount = max(10, rowCountMax)
			//
			// let cellSize = width / CGFloat(columnCount)
			// let cellPadding = cellSize / 10
			
			Canvas { context, size in
				for columnIndex in 0 ..< columnCount {
					for rowIndex in 0 ..< rowCount {
						let row = CGFloat(rowIndex)
						/// check if row is in View
						if row > rowsScrolled,
							row < rowsScrolled + rowsInView {
							// context.fill(cellPath, with: .color(Color(.green, 500)))
							
							let cellPath = Path(CGRect(
								x: CGFloat(columnIndex) * cellSize + cellPadding,
								y: CGFloat(rowIndex) * cellSize + cellPadding,
								width: cellSize - cellPadding * 2,
								height: cellSize - cellPadding * 2
							))
							
							let index = columnIndex + (rowIndex * columnCount)
							if visuals[optional: index] != nil {
								let tweet = visuals[index]
								// let lit = 700 - (tweet.lit * 100)
								// let color = Color(tweet.hue, lit)
								
								context.fill(cellPath, with: .color(tweet.clr))
							} else {
								// context.fill(cellPath, with: .color(Color(.grey, 800)))
							}
							
						}
						/// else if not in view, DO NOT RENDER
						else {
							// context.fill(cellPath, with: .color(Color(.blue, 500)))
						}
					}
				}
			} // Canvas
			.frame(minHeight: CGFloat(rowCount) * cellSize)
			.onAppear {
				grid.calcCells(size: size)
			}
			.onChange(of: size) {
				if grid.container != $0 {
					grid.calcCells(size: $0)
				}
			}
		} // VStack
		// .background(Color(.orange, 400).opacity(0.2))
	}
}

struct TweetCanvasView_Previews: PreviewProvider {
	static var previews: some View {
		TweetCanvasView(
			size: CGSize(width: 600, height: 480)
		)
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
