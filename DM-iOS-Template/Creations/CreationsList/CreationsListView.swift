//
//  CreationListView.swift
//  DM-iOS-Template
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

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
        Text(creation.name)
      }
      .onAppear(perform: viewModel.loadCreations)
      .navigationBarTitle("My Creations")
    }
  }
}

struct CreationsListView_Previews: PreviewProvider {
    static var previews: some View {
        CreationsListView()
    }
}
