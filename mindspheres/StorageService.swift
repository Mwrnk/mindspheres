import Foundation

class StorageService {
    private let key = "mindspheresEntries"

    func saveEntries(_ entries: [DayEntry]) {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func loadEntries() -> [DayEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let entries = try? JSONDecoder().decode([DayEntry].self, from: data) else {
            return []
        }
        return entries
    }
}
