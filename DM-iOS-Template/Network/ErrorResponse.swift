struct ErrorResponse: Codable {
  struct Error: Codable {
    var message : String
  }

  var error: Error
}
