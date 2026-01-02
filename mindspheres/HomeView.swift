import SwiftUI

struct HomeView: View {
    @State private var viewModel = DayViewModel()
    @State private var selectedSphere: SphereType?
    @State private var isExpanded = false
    @State private var rotationAngle: Double = 0
    @State private var tapPosition: CGPoint = .zero
    @State private var showCelebration = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.darkBgTop, .darkBgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if !isExpanded && !showCelebration {
                mainContent
                    .transition(.opacity)
            }

            if isExpanded, let sphere = selectedSphere {
                SphereEditorView(
                    type: sphere,
                    text: Binding(
                        get: { viewModel.getText(for: sphere) },
                        set: { viewModel.updateText($0, for: sphere) }
                    ),
                    onClose: handleEditorClose
                )
                .clipShape(
                    CircularClipShape(
                        progress: isExpanded ? 1.0 : 0.0,
                        origin: tapPosition
                    )
                )
                .animation(
                    .timingCurve(0.32, 0.72, 0, 1, duration: 0.7),
                    value: isExpanded
                )
            }

            if showCelebration {
                CelebrationView {
                    withAnimation(.spring()) {
                        showCelebration = false
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
        }
    }

    private var mainContent: some View {
        VStack(spacing: 0) {
            DateHeaderView(hasEntryToday: viewModel.todayEntry.completedCount > 0)
                .padding(.top, 60)
                .padding(.horizontal, 32)

            CalendarStripView(viewModel: viewModel)
                .padding(.top, 24)

            Spacer()

            ZStack {
                Circle()
                    .fill(.clear)
                    .frame(width: 20, height: 20)

                ForEach(Array(SphereType.allCases.enumerated()), id: \.element) { index, type in
                    sphereButtonCentered(for: type, index: index)
                }
            }
            .rotationEffect(.degrees(rotationAngle))
            .frame(width: 400, height: 400)

            Spacer()
        }
    }

    @ViewBuilder
    private func sphereButtonCentered(for type: SphereType, index: Int) -> some View {
        let radius: CGFloat = 120
        let angle = (2 * .pi / 3) * Double(index) - .pi / 2
        let xOffset = radius * cos(angle)
        let yOffset = radius * sin(angle)

        GeometryReader { buttonGeo in
            SphereButton(
                type: type,
                isFilled: viewModel.isFilled(type),
                isExpanded: isExpanded
            )
            .rotationEffect(.degrees(-rotationAngle))
            .position(
                x: buttonGeo.size.width / 2,
                y: buttonGeo.size.height / 2
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        let globalFrame = buttonGeo.frame(in: .global)
                        tapPosition = CGPoint(
                            x: globalFrame.minX + value.location.x,
                            y: globalFrame.minY + value.location.y
                        )
                        selectedSphere = type
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            isExpanded = true
                        }
                    }
            )
        }
        .frame(width: 140, height: 140)
        .offset(x: xOffset, y: yOffset)
    }

    private func handleEditorClose() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
            isExpanded = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            selectedSphere = nil

            if viewModel.todayEntry.isComplete {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.spring()) {
                        showCelebration = true
                    }
                }
            }
        }
    }
}

struct DateHeaderView: View {
    let hasEntryToday: Bool

    private var dayNumber: String {
        let day = Calendar.current.component(.day, from: Date())
        return String(format: "%02d", day)
    }

    private var weekdayName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: Date()).capitalized
    }

    private var monthAndDay: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MMMM"
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(spacing: 12) {
            TimelineView(.periodic(from: .now, by: 60)) { context in
                Text(context.date, format: .dateTime.hour().minute())
                    .font(.system(size: 14, weight: .black))
                    .tracking(1)
                    .foregroundStyle(.white.opacity(0.6))
            }

            HStack(alignment: .top) {
                HStack(alignment: .top, spacing: 4) {
                    Text(dayNumber)
                        .font(.system(size: 64, weight: .bold, design: .default))
                        .foregroundStyle(.white)

                    if hasEntryToday {
                        Text("*")
                            .font(.system(size: 36, weight: .regular))
                            .foregroundStyle(Color.sphereOrange)
                            .offset(y: 0)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(weekdayName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))

                    Text(monthAndDay)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white.opacity(0.6))
                }
                .padding(.top, 22)
            }
        }
    }
}

#Preview {
    HomeView()
}
