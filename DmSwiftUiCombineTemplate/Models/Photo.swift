//
//  Photo.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Photo: Codable, Identifiable, Equatable {
  var id: String
  var url: String

  static func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id && lhs.url == rhs.url
  }
}
