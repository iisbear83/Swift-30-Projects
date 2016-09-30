//
//  Utils.swift
//  Todo
//
//  Created by Yi Gu on 2/29/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

func dateFromString(_ date: String) -> Date? {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.string(from: date)
}

