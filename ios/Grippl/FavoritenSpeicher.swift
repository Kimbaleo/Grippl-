import SwiftUI
import Observation

/// Speichert gemerkte Schimpfwörter dauerhaft auf dem Gerät (UserDefaults).
/// Es verlassen keine Daten das iPhone.
@Observable
final class FavoritenSpeicher {
    private(set) var eintraege: [Schimpfwort] = []

    @ObservationIgnored
    private let schluessel = "favoriten"

    init() {
        if let daten = UserDefaults.standard.data(forKey: schluessel),
           let liste = try? JSONDecoder().decode([Schimpfwort].self, from: daten) {
            eintraege = liste
        }
    }

    func enthaelt(_ wort: Schimpfwort) -> Bool {
        eintraege.contains(wort)
    }

    func umschalten(_ wort: Schimpfwort) {
        if let index = eintraege.firstIndex(of: wort) {
            eintraege.remove(at: index)
        } else {
            eintraege.insert(wort, at: 0)
        }
        sichern()
    }

    func loeschen(at offsets: IndexSet) {
        eintraege.remove(atOffsets: offsets)
        sichern()
    }

    private func sichern() {
        if let daten = try? JSONEncoder().encode(eintraege) {
            UserDefaults.standard.set(daten, forKey: schluessel)
        }
    }
}
