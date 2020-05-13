//
//  MockNetworkPublisher.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Combine
@testable import DmSwiftUiCombineTemplate

class MockNetworkPublisher: Spy, NetworkPublisherCreationsType {
  var publishCreationsCount = 0
  private let creationResponse: CreationResponse
  init(creationResponse: CreationResponse) {
    self.creationResponse = creationResponse
  }

  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError> {
    publishCreationsCount += 1
    return Just(creationResponse)
      .mapError { error in ServerRequestError.serverError(message: "oops") }
      .eraseToAnyPublisher()
  }

  func resetCallCounts() {
    publishCreationsCount = 0
  }
}
