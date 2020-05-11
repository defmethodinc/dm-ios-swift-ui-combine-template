protocol ViewModeled: class {
  associatedtype ViewModel
  func setup(with viewModel: ViewModel)
}
