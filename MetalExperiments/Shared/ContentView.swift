//
//  ContentView.swift
//  Shared
//
//  Created by Felix Akira Green on 1/19/21.
//

import SwiftUI
import struct Forge.ForgeView
import Satin

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}


struct ContentView: View {
	
	// MARK: - PROPS
	
	@EnvironmentObject var renderer: Renderer
//	@State var textEntry: String = "initial"
	
	// MARK: - BODY
	var body: some View {
		ZStack(alignment: .topLeading) {
			ForgeView(renderer: renderer)
				.frame(minWidth: 512, minHeight: 512)
//				.edgesIgnoringSafeArea(.all)
//			SubContentView(text: $textEntry)
			VStack {
				Text("text")
				Button("log") {
				
					if let camera = renderer.cameraController.camera {
						print(camera.top, camera.right, camera.bottom, camera.left)
						print(renderer.cameraController.camera?.position)
					}
					
					let paramsMap: [String: Parameter]
					paramsMap = renderer.instanceMaterial.parameters.paramsMap
					
					let bla = paramsMap.mapValues { parameter -> Double in
						if parameter is FloatParameter {
							let param = parameter as! FloatParameter
							let value = Double(param.value)
							return value
						}
						else if parameter is IntParameter {
							let param = parameter as! IntParameter
							let value = Double(param.value)
							return value
						}
						else {
							return Double(0)
						}
					}
					print(bla)
					// print(renderer)
				}
			}
			.padding()
			.background(Color.red)
		}
		
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
