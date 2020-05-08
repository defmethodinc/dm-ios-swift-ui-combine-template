//
//  CreationListView.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIPullToRefresh

struct CreationsListView: View {
  @ObservedObject var viewModel: CreationsListViewModel

  init(viewModel: CreationsListViewModel = CreationsListViewModel()) {
    self.viewModel = viewModel
  }

  var body: some View {
    Group {
      if self.viewModel.error != nil {
        ErrorWithRetryView(text: "Error: \(viewModel.error!.localizedDescription)", action: viewModel.loadCreations)
      } else {
        RefreshableNavigationView(title: "Creations", action: viewModel.loadCreations) {
          ForEach(self.viewModel.creations, id: \.id) { creation in
            VStack(alignment: .leading) {
              CreationsListItemView(viewModel: CreationListItemViewModel(creation: creation))
              Divider()
            }
          }
        }
      }
    }.onAppear(perform: self.viewModel.loadCreations)
  }
}

struct CreationsListView_Previews: PreviewProvider {

  static var previews: some View {
    let creationResponse = CreationResponse.stub()
    let viewModel = CreationsListViewModel(networkPublisher: MockNetworkPublisher(creationResponse: creationResponse))
    return CreationsListView(viewModel: viewModel)
  }
}
