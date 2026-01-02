import SwiftUI

struct CalendarStripView: View {
    let viewModel: DayViewModel

    private let calendar = Calendar.current

    var days: [Date] {
        let today = calendar.startOfDay(for: Date())
        return (-3...3).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            ForEach(days, id: \.self) { date in
                DayIndicator(
                    date: date,
                    status: viewModel.entryStatus(for: date),
                    isToday: calendar.isDateInToday(date)
                )
            }
        }
        .padding(.horizontal, 24)
    }
}

struct DayIndicator: View {
    let date: Date
    let status: DayViewModel.EntryStatus
    let isToday: Bool

    private var dayNumber: String {
        date.formatted(.dateTime.day())
    }

    private var weekdayInitial: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "EEEEE"
        return formatter.string(from: date).uppercased()
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(weekdayInitial)
                .font(.system(size: 10, weight: .black))
                .foregroundStyle(Color(.tertiaryLabel))

            ZStack {
                if isToday {
                    Circle()
                        .fill(.black)
                        .frame(width: 36, height: 36)
                }

                Text(dayNumber)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(isToday ? .white : Color(.secondaryLabel))
            }
        }
        .frame(width: 44, height: 60)
    }
}
