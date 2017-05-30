//
//  ReachDelegateMock.swift
//  Reach
//
//  Created by sergio on 22/05/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

import Foundation
import Reach

final class ReachDelegateMock {

    var isReachable: Bool?

}

extension ReachDelegateMock: ReachDelegate {

    func networkDidChange(status: Network) {
        switch status {
        case .reachable:
            isReachable = true
        case .notReachable:
            isReachable = false
        }
    }
}
