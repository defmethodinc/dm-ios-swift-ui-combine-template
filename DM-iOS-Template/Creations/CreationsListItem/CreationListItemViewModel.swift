//
//  CreationListItemViewModel.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/5/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//
import Foundation

class CreationListItemViewModel {
  var creation: Creation

  init(creation: Creation) {
    self.creation = creation
  }

  var name: String {
    creation.name
  }

  var description: String {
    creation.description ?? ""
  }

  var headerPhoto: Photo {
    creation.photos[0]
  }

  var headerPhotoUrl: URL? {
    URL(string: creation.photos[0].url)
  }
}
