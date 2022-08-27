//
//  CG+Hashable.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/27/22.
//

import Foundation

extension CGPoint: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(x)
		hasher.combine(y)
	}
}

extension CGSize: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(width)
		hasher.combine(height)
	}
}
