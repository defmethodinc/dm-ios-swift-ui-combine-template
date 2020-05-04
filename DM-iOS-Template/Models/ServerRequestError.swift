enum ServerRequestError: Error {
  case serverError(message: String)
  case serverErrorOther
  case clientError
  case parsing(message: String?)
}
