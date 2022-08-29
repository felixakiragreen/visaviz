//
//  ScrollViewOffset.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/27/22.
//

/// Copied from https://betterprogramming.pub/swiftui-calculate-scroll-offset-in-scrollviews-c3b121f0b0dc
/// Modified by me

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
	static var defaultValue: CGPoint = .zero
	static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) {}
}

struct OffsettableScrollView<Content: View>: View {
	let axes: Axis.Set
	let showsIndicator: Bool
	let onOffsetChange: (CGPoint) -> Void
	let content: Content

	init(
		axes: Axis.Set = .vertical,
		showsIndicator: Bool = true,
		onOffsetChange: @escaping (CGPoint) -> Void = { _ in },
		@ViewBuilder _ content: () -> Content
	) {
		self.axes = axes
		self.showsIndicator = showsIndicator
		self.onOffsetChange = onOffsetChange
		self.content = content()
	}

	var body: some View {
		ScrollView(axes, showsIndicators: showsIndicator) {
			offsetReader
			content
				.padding(.top, -8)
		}
		.coordinateSpace(name: "ScrollViewOrigin")
		.onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
	}
	
	var offsetReader: some View {
		GeometryReader { proxy in
			Color.clear.preference(
				key: OffsetPreferenceKey.self,
				value: proxy.frame(in: .named("ScrollViewOrigin")).origin
			)
		}
		.frame(width: 0, height: 0)
	}
}
