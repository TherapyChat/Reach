import Foundation
import Reach
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//: # Reach
let reach = Reach(with: "github.com")

//: Start notifiy events
reach.start()

//: Check network status after 1 second

delay(1) {

    print(reach.status)
}
