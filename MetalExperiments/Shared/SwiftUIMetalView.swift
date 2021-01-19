//
//  SwiftUIMetalView.swift
//  MetalExperiments
//
//  Created by Felix Akira Green on 1/19/21.
//

//import SwiftUI
//import AppKit
//import MetalKit
//import Forge
//
//struct SwiftUIMetalForgeView: NSViewControllerRepresentable {
//	let controller: Forge.ViewController?
//	typealias NSViewControllerType = Forge.ViewController
//	
//	func makeNSViewController(context: Context) -> ViewController {
//		guard let controller = controller else {
//			return Forge.ViewController()
//		}
//		
//		return controller
//	}
//	
//	func updateNSViewController(_ nsViewController: ViewController, context: Context) {
//		//
//	}
//	
//}

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

/*
struct ContentView: View {
	 var body: some View {
		  List {
				SwiftUIView {
					 MetalView()
				}
				SwiftUIView {
					 MetalView()
				}
				SwiftUIView {
					 MetalView()
				}
				SwiftUIView {
					 MetalView()
				}
		  }
	 }
}

struct ContentView_Previews: PreviewProvider {
	 static var previews: some View {
		  ContentView()
	 }
}

// MARK: SwiftUI + Metal
public struct SwiftUIView: UIViewRepresentable {
	 public var wrappedView: UIView
	 
	 private var handleUpdateUIView: ((UIView, Context) -> Void)?
	 private var handleMakeUIView: ((Context) -> UIView)?
	 
	 public init(closure: () -> UIView) {
		  wrappedView = closure()
	 }
	 
	 public func makeUIView(context: Context) -> UIView {
		  guard let handler = handleMakeUIView else {
				return wrappedView
		  }
		  
		  return handler(context)
	 }
	 
	 public func updateUIView(_ uiView: UIView, context: Context) {
		  handleUpdateUIView?(uiView, context)
	 }
}

public extension SwiftUIView {
	 mutating func setMakeUIView(handler: @escaping (Context) -> UIView) -> Self {
		  handleMakeUIView = handler
		  
		  return self
	 }
	 
	 mutating func setUpdateUIView(handler: @escaping (UIView, Context) -> Void) -> Self {
		  handleUpdateUIView = handler
		  
		  return self
	 }
}

// MARK: Metal Stuff

class MetalView: MTKView {
	 var renderer: Renderer!
	 
	 init() {
		  super.init(frame: .zero, device: MTLCreateSystemDefaultDevice())
		  // Make sure we are on a device that can run metal!
		  guard let defaultDevice = device else {
				fatalError("Device loading error")
		  }
		  colorPixelFormat = .bgra8Unorm
		  // Our clear color, can be set to any color
		  clearColor = MTLClearColor(red: 0.1, green: 0.57, blue: 0.25, alpha: 1)
		  createRenderer(device: defaultDevice)
	 }
	 
	 required init(coder: NSCoder) {
		  fatalError("init(coder:) has not been implemented")
	 }
	 
	 func createRenderer(device: MTLDevice){
		  renderer = Renderer(device: device)
		  delegate = renderer
	 }
	 
}

// MARK: Renderer

struct Vertex {
	 var position: float3
	 var color: float4
}

class Renderer: NSObject {
	 var commandQueue: MTLCommandQueue!
	 var renderPipelineState: MTLRenderPipelineState!
	 
	 var vertexBuffer: MTLBuffer!
	 var vertices: [Vertex] = [
		  Vertex(position: float3(0,1,0), color: float4(1,0,0,1)),
		  Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1)),
		  Vertex(position: float3(1,-1,0), color: float4(0,0,1,1))
	 ]
	 
	 init(device: MTLDevice) {
		  super.init()
		  createCommandQueue(device: device)
		  createPipelineState(device: device)
		  createBuffers(device: device)
	 }
	 
	 //MARK: Builders
	 func createCommandQueue(device: MTLDevice) {
		  commandQueue = device.makeCommandQueue()
	 }
	 
	 func createPipelineState(device: MTLDevice) {
		  // The device will make a library for us
		  let library = device.makeDefaultLibrary()
		  // Our vertex function name
		  let vertexFunction = library?.makeFunction(name: "basic_vertex_function")
		  // Our fragment function name
		  let fragmentFunction = library?.makeFunction(name: "basic_fragment_function")
		  // Create basic descriptor
		  let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
		  // Attach the pixel format that si the same as the MetalView
		  renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
		  // Attach the shader functions
		  renderPipelineDescriptor.vertexFunction = vertexFunction
		  renderPipelineDescriptor.fragmentFunction = fragmentFunction
		  // Try to update the state of the renderPipeline
		  do {
				renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
		  } catch {
				print(error.localizedDescription)
		  }
	 }
	 
	 func createBuffers(device: MTLDevice) {
		  vertexBuffer = device.makeBuffer(bytes: vertices,
													  length: MemoryLayout<Vertex>.stride * vertices.count,
													  options: [])
	 }
}

extension Renderer: MTKViewDelegate {
	 func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
	 
	 func draw(in view: MTKView) {
		  // Get the current drawable and descriptor
		  guard let drawable = view.currentDrawable,
				let renderPassDescriptor = view.currentRenderPassDescriptor else {
					 return
		  }
		  // Create a buffer from the commandQueue
		  let commandBuffer = commandQueue.makeCommandBuffer()
		  let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
		  commandEncoder?.setRenderPipelineState(renderPipelineState)
		  // Pass in the vertexBuffer into index 0
		  commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		  // Draw primitive at vertextStart 0
		  commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
		  
		  commandEncoder?.endEncoding()
		  commandBuffer?.present(drawable)
		  commandBuffer?.commit()
	 }
}
*/
