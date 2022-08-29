//
//  AccountView.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/29/22.
//

import Atoms
import SwiftUI

struct AccountView: View {
	@WatchStateObject(TweetArchiveAtom())
	var archive

	var body: some View {
		VStack(alignment: .trailing) {
			if archive.isLoaded {
				Text("👋 \(archive.account.accountDisplayName)")
				
				Text("username: ")
					.foregroundColor(Color(.grey, 500))
					.font(.system(.caption, design: .monospaced))
				+ Text("@\(archive.account.username)")
				
				Text("twitter ID: ")
					.foregroundColor(Color(.grey, 500))
					.font(.system(.caption, design: .monospaced))
				+ Text("\(archive.account.accountId)")
				
				Text("user since: ")
					.foregroundColor(Color(.grey, 500))
					.font(.system(.caption, design: .monospaced))
				+ Text("\(DateFormatter.full.string(from: archive.account.createdAt))")
			}
			else {
				if let error = archive.anyError {
					Text("Error: \(error.localizedDescription)")
				}
				else {
					Text("Archive Not Loaded")
				}
			}
		}
		.padding(16)
		.background(
			RoundedRectangle(cornerRadius: 8, style: .continuous)
				.fill(
					Color(.grey, archive.isLoaded ? 800 : 900)
				)
		)
	}
}

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		AccountView()
			.embedAtomRoot()
			.preferredColorScheme(.dark)
	}
}
