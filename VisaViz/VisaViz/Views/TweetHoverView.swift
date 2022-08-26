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
			if hover == nil {
				Text("No hover")
			}
		}
	}
}

struct TweetHoverView_Previews: PreviewProvider {
	static var previews: some View {
		TweetHoverView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
