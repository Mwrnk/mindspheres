import SwiftUI

enum SphereType: String, Codable, CaseIterable {
    case gratitude
    case neutral
    case improve

    var color: Color {
        switch self {
        case .gratitude: return Color.sphereGreen
        case .neutral: return Color.sphereBlue
        case .improve: return Color.sphereOrange
        }
    }

    var title: String {
        switch self {
        case .gratitude: return "Gratidao"
        case .neutral: return "Aconteceu"
        case .improve: return "Melhorar"
        }
    }

    var placeholder: String {
        switch self {
        case .gratitude: return "Pelo que voce foi grato hoje?"
        case .neutral: return "O que simplesmente aconteceu hoje?"
        case .improve: return "O que voce queria que fosse melhor?"
        }
    }

    var question: String {
        switch self {
        case .gratitude: return "Algo que você foi grato hoje"
        case .neutral: return "Algo que simplesmente aconteceu"
        case .improve: return "Algo que você queria que fosse melhor"
        }
    }
}
