//
//  CreationResponseStub.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

extension CreationResponse: Stubbed {
  static func stub() -> CreationResponse {
    let creation1 = Creation.stub(name: "Creation-1")
    let creation2 = Creation.stub(name: "Creation-2")
    return CreationResponse(data: [creation1, creation2])
  }
}
