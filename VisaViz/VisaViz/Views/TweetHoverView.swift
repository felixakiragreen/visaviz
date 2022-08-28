//
//  TweetHoverView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Atoms
import SwiftUI

struct TweetHoverView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@Watch(TweetVisualsAtom())
	var visuals

	@WatchState(GridAtom())
	var grid

	@WatchState(ScrollAtom())
	var scroll

	var hover: CGPoint

	var container = CGSize(width: 300, height: 200)
	
	@State private var window: CGSize = .zero
	
	var body: some View {
		if let tweetIndex = getTweetIndex() {
			let tweet = archive.allTweets[tweetIndex]
			let vis = visuals[tweetIndex]
			
			ZStack(alignment: .topLeading) {
				ZStack {
					TweetView(
						tweet: tweet,
						vis: vis,
						size: container
					)
				}
				.frame(size: getQuadrantSize(), alignment: getQuadrantAlignment())
				.offset(getQuadrantOffset())
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.background(
				GeometryReader { geo in
					Color.clear
						.onAppear {
							window = geo.size
						}
						.onChange(of: geo.size) { newSize in
							window = newSize
						}
				}
			)
		
			RoundedRectangle(cornerRadius: 4, style: .continuous)
				.foregroundColor(vis.clr)
				.frame(size: 16)
				.position(hover)
				.allowsHitTesting(false)
		}
	}
	
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

	func getTweetIndex() -> Int? {
		let slot = getCellSlot()
		let columnIndex = slot.0
		let rowIndex = slot.1

		let index = columnIndex + (rowIndex * grid.columns)

		if index < archive.allTweets.count {
			return index
		}

		return nil
	}
}

struct TweetHoverView_Previews: PreviewProvider {
	static var previews: some View {
		TweetHoverView(hover: .zero)
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
