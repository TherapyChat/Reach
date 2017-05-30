//
//  ReachSpec.swift
//  Reach
//
//  Created by sergio on 09/01/2017.
//  Copyright © 2017 nc43tech. All rights reserved.
//

import Foundation

import XCTest
import Nimble

@testable import Reach

final class ReachTests: XCTestCase {

    func testReachableHost() {

        let hostname = "google.com"

        let reach = Reach(with: hostname)
        reach.start()

        waitUntil(timeout: 5) { done in
            delay(1) {
                done()
            }
        }

        expect(reach.status).toEventually(equal(.reachable(.wifi)))
    }

    func testUnreachableHost() {

        let hostname = "invalid"

        let reach = Reach(with: hostname)
        reach.start()

        waitUntil(timeout: 5) { done in
            delay(1) {
                done()
            }
        }

        expect(reach.status).toEventually(equal(Network.notReachable))
    }

    func testDelegateIsCalled() {

        let hostname = "google.com"

        let reach = Reach(with: hostname)
        let mock = ReachDelegateMock()

        reach.delegate = mock
        reach.start()

        waitUntil(timeout: 5) { done in
            delay(1) {
                done()
            }
        }

        expect(mock.isReachable).toEventually(beTrue())
    }

    func testReachableWithoutHostname() {

        let reach = Reach()
        reach.start()

        waitUntil(timeout: 5) { done in
            delay(1) {
                done()
            }
        }

        expect(reach.status).toEventually(equal(Network.notReachable))
    }


}

