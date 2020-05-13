//
//  NetworkPublisher+Creations.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation
import Combine

protocol NetworkPublisherCreationsType {
  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError>
}

extension NetworkPublisher: NetworkPublisherCreationsType {
  func publishCreations() -> AnyPublisher<CreationResponse, ServerRequestError> {
    let url =  Config.apiUrl.appendingPathComponent("api/v1/creations")
    return fetchAndPublish(from: url)
  }
}

