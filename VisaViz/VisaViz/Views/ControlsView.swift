//
//  ControlsView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import SwiftUI

struct ControlsView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	@Watch(MostInteractionsByColorAtom())
	var interactions

	@WatchState(GridAtom())
	var grid

	@State private var columnCount: Double = 0
	
	/// (bin: Int, count: Int)
	@State private var histogram: [(Int, Int)] = []

	var body: some View {
		VStack {
			HStack {
				LoadFileButton()

				Text("Tweets: \(archive.allTweets.count)")

				Button("Colorize") {
					archive.generateReplies()
				}
			

				// Button("max?") {
				// 	let max = archive.computeMax()
				// 	print("max: \(max)")
				// }

				Button("Histogram") {
					let _histogram = archive.computeHistogram()
					histogram = _histogram.sorted(by: { $0.key < $1.key })
					
					// print("histogram: \(histogram.map { "\($0.0).\($0.1)" })")
				}

				// HStack {
				// 	Text("Levels: \(Histogram.shared.lightLevels)")
				// 	Button("+") {
				// 		Histogram.shared.lightLevels += 1
				// 	}
				// 	Button("-") {
				// 		Histogram.shared.lightLevels -= 1
				// 	}
				// }
			}

			HStack {
				Text("Columns: \(Int(columnCount))")
					.frame(width: 120)
				
				Slider(value: $columnCount, in: 50 ... 500, step: 10, onEditingChanged: {
					/// closure value will be false when editing is done
					if $0 == false {
						grid.columns = Int(columnCount)
						grid.recalcRows()
						grid.recalcCells()
					}
				})
				.onAppear {
					columnCount = Double(grid.columns)
				}
			}

			interactionsView
			
			histogramView
		}
	}

	@MainActor
	func loadFromFile() {
		Task {
			await archive.load()
		}
	}
	
	var interactionsView: some View {
		HStack(spacing: 16) {
			ForEach(interactions.sorted(by: { $0.value.1 > $1.value.1 }), id: \.value.0) { tc in
				HStack(spacing: 4) {
					RoundedRectangle(cornerRadius: 4, style: .continuous)
						.foregroundColor(Color(tc.value.0, 400))
						.frame(width: 16, height: 16)
					Text("\(tc.key)")
						.foregroundColor(Color(tc.value.0, 200))
					Text("\(tc.value.1)")
						.foregroundColor(Color(.grey, 400))
						.font(.system(.body, design: .monospaced))
				}
			}
		}
	}
	
	var histogramView: some View {
		HStack(spacing: 16) {
			ForEach(histogram.sorted(by: { $0.0 < $1.0 }), id: \.0) { hb in
				HStack(spacing: 4) {
					RoundedRectangle(cornerRadius: 4, style: .continuous)
						.foregroundColor(Color(.grey, Histogram.shared.getLightness(lvl: hb.0)))
						.frame(width: 16, height: 16)
					// Text("\(hb.0)")
					Text("\(hb.1)")
						.foregroundColor(Color(.grey, 400))
						.font(.system(.body, design: .monospaced))
				}
			}
		}
	}
}

struct ControlsView_Previews: PreviewProvider {
	static var previews: some View {
		ControlsView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
