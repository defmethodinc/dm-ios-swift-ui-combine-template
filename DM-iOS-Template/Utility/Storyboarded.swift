// Inspired by: https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started
// Storyboard's filename need to be the name pre-fixing the "ViewController" part
// e.g.
// - MainViewController.swift
// - Main.storyboard

import UIKit

protocol Storyboarded: NSObjectProtocol {
  associatedtype MyType
  static var defaultFileName: String { get }
  static func instantiateViewController(_ bundle: Bundle?) -> MyType
}

extension Storyboarded where Self: UIViewController {
  static var defaultFileName: String {
    let filename = NSStringFromClass(Self.self).components(separatedBy: ".").last!
    return filename.replacingOccurrences(of: "ViewController", with: "")
  }
  
  static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
    let fileName = defaultFileName
    let sb = UIStoryboard(name: fileName, bundle: bundle)
    return sb.instantiateInitialViewController() as! Self
  }
}
