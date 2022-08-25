//
//  CanvasTestView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 2022.7.28.
//

import SwiftUI

struct CanvasTestView: View {
	var body: some View {
		VStack {
			Canvas { context, size in
				let containerWidth = size.width
				
				let count = 100
				let columnCount = count
				let rowCount = count
				
				let cellSize = containerWidth / CGFloat(count)
				let cellPadding = cellSize / 10
				
				let colors = [
					Color.blue,
					Color.green,
					Color.yellow,
					Color.orange,
					Color.red,
					Color.purple
				]
				
				for columnIndex in 0 ..< columnCount {
					for rowIndex in 0 ..< rowCount {
						
						let cellPath = Path(CGRect(
							x: CGFloat(columnIndex) * cellSize + cellPadding,
							y: CGFloat(rowIndex) * cellSize + cellPadding,
							width: cellSize - cellPadding * 2,
							height: cellSize - cellPadding * 2
						))
						
						let index = columnIndex + (rowIndex * columnCount)
						let color = colors[index % colors.count]
						
						context.fill(cellPath, with: .color(color))
					}
				}
			}
		}
		// .frame(width: 2000, height: 2000)
		.frame(width: 500, height: 500)
		// .frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct CanvasTestView_Previews: PreviewProvider {
	static var previews: some View {
		CanvasTestView()
	}
}
