enum SignInError: Error {
  case serverError(message: String)
  case serverErrorOther
  case clientError
}
