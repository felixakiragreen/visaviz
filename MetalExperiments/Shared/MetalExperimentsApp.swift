//
//  MetalExperimentsApp.swift
//  Shared
//
//  Created by Felix Akira Green on 1/19/21.
//

import SwiftUI

@main
struct MetalExperimentsApp: App {
	@StateObject var renderer = Renderer()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.navigationTitle("VisaViz")
				.environmentObject(renderer)
		}
	}
}
