//
//  GridAtom.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//


import Atoms
import Foundation

struct GridAtom: StateAtom, Hashable {
	func defaultValue(context: Context) -> GridParams {
		return GridParams()
	}
}

struct GridParams: Hashable {
	var columns: Int = 100
}
