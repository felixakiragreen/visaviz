//
//  GridView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/13/21.
//

import SwiftUI

// MARK: - PREVIEW
struct GridView_Previews: PreviewProvider {
	static var previews: some View {
		GridView()
	}
}


struct GridView: View {
	// MARK: - PROPS
	
	struct Config {
		var quantity: Int = 100
		var size: CGFloat = 10.0
		var space: CGFloat = 2.0
	}
	
	var config = Config()
	
	// MARK: - BODY
	var body: some View {
		LazyVGrid(columns: [GridItem(.adaptive(minimum: config.size, maximum: 100.0), spacing: config.space)], spacing: config.space, content: {
			ForEach(0..<config.quantity) { n in
				Rectangle()
					.foregroundColor(.blue)
					.frame(height: config.size)
			}
		})
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
