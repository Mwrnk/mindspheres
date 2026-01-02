import SwiftUI

struct SphereButton: View {
    let type: SphereType
    let isFilled: Bool
    let isExpanded: Bool

    @State private var breathingScale: CGFloat = 1.0
    @State private var pulseScale: CGFloat = 1.0

    private let sphereSize: CGFloat = 140

    var body: some View {
        ZStack {
            Circle()
                .fill(type.color.opacity(0.5))
                .background(.ultraThinMaterial)
                .clipShape(Circle())

            Circle()
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.3), .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(8)

            if isFilled {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
            } else {
                Circle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 10, height: 10)
                    .scaleEffect(pulseScale)
            }
        }
        .frame(width: sphereSize, height: sphereSize)
        .shadow(color: type.color.opacity(0.3), radius: 20, y: 10)
        .scaleEffect(breathingScale)
        .onAppear {
            startAnimations()
        }
        .onChange(of: isFilled) { oldValue, newValue in
            if newValue {
                pulseScale = 1.0
            } else {
                startPulseAnimation()
            }
        }
        .onChange(of: isExpanded) { oldValue, newValue in
            if !newValue && oldValue {
                startAnimations()
            }
        }
    }

    private func startAnimations() {
        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
            breathingScale = 1.08
        }

        if !isFilled {
            startPulseAnimation()
        }
    }

    private func startPulseAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            pulseScale = 1.3
        }
    }
}
