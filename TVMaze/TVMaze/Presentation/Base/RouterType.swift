//
//  RouterType.swift
//  TVMaze
//
//  Created by Manel Roca on 17/1/22.
//

import Foundation
import UIKit

protocol RouterType: AnyObject {
    associatedtype RouterEnum: RawRepresentable where RouterEnum.RawValue == String
    var context: UIViewController? { get set } //weak
    
    func route(
      to route: RouterEnum,
      parameters: Any?...
    )
    
    func dismiss(_ completion: (() -> Void)?)
}

extension RouterType {
    internal func route(next: UIViewController, animated: Bool = true) {
        if let navigation = self.context?.navigationController {
            route(navigation: navigation, next: next, animated: animated)
        } else {
            print("Error: No navigation controller provided")
        }
    }
    
    internal func route(navigation: UINavigationController, next: UIViewController, animated: Bool = true) {
        navigation.pushViewController(next, animated: animated)
    }
    
    internal func show(_ context: UIViewController?, _ vc: UIViewController, animated: Bool = true) {
        context?.present(vc, animated: animated, completion: nil)
    }
    
    internal func show(_ vc: UIViewController, animated: Bool = true) {
        self.show(self.context, vc, animated: animated)
    }
    
    internal func showFullScreen(_ context: UIViewController?, _ vc: UIViewController, animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        context?.present(vc, animated: animated, completion: nil)
    }
    
    internal func showFullScreen(_ vc: UIViewController, animated: Bool = true) {
        self.showFullScreen(self.context, vc, animated: animated)
    }
    
    func dismiss(_ completion: (() -> Void)? = nil) {
        context?.dismiss(animated: true, completion: completion)
    }
}
