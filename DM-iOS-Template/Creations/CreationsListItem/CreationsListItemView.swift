//
//  CreationsListItemView.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct CreationsListItemView: View {
  var viewModel: CreationListItemViewModel
  @Environment(\.imageCache) var cache: ImageCache
  
  var body: some View {
    VStack(alignment: .leading) {
      AsyncImageView(
        url: viewModel.headerPhotoUrl,
        placeholder: Text("Loading..."),
        cache: self.cache,
        configuration: {
          $0.resizable()
      }
      ).aspectRatio(contentMode: .fit)
      Text(viewModel.name)
        .font(.title)
      Text(viewModel.description)
    }.frame(minHeight: 300)
  }
}

struct CreationsListItemView_Previews: PreviewProvider {
  static var previews: some View {
    let photos = [
      Photo(id: "123", url: "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2017%2F05%2Fmain%2Fegg-in-nest-blt-sandwiches-1707p38.jpg%3Fitok%3D-2zHWRHS"),
      Photo(id: "234", url: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fimage%2F2015%2F04%2Fmain%2F1505p66-avocado-egg-salad-sandwiches-pickled-celery_0_0_0.jpg%3Fitok%3DLPLMYXRx")
    ]
    let creation = Creation(
      id: "123",
      name: "A creation",
      description: "The coolest creation ever created!",
      photos: photos
    )
    let viewModel = CreationListItemViewModel(creation: creation)
    return CreationsListItemView(viewModel: viewModel)
  }
}
