//
//  View+frame.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/28/22.
//

import SwiftUI

extension View {
	func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
		frame(
			width: size,
			height: size,
			alignment: alignment
		)
	}
	
	func frame(size: CGSize, alignment: Alignment = .center) -> some View {
		frame(
			width: size.width,
			height: size.height,
			alignment: alignment
		)
	}
}
