import AppIntents
import SwiftUI

/// Aktion „Schimpf!“ für Action-Button, Kurzbefehle und Siri:
/// erzeugt sofort ein Schimpfwort, liest es vor und zeigt es kurz an –
/// ohne die App zu öffnen. Verwendet die in der App gewählte Einstellung Mann/Frau.
struct SchimpfIntent: AppIntent {
    static var title: LocalizedStringResource = "Schimpf!"
    static var description = IntentDescription(
        "Erzeugt a bayerisches Schimpfwort und liest's sofort vor."
    )
    static var openAppWhenRun: Bool = false

    @MainActor
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let gespeichert = UserDefaults.standard.string(forKey: "geschlecht") ?? ""
        let geschlecht = Geschlecht(rawValue: gespeichert) ?? .mann
        let wort = Wortschatz.zufaellig(fuer: geschlecht)

        await Sprecher.shared.sprichUndWarte(wort.text)

        return .result(view: SchimpfKarte(wort: wort))
    }
}

/// Kleine Karte, die nach dem Auslösen eingeblendet wird.
private struct SchimpfKarte: View {
    let wort: Schimpfwort

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(wort.text)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(Color.gripplBlau)
            Text("preißisch: \(wort.uebersetzung)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

/// Macht die Aktion ohne Einrichtung in Kurzbefehle, Spotlight, Siri
/// und in der Auswahl für den Action-Button verfügbar.
struct GripplKurzbefehle: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: SchimpfIntent(),
            phrases: [
                "Schimpf mit \(.applicationName)",
                "\(.applicationName) schimpf",
                "Grantl mit \(.applicationName)",
            ],
            shortTitle: "Schimpf!",
            systemImageName: "speaker.wave.2.bubble"
        )
    }

    static var shortcutTileColor: ShortcutTileColor = .navy
}
