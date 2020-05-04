//
//  Creation.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

import Foundation

struct CreationResponse: Codable {
  var data: [Creation]
}

struct Creation: Identifiable, Codable {
  var id: String
  var name: String
  var summary: String?
  var photos: [Photo] = []
}
