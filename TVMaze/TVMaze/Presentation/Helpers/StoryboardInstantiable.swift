//
//  StoryboardInstantiable.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    // EX: LoginSceneViewController -> LoginScene
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!.replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
    
    static func instantiateNavigationViewController(_ bundle: Bundle? = nil) -> UINavigationController {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Cannot instantiate initial view controller \(UINavigationController.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
