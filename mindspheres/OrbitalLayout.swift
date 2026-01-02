import SwiftUI

struct OrbitalPosition {
    static func position(
        for index: Int,
        totalCount: Int,
        radius: CGFloat,
        in size: CGSize
    ) -> CGPoint {
        let angle = (2 * .pi / Double(totalCount)) * Double(index) - .pi / 2
        let x = size.width / 2 + radius * cos(angle)
        let y = size.height / 2 + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}
