//
//  DateFormatter.swift
//  VisaViz
//
//  Created by Felix Akira Green on 1/15/21.
//

import Foundation

extension DateFormatter {
	static let mediumDateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .medium
		df.timeStyle = .none

		return df
	}()

	static let mediumTimeFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .none
		df.timeStyle = .medium

		return df
	}()

//	static let dayHourFormatter: DateFormatter = {
//		let df = DateFormatter()
//		df.dateFormat = "'d'DD_'h'HH"
//
//		return df
//	}()
//
//	static let hourFormatter: DateFormatter = {
//		let df = DateFormatter()
//		df.dateFormat = "HH"
//
//		return df
//	}()
//
//	static let timeFormatter: DateFormatter = {
//		let df = DateFormatter()
//		df.dateFormat = "HH:mm"
//
//		return df
//	}()

	static let mediumDateTimeFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .medium
		df.timeStyle = .medium

		return df
	}()
}
