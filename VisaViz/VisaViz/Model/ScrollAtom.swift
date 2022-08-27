//
//  ScrollAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/27/22.
//

import Atoms
import Foundation

struct ScrollAtom: StateAtom, Hashable {
	func defaultValue(context: Context) -> CGFloat {
		return 0.0
	}
}

