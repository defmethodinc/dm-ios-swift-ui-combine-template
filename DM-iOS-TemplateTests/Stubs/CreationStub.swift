//
//  CreationStub.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

extension Creation: Stubbed {
  static func stub() -> Creation {
    let photos = [
      Photo.stub(),
      Photo.stub()
    ]
    return Creation(
      id: "123",
      name: "Creation-1",
      description: "The coolest creation ever created!",
      photos: photos
    )
  }

  static func stub(name: String = "Creation-1", description: String = "The coolest creation ever created!") -> Creation {
    let photos = [
      Photo.stub(),
      Photo.stub()
    ]
    return Creation(
      id: "123",
      name: name,
      description: description,
      photos: photos
    )
  }
}
