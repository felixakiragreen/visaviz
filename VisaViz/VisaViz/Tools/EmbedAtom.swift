//
//  EmbedAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Atoms
import SwiftUI

extension View {
	func embedAtomRoot() -> some View {
		AtomRoot {
			self
		}
	}
}
