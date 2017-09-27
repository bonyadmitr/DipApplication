//
//  AppDelegateProxy.swift
//  LaunchKit
//
//  Created by George Kiriy on 19/12/2016.
//
//

import UIKit

public protocol AppDelegateHandler: UIApplicationDelegate {
}

public class AppDelegateProxy: NSObject, UIApplicationDelegate {
    
    public var handlers: [AppDelegateHandler] = []
    
    public override func responds(to aSelector: Selector!) -> Bool {
        let should = shouldForward(selector: aSelector)
        let handlerResponds = handlers.contains { $0.responds(to: aSelector) }
        let nsObjectResponds = NSObject.instancesRespond(to: aSelector)
        
        return (should && handlerResponds) || nsObjectResponds
    }
    
    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return handlers.first { $0.responds(to: aSelector) }
    }
    
    private func shouldForward(selector aSelector: Selector) -> Bool {
        let fromAppDelegate = isSelector(aSelector, fromProtocol: UIApplicationDelegate.self)
        let fromNsObject = isSelector(aSelector, fromProtocol: NSObjectProtocol.self)
        return fromAppDelegate && !fromNsObject
    }
    
    private func isSelector(_ aSelector: Selector, fromProtocol aProtocol: Protocol) -> Bool {
        let methodDescriptors: [(required: Bool, instance: Bool)] = [
            (false, false), (false, true), (true, false), (true, true)
        ]
        
        return methodDescriptors.contains { (required, instance) -> Bool in
            let description = protocol_getMethodDescription(aProtocol, aSelector, required, instance)
            return description.types != nil && description.name != nil
        }
    }
}
