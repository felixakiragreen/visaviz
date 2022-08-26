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


// extension View {
// 	func mouseMove(
// 		isInside: @escaping (Bool) -> Void,
// 		onMove: @escaping (NSPoint) -> Void
// 	) -> some View {
// 		modifier(MouseMoveModifier(
// 			isInside: isInside,
// 			onMove: onMove
// 		))
// 	}
// }
//
// struct MouseMoveModifier: ViewModifier {
// 	let isInside: (Bool) -> Void
// 	let onMove: (NSPoint) -> Void
//
// 	init(
// 		isInside: @escaping (Bool) -> Void,
// 		onMove: @escaping (NSPoint) -> Void
// 	) {
// 		self.isInside = isInside
// 		self.onMove = onMove
// 	}
//
// 	func body(content: Content) -> some View {
// 		content.background(
// 			GeometryReader { proxy in
// 				Representable(
// 					isInside: isInside,
// 					onMove: onMove,
// 					frame: proxy.frame(in: .global)
// 				)
// 			}
// 		)
// 	}
//
// 	private struct Representable: NSViewRepresentable {
// 		let isInside: (Bool) -> Void
// 		let onMove: (NSPoint) -> Void
// 		let frame: NSRect
//
// 		func makeCoordinator() -> Coordinator {
// 			let coordinator = Coordinator()
// 			coordinator.isInside = isInside
// 			coordinator.onMove = onMove
// 			return coordinator
// 		}
//
// 		class Coordinator: NSResponder {
// 			var isInside: ((Bool) -> Void)?
// 			var onMove: ((NSPoint) -> Void)?
//
// 			override func mouseEntered(with event: NSEvent) {
// 				isInside?(true)
// 			}
//
// 			override func mouseExited(with event: NSEvent) {
// 				isInside?(false)
// 			}
//
// 			override func mouseMoved(with event: NSEvent) {
// 				onMove?(frame.convert event.l)
// 			}
// 		}
//
// 		func makeNSView(context: Context) -> NSView {
// 			let view = NSView(frame: frame)
//
// 			view.conv
//
// 			let options: NSTrackingArea.Options = [
// 				.mouseEnteredAndExited,
// 				.mouseMoved,
// 				.inVisibleRect,
// 				.activeInKeyWindow
// 			]
//
// 			let trackingArea = NSTrackingArea(rect: frame,
// 														 options: options,
// 														 owner: context.coordinator,
// 														 userInfo: nil)
//
// 			view.addTrackingArea(trackingArea)
//
// 			return view
// 		}
//
// 		func updateNSView(_ nsView: NSView, context: Context) {}
//
// 		static func dismantleNSView(_ nsView: NSView, coordinator: Coordinator) {
// 			nsView.trackingAreas.forEach { nsView.removeTrackingArea($0) }
// 		}
// 	}
// }
