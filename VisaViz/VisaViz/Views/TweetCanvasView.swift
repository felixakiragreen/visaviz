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
	
	var containerWidth: CGFloat
	var hover: CGPoint?

	var body: some View {
		VStack {
			let columnCount = grid.columns
			let rowCount = grid.rows
			
			let cellSize = grid.cellWidth
			let cellPadding = grid.cellPadding

			// let rowCountMax = Int(ceil(Double(visuals.count) / Double(columnCount)))
			// let rowCount = max(10, rowCountMax)
			//
			// let cellSize = containerWidth / CGFloat(columnCount)
			// let cellPadding = cellSize / 10
			
			Canvas { context, size in
				for columnIndex in 0 ..< columnCount {
					for rowIndex in 0 ..< rowCount {
						let cellPath = Path(CGRect(
							x: CGFloat(columnIndex) * cellSize + cellPadding,
							y: CGFloat(rowIndex) * cellSize + cellPadding,
							width: cellSize - cellPadding * 2,
							height: cellSize - cellPadding * 2
						))

						let index = columnIndex + (rowIndex * columnCount)
						if visuals[optional: index] != nil {
							let color = Color(visuals[index].hue, 400)

							context.fill(cellPath, with: .color(color))
						}
					}
				}
			} // Canvas
			.frame(minHeight: CGFloat(rowCount) * cellSize)
			.onAppear {
				grid.calcCells(width: containerWidth)
			}
			.onChange(of: containerWidth) {
				if grid.containerWidth != $0 {
					grid.calcCells(width: $0)
				}
			}
		} // VStack
		// .background(Color(.orange, 400).opacity(0.2))
	}
}

struct TweetCanvasView_Previews: PreviewProvider {
	static var previews: some View {
		TweetCanvasView(containerWidth: 600)
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
