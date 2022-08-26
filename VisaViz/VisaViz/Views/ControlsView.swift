//
//  TweetListView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import SwiftUI

struct TweetListView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@Watch(TopColorsAtom())
	var topColors

	@WatchState(GridAtom())
	var grid

	@State private var columnCount: Double = 0

	var body: some View {
		VStack {
			HStack {
				Text("Tweets: \(archive.allTweets.count)")

				Button("Load") {
					loadFromFile()
				}
				Button("Replies") {
					archive.generateReplies()
				}
				Text("Columns: \(Int(columnCount))")
			}
			Slider(value: $columnCount, in: 50 ... 500, step: 10, onEditingChanged: {
				/// closure value will be false when editing is done
				if $0 == false {
					grid.columns = Int(columnCount)
					grid.recalcCells()
				}
			})
				.onAppear {
					columnCount = Double(grid.columns)
				}
			HStack {
				HStack(spacing: 4) {
					ForEach(topColors.sorted(by: { $0.value.1 > $1.value.1 }), id: \.value.0) { tc in
						RoundedRectangle(cornerRadius: 4, style: .continuous)
							.foregroundColor(Color(tc.value.0, 400))
							.frame(width: 16, height: 16)
						Text("\(tc.key) (\(tc.value.1))")
					}
				}
			}
		}
	}

	@MainActor
	func loadFromFile() {
		Task {
			await archive.load()
		}
	}
}

struct TweetListView_Previews: PreviewProvider {
	static var previews: some View {
		TweetListView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
