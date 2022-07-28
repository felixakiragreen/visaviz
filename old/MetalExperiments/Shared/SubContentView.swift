//
//  SubContentView.swift
//  MetalExperiments
//
//  Created by Felix Akira Green on 1/19/21.
//

import struct Forge.ForgeView
import SwiftUI

struct SubContentView: View {
//	init(text: String) {
//		self.text = text
//		self.renderer =
//	}

	@Binding var text: String

	var body: some View {
		let renderer = RendererText(lala: text)
		let renderer2 = Renderer()

		VStack {
			ForgeView(renderer: renderer)
			ForgeView(renderer: renderer2)
		}
	}
}

struct SubContentView_Previews: PreviewProvider {
	static var previews: some View {
		SubContentView(text: .constant("preview me"))
	}
}
