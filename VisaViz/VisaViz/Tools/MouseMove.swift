//
//  MouseInsideMove.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import SwiftUI

extension View {
	func mouseMove(
		isInside: @escaping (Bool) -> Void,
		onMove: @escaping (NSPoint) -> Void
	) -> some View {
		MouseMoveView(
			isInside: isInside,
			onMove: onMove
		) { self }
	}
}

struct MouseMoveView<Content>: View where Content : View {
	let isInside: (Bool) -> Void
	let onMove: (NSPoint) -> Void
	let content: () -> Content
	
	init(
		isInside: @escaping (Bool) -> Void,
		onMove: @escaping (NSPoint) -> Void,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.isInside = isInside
		self.onMove = onMove
		self.content = content
	}
	
	var body: some View {
		MouseMoveRepresentable(
			isInside: isInside,
			onMove: onMove,
			content: self.content()
		)
	}
}

struct MouseMoveRepresentable<Content>: NSViewRepresentable where Content: View {
	let isInside: (Bool) -> Void
	let onMove: (NSPoint) -> Void
	let content: Content
	
	func makeNSView(context: Context) -> NSHostingView<Content> {
		return MouseNSHostingView(
			isInside: isInside,
			onMove: onMove,
			rootView: self.content
		)
	}
	
	func updateNSView(_ nsView: NSHostingView<Content>, context: Context) {
	}
}

class MouseNSHostingView<Content>: NSHostingView<Content> where Content : View {
	let isInside: (Bool) -> Void
	let onMove: (NSPoint) -> Void
	
	init(
		isInside: @escaping (Bool) -> Void,
		onMove: @escaping (NSPoint) -> Void,
		rootView: Content
	) {
		self.isInside = isInside
		self.onMove = onMove
		
		super.init(rootView: rootView)
		
		setupTrackingArea()
	}
	
	required init(rootView: Content) {
		fatalError("init(rootView:) has not been implemented")
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupTrackingArea() {
		let options: NSTrackingArea.Options = [
			.mouseEnteredAndExited,
			.mouseMoved,
			.activeInKeyWindow,
			.inVisibleRect
		]

		self.addTrackingArea(NSTrackingArea.init(rect: .zero, options: options, owner: self, userInfo: nil))
	}
	
	override func mouseEntered(with event: NSEvent) {
		self.isInside(true)
	}
	
	override func mouseExited(with event: NSEvent) {
		self.isInside(false)
	}

	override func mouseMoved(with event: NSEvent) {
		self.onMove(self.convert(event.locationInWindow, from: nil))
	}
}
