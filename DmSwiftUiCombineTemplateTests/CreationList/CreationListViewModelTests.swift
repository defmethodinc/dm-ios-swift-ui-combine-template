//
//  CreationListViewModelTests.swift
//  DmSwiftUiCombineTemplateTests
//
//  Created by Joshua Book on 5/11/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//
import SwiftUI
import Combine
import XCTest
@testable import DmSwiftUiCombineTemplate

class CreationListViewModelObserver: Spy {
  @ObservedObject var viewModel: CreationsListViewModel
  var creations: [Creation]?
  var cancellable: AnyCancellable?
  var receivedPublishedCount = 0

  init(viewModel: CreationsListViewModel) {
    self.viewModel = viewModel
    cancellable = viewModel.$creations
      .print()
      .sink(receiveValue: { [weak self] creations in
        guard let self = self else { return }
        self.receivedPublishedCount += 1
        self.creations = creations
      })
  }

  func resetCallCounts() {
    receivedPublishedCount = 0
  }
}

class CreationListViewModelTests: XCTestCase {
  var mockNetworkPublisher: MockNetworkPublisher?
  let creationResponse = CreationResponse.stub()
  var creationListViewModelObserver: CreationListViewModelObserver?

  override func setUpWithError() throws {
    mockNetworkPublisher = MockNetworkPublisher(creationResponse: creationResponse)
    mockNetworkPublisher!.resetCallCounts()
  }

  override func tearDownWithError() throws {
    if let creationListViewModelObserver = creationListViewModelObserver {
      creationListViewModelObserver.resetCallCounts()
    }
  }

  func testLoadCreations() throws {
    let viewModel = CreationsListViewModel(networkPublisher: mockNetworkPublisher!)
    let observer = CreationListViewModelObserver(viewModel: viewModel)
    observer.viewModel.loadCreations()
    XCTAssertEqual(mockNetworkPublisher!.publishCreationsCount, 1)
    XCTAssertEqual(observer.receivedPublishedCount, 1)
    XCTAssertEqual(observer.creations!, creationResponse.data)
  }
}
