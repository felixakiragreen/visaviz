//
//  DateFormatter.swift
//  VisaViz
//
//  Created by Felix Akira Green on 8/26/22.
//

import Foundation

/// https://unicode-org.github.io/icu/userguide/format_parse/datetime/#datetime-format-syntax

extension DateFormatter {

	/// bare → 2022.03.09@21:30
	static let bare: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "y.MM.dd@HH:mm"
		return df
	}()
	
	/// Full → 2022 Mar 09 @ 21:30
	static let full: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "y MMM dd @ HH:mm"
		return df
	}()
	
	/// The weird format Twitter tweets use → Mon Aug 22 18:27:44 +0000 2016
	static let tweet: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
		return df
	}()
	
	/// ISO → 2008-10-20T11:06:33.000Z
	static let iso: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
		return df
	}()
}
