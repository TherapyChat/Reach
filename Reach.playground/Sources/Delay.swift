import Foundation

public func delay(_ duration: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
        block()
    })
}
