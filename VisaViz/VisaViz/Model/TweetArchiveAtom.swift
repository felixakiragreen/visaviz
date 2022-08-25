//
//  TweetArchiveAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/25/22.
//

import Atoms
import Foundation

struct TweetArchiveAtom: ObservableObjectAtom, KeepAlive, Hashable {	
	func object(context: Context) -> TweetArchiveStore {
		TweetArchiveStore()
	}
}

