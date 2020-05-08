//
//  MockNetworkPublisher.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Combine

class MockNetworkPublisher: NetworkPublisherCreationsType {
  private let creationResponse: CreationResponse
  init(creationResponse: CreationResponse) {
    self.creationResponse = creationResponse
  }

  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError> {
    Just(creationResponse)
      .mapError { error in ServerRequestError.serverError(message: "oops") }
      .eraseToAnyPublisher()
  }
}
