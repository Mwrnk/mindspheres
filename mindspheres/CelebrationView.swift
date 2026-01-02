import SwiftUI

struct CelebrationView: View {
    let onReview: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.sphereGreen)
                        .frame(width: 140, height: 140)
                        .shadow(color: .sphereGreen.opacity(0.5), radius: 30, y: 15)

                    Image(systemName: "checkmark")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundStyle(.white)
                }

                VStack(spacing: 12) {
                    Text("Tudo pronto!")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)

                    Text("Seu dia foi registrado com sucesso.")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                Button(action: onReview) {
                    Text("Revisar Respostas")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 18)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.2))
                                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                        )
                }
                .padding(.top, 16)
            }
            .padding(.horizontal, 40)
        }
        .transition(.scale.combined(with: .opacity))
    }
}

#Preview {
    CelebrationView {
        print("Review tapped")
    }
}
