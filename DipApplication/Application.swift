//
//  Application.swift
//  LaunchKit
//
//  Created by George Kiriy on 19/12/2016.
//
//

import Dip


#if os(iOS)
    
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
    
#elseif os(macOS)
import Cocoa
    
// swiftlint:disable delegate
open class Application: NSApplication {
    let factory: AssembliesFactory
    
    open class var factory: AssembliesFactory {
        fatalError("Override this property")
    }
    
    override public init() {
        factory = type(of: self).factory
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        factory = type(of: self).factory
        super.init(coder: coder)
    }
    
    override open var delegate: NSApplicationDelegate? {
        willSet {
            if let delegate = newValue {
                factory.launchAssembly.injectProperties(to: delegate, ofType: type(of: delegate))
            }
        }
    }
}
// swiftlint:enable delegate
    
#endif
