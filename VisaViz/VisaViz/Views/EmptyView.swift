//
//  EmptyView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import SwiftUI

struct EmptyView: View {
	let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
	
	var body: some View {
		VStack(spacing: 48) {
			Text("Welcome to VisaViz")
				.font(.title)
				.foregroundColor(Color(.blue, 400))
			+ Text(" v\(appVersionString)")
				.font(.system(.title, design: .monospaced))
				.foregroundColor(Color(.orange, 400))
			
			VStack(spacing: 16) {
				Text("How To Use")
					.font(.title2)
					.bold()
					.foregroundColor(Color(.grey, 400))
				
				VStack(spacing: 4) {
					Text("⚠️ You need to download your Twitter Archive ")
					+ Text("FIRST")
						.bold()
						.foregroundColor(Color(.red, 400))
					Text("(⏳ it will take aaaaages 💀)")
						.italic()
						.font(.caption2)
						.foregroundColor(Color(.grey, 500))
				}
				
				VStack(spacing: 4) {
					Text("Then unzip it, click \(Image(systemName: "arrow.down")) this, and select the entire folder")
					LoadArchiveButton()
				}
			}
			
			VStack(spacing: 16) {
				Text("Feedback")
					.font(.title2)
					.bold()
					.foregroundColor(Color(.grey, 400))
				
				VStack(spacing: 4) {
					Text("🏗️ This is a prototype, so you can only do a few things:")
					VStack(alignment: .leading, spacing: 4) {
						Text("1. Colorize tweets based on most replies to")
						Text("2. Change grid size with Columns slider")
						Text("3. Mouse over tweets to read them")
						Text("4. Click to copy URL to clipboard")
					}
				}
				
				Text("🙏 Please share feedback, ideas, bug reports with me on Twitter or Github. Thanks!")
			}
			
			Text("💚 Special thanks to Visakan Veerasamy, for whom this was made and inspired it.")
				.italic()
				.foregroundColor(Color(.green, 400))
		}
		.padding()
	}
}

struct EmptyView_Previews: PreviewProvider {
	static var previews: some View {
		EmptyView()
	}
}
