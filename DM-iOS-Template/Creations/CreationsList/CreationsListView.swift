//
//  CreationListView.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

struct CreationsListView: View {
  @ObservedObject var viewModel: CreationsListViewModel

  init(viewModel: CreationsListViewModel = CreationsListViewModel()) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      viewModel.error.map { error in
        Text("Error occured: \(error.localizedDescription)")
      }
      List(viewModel.creations, id: \.id) { creation in
        CreationsListItemView(viewModel: CreationListItemViewModel(creation: creation))
      }
      .onAppear(perform: viewModel.loadCreations)
      .navigationBarTitle("Creations")
    }
  }
}

struct CreationsListView_Previews: PreviewProvider {

  static var previews: some View {
    let creationResponse = CreationResponse.stub()
    let viewModel = CreationsListViewModel(networkPublisher: MockNetworkPublisher(creationResponse: creationResponse))
    return CreationsListView(viewModel: viewModel)
  }
}
