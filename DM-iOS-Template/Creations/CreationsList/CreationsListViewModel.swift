//
//  CreationsListViewModel.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine


class CreationsListViewModel: ObservableObject {
  private var cancellable: AnyCancellable?
  private var networkPublisher: NetworkPublisherCreationsType
  @Published var creations: [Creation] = []
  @Published var error: ServerRequestError?

  init(networkPublisher: NetworkPublisherCreationsType = NetworkPublisher()) {
    self.networkPublisher = networkPublisher
  }
  
  deinit {
    cancellable?.cancel()
  }
}

// MARK: - data source methods
extension CreationsListViewModel {
  func loadCreations() {
    cancellable = networkPublisher.publishCreations()
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          switch completion {
          case .failure(let error):
            print("Failure loading Creations: \(error)")
            self.error = error
          case .finished:
            print("Finished receiving Creations.")
          }

        },
        receiveValue: { [weak self] creations in
          guard let self = self else { return }
          self.creations = creations
      })
  }
}
