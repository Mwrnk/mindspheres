import Foundation
import SwiftUI

@Observable
class DayViewModel {
    var todayEntry: DayEntry
    var entries: [DayEntry] = []

    private let storage = StorageService()

    init() {
        let loadedEntries = storage.loadEntries()
        self.entries = loadedEntries

        let today = Calendar.current.startOfDay(for: Date())
        if let existing = loadedEntries.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: today)
        }) {
            self.todayEntry = existing
        } else {
            self.todayEntry = DayEntry(date: today)
        }
    }

    func updateText(_ text: String, for type: SphereType) {
        todayEntry.setText(text, for: type)
        saveToday()
    }

    func getText(for type: SphereType) -> String {
        todayEntry.text(for: type)
    }

    func isFilled(_ type: SphereType) -> Bool {
        !todayEntry.text(for: type).isEmpty
    }

    private func saveToday() {
        entries.removeAll { Calendar.current.isDate($0.date, inSameDayAs: todayEntry.date) }
        entries.append(todayEntry)
        storage.saveEntries(entries)
    }

    func entryStatus(for date: Date) -> EntryStatus {
        guard let entry = entries.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }) else {
            return .empty
        }
        return entry.isComplete ? .complete : .partial
    }

    enum EntryStatus {
        case empty, partial, complete
    }
}
