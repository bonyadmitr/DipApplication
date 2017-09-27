//
//  Application.swift
//  LaunchKit
//
//  Created by George Kiriy on 19/12/2016.
//
//

import Dip

// swiftlint:disable delegate
open class Application: UIApplication {
    let factory: AssembliesFactory
    
    open class var factory: AssembliesFactory {
        fatalError("Override this property")
    }
    
    override public init() {
        factory = type(of: self).factory
        super.init()
    }
    
    override open var delegate: UIApplicationDelegate? {
        willSet {
            if let delegate = newValue {
                factory.launchAssembly.injectProperties(to: delegate, ofType: type(of: delegate))
            }
        }
    }
}
// swiftlint:enable delegate
