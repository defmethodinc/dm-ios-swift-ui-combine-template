//
//  CreationListViewModelTests.swift
//  DmSwiftUiCombineTemplateTests
//
//  Created by Joshua Book on 5/11/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//
import XCTest
@testable import DmSwiftUiCombineTemplate

class CreationListViewModelTests: XCTestCase {
  var mockNetworkPublisher: MockNetworkPublisher?
  let creationResponse = CreationResponse.stub()
  var creationsFromNetwork = [Creation]()

  override func setUpWithError() throws {
    mockNetworkPublisher = MockNetworkPublisher(creationResponse: creationResponse)
    mockNetworkPublisher!.resetCallCounts()
    creationsFromNetwork = creationResponse.data
  }

  func testLoadCreations() throws {
    // setup - instantiate viewModel with mockNetworkPublisher
    // publishing creationResponse
    let viewModel = CreationsListViewModel(networkPublisher: mockNetworkPublisher!)
    let expectation = XCTestExpectation(description: "viewModel gets 2 creations")
    var observedCreations = [Creation]()

    // subscribe to viewModel's published creations
    // set expectation to fulfill if received data equivalent
    // to data published by viewModel's networkPublisher
    let cancellable = viewModel.$creations
      .sink { creations in
        observedCreations.append(contentsOf: creations)
        if observedCreations == self.creationsFromNetwork {
          expectation.fulfill()
        }
    }
    XCTAssertEqual(observedCreations.count, 0)

    // load up creations from viewModel
    viewModel.loadCreations()

    // ensure creations are published by viewModel
    // and that viewModel makes a call to NetworkPublisher#publishCreations
    XCTAssertEqual(mockNetworkPublisher!.publishCreationsCount, 1)
    wait(for: [expectation], timeout: 2.0)
    XCTAssertNotNil(cancellable)
    XCTAssertEqual(observedCreations.count, 2)
  }
}
