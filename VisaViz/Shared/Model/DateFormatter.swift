//
//  DateFormatter.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import Foundation

extension DateFormatter {
	static let bestDateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "y MMM dd"

		return df
	}()
	
	static let goodDateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "dd MMM y"

		return df
	}()
	
	static let worstDateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "MMM/dd/y"

		return df
	}()
	
	static let bestTimeFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "HH:mm"

		return df
	}()
	
	static let worstTimeFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "hh:mm"

		return df
	}()
}
