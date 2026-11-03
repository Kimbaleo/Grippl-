import SwiftUI

/// Schriftzug „Grippl“: Buchstaben im Wechsel blau und weiß mit blauer Kontur,
/// angelehnt an die weiß-blauen Rauten.
struct GripplTitel: View {
    var groesse: CGFloat = 56

    private let buchstaben = Array("Grippl")

    var body: some View {
        HStack(spacing: 0) {
            ForEach(buchstaben.indices, id: \.self) { i in
                if i.isMultiple(of: 2) {
                    Text(String(buchstaben[i]))
                        .foregroundStyle(Color.gripplBlau)
                } else {
                    UmrissBuchstabe(text: String(buchstaben[i]), breite: max(1.5, groesse / 26))
                }
            }
        }
        .font(.system(size: groesse, weight: .heavy))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Grippl")
        .accessibilityAddTraits(.isHeader)
    }
}

/// Weißer Buchstabe mit blauer Kontur (SwiftUI kennt keine Text-Kontur,
/// deshalb wird der blaue Buchstabe ringsum leicht versetzt darunter gelegt).
private struct UmrissBuchstabe: View {
    let text: String
    let breite: CGFloat

    private static let richtungen: [CGSize] = (0..<16).map { i in
        let winkel = Double(i) / 16 * 2 * Double.pi
        return CGSize(width: cos(winkel), height: sin(winkel))
    }

    var body: some View {
        ZStack {
            ForEach(Self.richtungen.indices, id: \.self) { i in
                Text(text)
                    .foregroundStyle(Color.gripplBlau)
                    .offset(x: Self.richtungen[i].width * breite,
                            y: Self.richtungen[i].height * breite)
            }
            Text(text)
                .foregroundStyle(Color.white)
        }
    }
}
