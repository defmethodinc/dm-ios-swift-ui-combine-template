//
//  NetworkPublisher.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation
import Combine

class NetworkPublisher {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  internal func fetchAndPublish<T: Decodable>(from url: URL) -> AnyPublisher<T, ServerRequestError> {
    session.dataTaskPublisher(for: URLRequest(url: url))
      .retry(1)
      .mapError { error in
        .serverError(message: error.localizedDescription)
    }
    .flatMap { pair in
      self.decode(pair.data)
    }
    .eraseToAnyPublisher()
  }

  // TODO: perhaps move this somewhere else (maybe JSONDecoderWrapper)
  private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ServerRequestError> {
    let decoder = JSONDecoderWrapper()

    return Just(data)
      .decode(type: T.self, decoder: decoder)
      .mapError { error in
        print("Decoding error: \(error)")
        return .parsing(message: error.localizedDescription)
    }
    .eraseToAnyPublisher()
  }

}

