import Foundation

class JSONDecoderWrapper: JSONDecoder {
  override init() {
    super.init()
    self.keyDecodingStrategy = .convertFromSnakeCase
  }
}
