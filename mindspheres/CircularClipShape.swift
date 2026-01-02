import SwiftUI

struct CircularClipShape: Shape {
    var progress: Double
    var origin: CGPoint

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let diagonal = sqrt(rect.width * rect.width + rect.height * rect.height)
        let maxRadius = diagonal * 1.5
        let currentRadius = maxRadius * progress

        return Path { path in
            path.addEllipse(in: CGRect(
                x: origin.x - currentRadius,
                y: origin.y - currentRadius,
                width: currentRadius * 2,
                height: currentRadius * 2
            ))
        }
    }
}
