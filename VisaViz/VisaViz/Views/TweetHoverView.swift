//
//  TweetHoverView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Atoms
import SwiftUI

struct TweetHoverView: View {
	
	@WatchState(GridAtom())
	var grid
	
	var hover: CGPoint?
	
	var body: some View {
		VStack {
			if let hover {
				Text("Hover \(hover.x), \(hover.y)")
			}
		}
		.position(getPosition())
	}
	
	func getPosition() -> CGPoint {
		if let hover {
			return CGPoint(x: hover.x, y: hover.y)
		}
		
		return .zero
	}
}

struct TweetHoverView_Previews: PreviewProvider {
	static var previews: some View {
		TweetHoverView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
