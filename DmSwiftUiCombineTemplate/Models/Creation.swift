//
//  Creation.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct Creation: Identifiable, Codable {
  var id: String
  var name: String
  var description: String?
  var photos: [Photo] = []
}
