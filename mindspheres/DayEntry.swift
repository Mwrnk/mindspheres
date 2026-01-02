import Foundation

struct DayEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    var gratitudeText: String
    var neutralText: String
    var improveText: String

    var isComplete: Bool {
        !gratitudeText.isEmpty && !neutralText.isEmpty && !improveText.isEmpty
    }

    var completedCount: Int {
        [gratitudeText, neutralText, improveText].filter { !$0.isEmpty }.count
    }

    init(date: Date = Date()) {
        self.id = UUID()
        self.date = date
        self.gratitudeText = ""
        self.neutralText = ""
        self.improveText = ""
    }

    func text(for type: SphereType) -> String {
        switch type {
        case .gratitude: return gratitudeText
        case .neutral: return neutralText
        case .improve: return improveText
        }
    }

    mutating func setText(_ text: String, for type: SphereType) {
        switch type {
        case .gratitude: gratitudeText = text
        case .neutral: neutralText = text
        case .improve: improveText = text
        }
    }
}
