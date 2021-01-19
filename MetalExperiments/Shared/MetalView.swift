//
//  MetalView.swift
//  MetalExperiments
//
//  Created by Felix Akira Green on 1/19/21.
//

import MetalKit
import SwiftUI

/*

 #if os(iOS)
 public struct MetalView<Content>: UIViewRepresentable where Content: MetalPresenting {
 	 public var wrappedView: Content
	 
 	 private var handleUpdateUIView: ((Content, Context) -> Void)?
 	 private var handleMakeUIView: ((Context) -> Content)?
	 
 	 public init(closure: () -> Content) {
 		  wrappedView = closure()
 	 }
	 
 	 public func makeUIView(context: Context) -> Content {
 		  guard let handler = handleMakeUIView else {
 				return wrappedView
 		  }
		  
 		  return handler(context)
 	 }
	 
 	 public func updateUIView(_ uiView: Content, context: Context) {
 		  handleUpdateUIView?(uiView, context)
 	 }
 }

 public extension MetalView {
 	 mutating func setMakeUIView(handler: @escaping (Context) -> Content) -> Self {
 		  handleMakeUIView = handler
		  
 		  return self
 	 }
	 
 	 mutating func setUpdateUIView(handler: @escaping (Content, Context) -> Void) -> Self {
 		  handleUpdateUIView = handler
		  
 		  return self
 	 }
 }
 #elseif os(macOS)
 public struct MetalView<Content>: NSViewRepresentable {
 	 public typealias NSViewType = Content
	 
 	 public var wrappedView: Content
	 
 	 private var handleUpdateNSView: ((Content, Context) -> Void)?
 	 private var handleMakeNSView: ((Context) -> Content)?
	 
 	 public init(closure: () -> Content) {
 		  wrappedView = closure()
 	 }
	 
 	 public func makeNSView(context: Context) -> Content {
 		  guard let handler = handleMakeNSView else {
 				return wrappedView
 		  }
		  
 		  return handler(context)
 	 }
	 
 	 public func updateNSView(_ nsView: Content, context: Context) {
 		  handleUpdateNSView?(nsView, context)
 	 }
 }

 public extension MetalView {
 	 mutating func setMakeNSView(handler: @escaping (Context) -> Content) -> Self {
 		  handleMakeNSView = handler
		  
 		  return self
 	 }
	 
 	 mutating func setUpdateNSView(handler: @escaping (Content, Context) -> Void) -> Self {
 		  handleUpdateNSView = handler
		  
 		  return self
 	 }
 }

 #endif
 */

/*
import MetalKit

struct MetalView: NSViewRepresentable {
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
		let mtkView = MTKView()
		mtkView.delegate = context.coordinator
		mtkView.preferredFramesPerSecond = 60
		mtkView.enableSetNeedsDisplay = true
		if let metalDevice = MTLCreateSystemDefaultDevice() {
			mtkView.device = metalDevice
		}
		mtkView.framebufferOnly = false
		mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
		mtkView.drawableSize = mtkView.frame.size
		mtkView.enableSetNeedsDisplay = true
		return mtkView
	}

	func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {}

	class Coordinator: NSObject, MTKViewDelegate {
		var parent: MetalView
		var metalDevice: MTLDevice!
		var metalCommandQueue: MTLCommandQueue!
		  
		init(_ parent: MetalView) {
			self.parent = parent
			if let metalDevice = MTLCreateSystemDefaultDevice() {
				self.metalDevice = metalDevice
			}
			self.metalCommandQueue = metalDevice.makeCommandQueue()!
			super.init()
		}

		func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

		func draw(in view: MTKView) {
			guard let drawable = view.currentDrawable else {
				return
			}
			let commandBuffer = metalCommandQueue.makeCommandBuffer()
			let rpd = view.currentRenderPassDescriptor
			rpd?.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 0, 1)
			rpd?.colorAttachments[0].loadAction = .clear
			rpd?.colorAttachments[0].storeAction = .store
			let re = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd!)
			re?.endEncoding()
			commandBuffer?.present(drawable)
			commandBuffer?.commit()
		}
	}
}

*/

import MetalKit

import Forge



//struct MetalView: NSViewRepresentable {
//	func makeCoordinator() -> Forge.Renderer {
//		Forge.Renderer(self)
//	}
//
//	func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
//		let mtkView = MTKView()
//
//		mtkView.delegate = context.coordinator
//		mtkView.preferredFramesPerSecond = 60
//		mtkView.enableSetNeedsDisplay = true
//		if let metalDevice = MTLCreateSystemDefaultDevice() {
//			mtkView.device = metalDevice
//		}
//		mtkView.framebufferOnly = false
//		mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
//		mtkView.drawableSize = mtkView.frame.size
//		mtkView.enableSetNeedsDisplay = true
//		return mtkView
//	}
//
//	func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {}
//}
//
