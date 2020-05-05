//
//  ImageCache.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/5/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

protocol ImageCache {
  subscript(_ key: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
  private let cache = NSCache<NSURL, UIImage>()

  subscript(_ key: URL) -> UIImage? {
    get { cache.object(forKey: key as NSURL)}
    set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)}
  }
}

// MARK: - Environment - ImageCache
struct ImageCacheKey: EnvironmentKey {
  static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
  var imageCache: ImageCache {
    get { self[ImageCacheKey.self] }
    set { self[ImageCacheKey.self] = newValue }
  }
}
