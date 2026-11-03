import SwiftUI
import UIKit

/// Liste der gemerkten Schimpfwörter.
struct FavoritenView: View {
    @Environment(FavoritenSpeicher.self) private var favoriten
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if favoriten.eintraege.isEmpty {
                    ContentUnavailableView(
                        "Nix gmerkt",
                        systemImage: "heart",
                        description: Text("Tipp aufs Herzerl, dann landet a Schimpfwort do.")
                    )
                } else {
                    List {
                        ForEach(favoriten.eintraege) { s in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(s.text)
                                    .font(.headline)
                                Text("preißisch: \(s.uebersetzung)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 2)
                            .contextMenu {
                                Button("Kopiern", systemImage: "doc.on.doc") {
                                    UIPasteboard.general.string = s.text
                                }
                                ShareLink(item: "\(s.text) 🥨\npreißisch: \(s.uebersetzung)") {
                                    Label("Teilen", systemImage: "square.and.arrow.up")
                                }
                                Button("Vorlesen", systemImage: "speaker.wave.2") {
                                    Sprecher.shared.sprich(s.text)
                                }
                            }
                        }
                        .onDelete { favoriten.loeschen(at: $0) }
                    }
                }
            }
            .navigationTitle("Gmerkt")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fertig") { dismiss() }
                }
            }
        }
        .tint(Color.gripplBlau)
    }
}
