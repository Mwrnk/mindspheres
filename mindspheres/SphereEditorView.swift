import SwiftUI

struct SphereEditorView: View {
    let type: SphereType
    @Binding var text: String
    let onClose: () -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            type.color
                .ignoresSafeArea()

            Circle()
                .fill(.white.opacity(0.15))
                .blur(radius: 100)
                .frame(width: 300, height: 300)
                .offset(x: -50, y: -150)

            LinearGradient(
                colors: [.white.opacity(0.2), .black.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: onClose) {
                        Image(systemName: "chevron.left")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                            .frame(width: 44, height: 44)
                    }

                    Spacer()

                    Button("Concluir") {
                        onClose()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(.white.opacity(0.25))
                    )
                }
                .padding()
                .padding(.top, 44)

                Spacer()
                    .frame(height: 40)

                Text(type.question)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 32)

                Spacer()
                    .frame(height: 40)

                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white.opacity(0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                        )

                    TextEditor(text: $text)
                        .focused($isFocused)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .padding(24)
                        .tint(.white)

                    if text.isEmpty {
                        Text("Toque para começar...")
                            .font(.system(size: 24))
                            .foregroundStyle(.white.opacity(0.4))
                            .padding(32)
                            .allowsHitTesting(false)
                    }
                }
                .frame(height: 300)
                .padding(.horizontal, 24)

                Spacer()

                Text("REFLEXÃO PRIVADA")
                    .font(.system(size: 11, weight: .black))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isFocused = true
            }
        }
    }
}
