import SwiftUI

extension Color {
    static let sphereGreen = Color(hex: "EDF060")
    static let sphereBlue = Color(hex: "225560")
    static let sphereOrange = Color(hex: "F0803C")
    static let sphereEmpty = Color(red: 0.90, green: 0.90, blue: 0.90)

    static let darkBgTop = Color(red: 5/255, green: 5/255, blue: 10/255)
    static let darkBgBottom = Color(red: 10/255, green: 10/255, blue: 15/255)

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        r = (int >> 16) & 0xFF
        g = (int >> 8) & 0xFF
        b = int & 0xFF

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
