//
//  Network.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

import Foundation

/// Network reachability
public enum Network {
    /// Network is not available
    case notReachable
    /// Network is available
    case reachable(Via)
}

public extension Network {

    /// Network available
    enum Via {
        /// Network is available from Wifi
        case wifi
        /// Network is available from Cellular
        case wwan
    }
}

extension Network: Equatable {

    /// Equatable conformance protocol
    public static func == (lhs: Network, rhs: Network) -> Bool {
        switch (lhs, rhs) {
        case (.notReachable, .notReachable):
            return true
        case (.reachable(.wifi), .reachable(.wifi)):
            return true
        case (.reachable(.wwan), .reachable(.wwan)):
            return true
        default:
            return false
        }
    }
}
