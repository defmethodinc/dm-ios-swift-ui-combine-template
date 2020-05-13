//
//  AsyncImageView.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/5/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
  @ObservedObject private var loader: ImageLoader
  private let placeholder: Placeholder
  private let configuration: (Image) -> Image

  init(
    url: URL?,
    placeholder: Placeholder,
    cache: ImageCache? = nil,
    configuration: @escaping (Image) -> Image = { $0 }
  ) {
    loader = ImageLoader(url: url, cache: cache)
    self.placeholder = placeholder
    self.configuration = configuration
  }

  var body: some View {
    image
      .onAppear(perform: loader.load)
      .onDisappear(perform: loader.cancel)
  }

  private var image: some View {
    Group {
      if loader.image != nil {
        configuration(Image(uiImage: loader.image!))
      } else {
        placeholder
      }
    }
  }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
      let url = URL(string: "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2017%2F05%2Fmain%2Fegg-in-nest-blt-sandwiches-1707p38.jpg%3Fitok%3D-2zHWRHS")
      return AsyncImageView(
        url: url,
        placeholder: Text("Keep waiting..."),
        configuration: { $0.resizable() }
      )
  }
}
