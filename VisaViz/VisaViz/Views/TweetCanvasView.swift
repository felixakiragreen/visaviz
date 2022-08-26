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
	
	var body: some View {
		VStack {
			Canvas { context, size in
				let containerWidth = size.width

				let count = 100
				let columnCount = count
				let rowCount = count

				let cellSize = containerWidth / CGFloat(count)
				let cellPadding = cellSize / 10

				// let colors = [
				// 	Color.blue,
				// 	Color.green,
				// 	Color.yellow,
				// 	Color.orange,
				// 	Color.red,
				// 	Color.purple,
				// ]

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
		} // VStack
		.frame(width: 600, height: 600)
		// .frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct TweetCanvasView_Previews: PreviewProvider {
	static var previews: some View {
		AtomRoot {
			TweetCanvasView()
				.preferredColorScheme(.dark)
		}
	}
}
