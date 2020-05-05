//
//  ImageLoader.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/5/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader:  ObservableObject {
  @Published var image: UIImage?
  private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
  private let url: URL?
  private var cancellable: AnyCancellable?
  private var cache: ImageCache?

  init(url: URL?, cache: ImageCache? = nil) {
    self.url = url
    self.cache = cache
  }

  deinit {
    cancellable?.cancel()
  }

  private(set) var isLoading = false

  func load() {
    guard let url = url, !isLoading else {
      return
    }

    if let image = cache?[url] {
      self.image = image
      return
    }

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: Self.imageProcessingQueue)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .handleEvents(
        receiveSubscription: {
          [weak self] _ in self?.onStart()
        },
        receiveOutput: {
          [weak self] in self?.cacheImage($0, url: url)
        },
        receiveCompletion: {
          [weak self] _ in self?.onFinish()
        },
        receiveCancel: {
          [weak self] in self?.onFinish()
      })
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }

  func cancel() {
    cancellable?.cancel()
  }

  private func cacheImage(_ image: UIImage?, url: URL) {
    image.map { cache?[url] = $0 }
  }

  private func onStart() {
    isLoading = true
  }

  private func onFinish() {
    isLoading = false
  }
}
