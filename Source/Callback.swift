//
//  Reachability.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

#if !os(watchOS)

import Foundation
import SystemConfiguration

func callback(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {

    guard let info = info else { return }

    let reach = Unmanaged<Reach>.fromOpaque(info).takeUnretainedValue()

    DispatchQueue.main.async {
        reach.reachability(change: flags)
    }
    
}

#endif
