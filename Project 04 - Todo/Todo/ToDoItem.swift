//
//  ToDoItem.swift
//  Todo
//
//  Created by Yi Gu on 2/29/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
  var id: String
  var image: String
  var title: String
  var date: Date
  
  init(id: String, image: String, title: String, date: Date) {
    self.id = id
    self.image = image
    self.title = title
    self.date = date
  }
}
