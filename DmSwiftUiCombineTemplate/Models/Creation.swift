//
//  Creation.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Creation: Identifiable, Codable, Equatable {
  var id: String
  var name: String
  var description: String?
  var photos: [Photo] = []

  static func ==(lhs: Creation, rhs: Creation) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description && lhs.photos == rhs.photos
  }
}
