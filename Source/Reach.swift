//
//  Reach.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

#if !os(watchOS)

import Foundation
import SystemConfiguration

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

    private let reachability: SCNetworkReachability?
    private let queue = DispatchQueue(label: "com.nc43tech.Reachability")

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
        reachability = SCNetworkReachabilityCreateWithName(nil, hostname)
    }

    /// Creates an instance without specific `hostname`
    public init() {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })

    }

    deinit {
        stop()
    }

    // MARK: - Runtime

    /// Function to start observe `Network` changes
    public func start() {
        var context = SCNetworkReachabilityContext(version: 0,
                                                   info: nil,
                                                   retain: nil,
                                                   release: nil,
                                                   copyDescription: nil)

        context.info = UnsafeMutableRawPointer(Unmanaged<Reach>.passUnretained(self).toOpaque())

        guard let network = reachability else { return }

        SCNetworkReachabilitySetCallback(network, callback, &context)
        SCNetworkReachabilitySetDispatchQueue(network, queue)
    }

    /// Function to remove observer on `Network` changes
    public func stop() {

        guard let network = reachability else { return }

        SCNetworkReachabilitySetCallback(network, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(network, nil)
    }

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
}

#endif
