import Foundation

protocol NetworkClientType {
  func verify(with phoneNumber: String, onCompletion: @escaping (Result<User, SignInError>) -> Void)
}

class NetworkClient: NetworkClientType {
  
  func verify(with phoneNumber: String, onCompletion: @escaping (Result<User, SignInError>) -> Void) {
    let url = Environment.apiUrl.appendingPathComponent("users/verify")
    let parameters = ["phone_number": phoneNumber]
    
    NetworkClient.request(url: url, parameters: parameters) { data, response, error in
      if data == nil || response == nil || error != nil {
        onCompletion(.failure(.clientError))
        return
      }
      
      var statusCode = 500
      if let response = response as? HTTPURLResponse {
        statusCode = response.statusCode
      }
      
      do {
        switch statusCode {
        case 404:
          let response = try JSONDecoderWrapper().decode(ErrorResponse.self, from: data!)
          onCompletion(.failure(.serverError(message: response.error.message)))
        case 200:
            let user = try JSONDecoderWrapper().decode(User.self, from: data!)
            onCompletion(.success(user))
        default:
          onCompletion(.failure(.serverErrorOther))
        }
      } catch {
        onCompletion(.failure(.clientError))
      }
    }
  }
}
  
// MARK: Request Methods

extension NetworkClient {
  class func request(url: URL, parameters: Any, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
      return
    }
    request.httpBody = httpBody
    session.dataTask(with: request, completionHandler: completionHandler).resume()
  }
}
