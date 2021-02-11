//
//  Renderer2.swift
//  MetalExperiments
//
//  Created by Felix Akira Green on 1/19/21.
//

import Metal
import MetalKit

import Forge
import Satin

class RendererText: Forge.Renderer {
	let lala: String
	init(lala: String) {
		print("lala", lala)
		self.lala = lala
	}

	var updateText: Bool = true
	
	lazy var mesh: Mesh = {
		let mesh = Mesh(geometry: ExtrudedTextGeometry(text: self.lala, fontName: "Helvetica", fontSize: 1, distance: 0.5, pivot: [0, 0]),
		                material: BasicDiffuseMaterial(0.7))
		//        mesh.position = [0, 0, 0]
		//        mesh.orientation = simd_quatf(from: [0, 0, 1], to: simd_normalize([1, 1, 1]))
		return mesh
	}()
	
	lazy var scene: Object = {
		let scene = Object()
		scene.add(mesh)
		return scene
	}()
	
	lazy var context: Context = {
		Context(device, sampleCount, colorPixelFormat, depthPixelFormat, stencilPixelFormat)
	}()
	
	var camera = PerspectiveCamera(position: [0, 0, 9], near: 0.001, far: 100.0)
	
	lazy var cameraController: PerspectiveCameraController = {
		PerspectiveCameraController(camera: camera, view: mtkView)
	}()
	
	lazy var renderer: Satin.Renderer = {
		Satin.Renderer(context: context, scene: scene, camera: camera)
	}()
	
	override func setupMtkView(_ metalKitView: MTKView) {
		metalKitView.sampleCount = 1
		metalKitView.depthStencilPixelFormat = .depth32Float
		metalKitView.preferredFramesPerSecond = 60
	}
	
	override func update() {
		if updateText {
			
		}
		cameraController.update()
	}
	
	override func draw(_ view: MTKView, _ commandBuffer: MTLCommandBuffer) {
		guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
		renderer.draw(renderPassDescriptor: renderPassDescriptor, commandBuffer: commandBuffer)
	}
	
	override func resize(_ size: (width: Float, height: Float)) {
		camera.aspect = size.width / size.height
		renderer.resize(size)
	}
}
