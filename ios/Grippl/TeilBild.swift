import SwiftUI
import UIKit

/// Quadratisches Bild zum Teilen (z. B. in WhatsApp oder als Story).
struct TeilBild: View {
    let wort: Schimpfwort

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GripplTitel(groesse: 34)
            Spacer()
            Text(wort.text)
                .font(.system(size: 44, weight: .heavy))
                .tracking(-0.8)
                .foregroundStyle(Color(uiColor: UIColor(hex: 0x14181F)))
                .minimumScaleFactor(0.5)
                .lineLimit(3)
            Text("preißisch: \(wort.uebersetzung)")
                .font(.system(size: 17))
                .foregroundStyle(Color(uiColor: UIColor(hex: 0x6B7280)))
                .padding(.top, 10)
            Spacer()
            Rectangle()
                .fill(Color(uiColor: UIColor(hex: 0x0060B0)))
                .frame(height: 4)
        }
        .padding(32)
        .frame(width: 360, height: 360, alignment: .leading)
        .background(Color.white)
        .environment(\.colorScheme, .light)
    }

    /// Erzeugt das Bild in hoher Auflösung (1080 × 1080 Pixel).
    @MainActor
    static func rendern(_ wort: Schimpfwort) -> Image? {
        let renderer = ImageRenderer(content: TeilBild(wort: wort))
        renderer.scale = 3
        guard let uiImage = renderer.uiImage else { return nil }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    TeilBild(wort: Wortschatz.desTages())
}
