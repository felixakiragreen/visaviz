//
//  DateFormatter.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Foundation

/// https://unicode-org.github.io/icu/userguide/format_parse/datetime/#datetime-format-syntax

extension DateFormatter {
	// /// short & sweet date time → 31@21:30
	// static let justDateTime: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "dd@HH:mm"
	// 	return df
	// }()
	//
	// /// holocene year month day → 12022 Mar 09
	// static let fullDate: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "'1'y MMM dd"
	//
	// 	return df
	// }()
	//
	// /// dates for string keys → 20220309
	// static let keyDate: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "yMMdd"
	//
	// 	return df
	// }()
	//
	// /// date for title bar title → Mon, 9 Mar
	// static let title: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "eee, d MMM"
	//
	// 	return df
	// }()
	
	/// ISO → 2022.03.09@21:30
	static let isoDateTime: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "y.MM.dd@HH:mm"
		return df
	}()
	
	static let fullDateTime: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "y MMM dd @ HH:mm"
		return df
	}()
	
	// /// 24 hour time → 21:30
	// static let justTime: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "HH:mm"
	// 	
	// 	return df
	// }()
	// 
	// /// first letter of week day  → M, T, W, &c
	// static let justWeekday: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "ccccc"
	// 	
	// 	return df
	// }()
	// 
	// /// 3 letter abbreviation of week day → Mon, Tue, Wed, &c
	// static let justWeekdayAbbr: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "ccc"
	// 	
	// 	return df
	// }()
	// 
	// /// day of month number → 9, 18, 27, &c
	// static let justDay: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "d"
	// 	
	// 	return df
	// }()
	// 
	// /// 3 letter abbreviation of month → Jan, Feb, Mar, &c
	// static let justMonthAbbr: DateFormatter = {
	// 	let df = DateFormatter()
	// 	df.dateFormat = "MMM"
	// 	
	// 	return df
	// }()
}
