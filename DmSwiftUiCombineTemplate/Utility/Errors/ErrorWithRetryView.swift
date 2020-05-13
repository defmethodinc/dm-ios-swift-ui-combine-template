//
//  ErrorWithRetryView.swift
//  DmSwiftUiCombineTemplate
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct ErrorWithRetryView: View {
  var text: String
  var action: () -> Void
  @State var showDetails = false

  init(text: String = "Something went wrong.", action: @escaping () -> Void) {
    self.text = text
    self.action = action
  }

  var body: some View {
    VStack {
      Text(text)
      Button("Retry", action: { self.action()})
    }
  }
}

struct ErrorWithRetryView_Previews: PreviewProvider {
  static var previews: some View {
    func ohNo() {
      print("Oh no!")
    }
    return ErrorWithRetryView(text: "Oh No!", action: ohNo)
  }
}
