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
		VStack {
			Text("Welcome to VisaViz v\(appVersionString)")
				.font(.title)
			
			Text("How To Use")
				.font(.title2)
			
			VStack {
				
				Text("You need to download your Twitter Archive FIRST")
				Text("It will take ages.")
			}
			
			
			Text("Once you have, ")
			Text("BIG OPEN ARCHIVE BUTTON")
			
			Text("Feedback")
				.font(.title2)
			
			Text("There is a lot ")
			
		}
	}
}

struct EmptyView_Previews: PreviewProvider {
	static var previews: some View {
		EmptyView()
	}
}
