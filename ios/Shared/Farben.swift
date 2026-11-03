import SwiftUI
import UIKit

/// Farben wie in der Web-Version, jeweils für hellen und dunklen Modus.
extension Color {
    static let gripplBlau = dynamisch(hell: 0x0060B0, dunkel: 0x4A9BE0)
    static let gripplAufBlau = dynamisch(hell: 0xFFFFFF, dunkel: 0x0B1A2B)
    static let gripplHintergrund = dynamisch(hell: 0xF7F8FA, dunkel: 0x0F1216)
    static let gripplFlaeche = dynamisch(hell: 0xFFFFFF, dunkel: 0x171B21)
    static let gripplLinie = dynamisch(hell: 0xE5E7EB, dunkel: 0x2A3038)
    static let gripplLeise = dynamisch(hell: 0x6B7280, dunkel: 0x9AA3AD)

    private static func dynamisch(hell: UInt32, dunkel: UInt32) -> Color {
        Color(uiColor: UIColor { merkmale in
            UIColor(hex: merkmale.userInterfaceStyle == .dark ? dunkel : hell)
        })
    }
}

extension UIColor {
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
