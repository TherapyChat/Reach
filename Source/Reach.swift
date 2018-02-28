//
//  Reach.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

import Foundation

#if !os(watchOS)
    import SystemConfiguration
#endif

/// Delegate responsible to notify of changes in `Network` connection
public protocol ReachDelegate: class {

    /// Called when network is available
    func networkIsReachable()

    /// Called when network is not available
    func networkIsNotReachable()

    /// Always notify from network changes and spicify `Network` type
    func networkDidChange(status: Network)
}

public extension ReachDelegate {
    func networkIsReachable() { }
    func networkIsNotReachable() { }
    func networkDidChange(status: Network) { }
}

/// Responsible to observe network changes
public final class Reach {

    #if !os(watchOS)

    private let reachability: SCNetworkReachability?
    private let queue = DispatchQueue(label: "com.reach.queue", qos: .background)

    #endif

    /// Delegate object to notify events
    public weak var delegate: ReachDelegate?

    /// Current status of `Network`
    public var status: Network = .notReachable {
        didSet {
            if status == oldValue { return }
            delegate?.networkDidChange(status: status)
            switch status {
            case .notReachable:
                delegate?.networkIsNotReachable()
            case .reachable:
                delegate?.networkIsReachable()
            }
        }
    }

    // MARK: - Lifecycle

    /// Creates an instance with specific `hostname`
    ///
    /// - parameter hostname:  URL for hostname
    ///
    public init(with hostname: String) {
        #if !os(watchOS)
            reachability = SCNetworkReachabilityCreateWithName(nil, hostname)
        #endif
    }

    /// Creates an instance without specific `hostname`
    public init() {
        #if !os(watchOS)
            var zeroAddress = sockaddr()
            zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
            zeroAddress.sa_family = sa_family_t(AF_INET)

            reachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress)
        #endif
    }

    deinit {
        stop()
    }

    // MARK: - Runtime

    /// Function to start observe `Network` changes
    public func start() {
        #if !os(watchOS)
            var context = SCNetworkReachabilityContext(version: 0,
                                                       info: nil,
                                                       retain: nil,
                                                       release: nil,
                                                       copyDescription: nil)

            context.info = UnsafeMutableRawPointer(Unmanaged<Reach>.passUnretained(self).toOpaque())

            guard let network = reachability else { return }

            SCNetworkReachabilitySetCallback(network, callback, &context)
            SCNetworkReachabilitySetDispatchQueue(network, queue)
        #endif
    }

    /// Function to remove observer on `Network` changes
    public func stop() {
        #if !os(watchOS)

            guard let network = reachability else { return }

            SCNetworkReachabilitySetCallback(network, nil, nil)
            SCNetworkReachabilitySetDispatchQueue(network, nil)

        #endif
    }

    #if !os(watchOS)

    /// Change `Network` status
    func reachability(change flags: SCNetworkReachabilityFlags) {
        var network: Network = .notReachable

        if flags.contains(.reachable) {
            network = .reachable(.wifi)
        }

        #if os(iOS)
            if flags.contains(.isWWAN) {
                network = .reachable(.wwan)
            }
        #endif
        
        status = network
    }

    #endif
}
