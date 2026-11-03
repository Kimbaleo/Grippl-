import Foundation

/// Für wen das Schimpfwort sein soll.
enum Geschlecht: String, Codable, CaseIterable, Identifiable {
    case mann, frau

    var id: String { rawValue }

    var titel: String {
        switch self {
        case .mann: return "Mann"
        case .frau: return "Frau"
        }
    }
}

/// Ein fertiges Schimpfwort, z. B. „Greislicha Gschaftlhuaba“.
struct Schimpfwort: Codable, Hashable, Identifiable {
    var id: String { text }
    let text: String
    /// Hochdeutsche Übersetzung, z. B. „scheußlich + Wichtigtuer“.
    let uebersetzung: String
}

/// Alle Wörter und die Logik, sie zusammenzusetzen.
enum Wortschatz {

    private enum Genus { case m, w, s }

    private struct Adjektiv {
        let stamm: String
        let deutsch: String
    }

    private struct Hauptwort {
        let wort: String
        let genus: Genus
        let deutsch: String
        /// Für sächliche Wörter, die nur zu einem Geschlecht passen (z. B. „Bürscherl“).
        var nurFuer: Geschlecht? = nil
    }

    // Eigenschaftswörter: Stamm + Endung je nach Geschlecht (m: -a, w: -e, s: -s)
    private static let adjektive: [Adjektiv] = [
        Adjektiv(stamm: "damisch", deutsch: "dämlich"),
        Adjektiv(stamm: "bläd", deutsch: "blöd"),
        Adjektiv(stamm: "greislich", deutsch: "scheußlich"),
        Adjektiv(stamm: "hinterfotzig", deutsch: "hinterhältig"),
        Adjektiv(stamm: "gscheart", deutsch: "ungehobelt"),
        Adjektiv(stamm: "narrisch", deutsch: "verrückt"),
        Adjektiv(stamm: "schiach", deutsch: "hässlich"),
        Adjektiv(stamm: "letschert", deutsch: "lasch"),
        Adjektiv(stamm: "gwampert", deutsch: "dickbäuchig"),
        Adjektiv(stamm: "zaundürr", deutsch: "spindeldürr"),
        Adjektiv(stamm: "ausgschamt", deutsch: "unverschämt"),
        Adjektiv(stamm: "grantig", deutsch: "schlecht gelaunt"),
        Adjektiv(stamm: "neidig", deutsch: "neidisch"),
        Adjektiv(stamm: "hirnrissig", deutsch: "hirnverbrannt"),
        Adjektiv(stamm: "rotzfrech", deutsch: "frech"),
        Adjektiv(stamm: "verzogn", deutsch: "unerzogen"),
        Adjektiv(stamm: "bsuffn", deutsch: "betrunken"),
        Adjektiv(stamm: "oglatscht", deutsch: "ungepflegt"),
        Adjektiv(stamm: "gschleckt", deutsch: "geschniegelt"),
        Adjektiv(stamm: "gschupft", deutsch: "überspannt"),
    ]

    private static let hauptwoerter: [Hauptwort] = [
        Hauptwort(wort: "Depp", genus: .m, deutsch: "Dummkopf"),
        Hauptwort(wort: "Hirnbaatzl", genus: .m, deutsch: "Hirnloser"),
        Hauptwort(wort: "Grattler", genus: .m, deutsch: "Habenichts"),
        Hauptwort(wort: "Bazi", genus: .m, deutsch: "Schlitzohr"),
        Hauptwort(wort: "Haumdaucher", genus: .m, deutsch: "Rüpel"),
        Hauptwort(wort: "Hornochs", genus: .m, deutsch: "Hornochse"),
        Hauptwort(wort: "Schofsbeidl", genus: .m, deutsch: "Trottel"),
        Hauptwort(wort: "Lackl", genus: .m, deutsch: "grober Kerl"),
        Hauptwort(wort: "Doldi", genus: .m, deutsch: "Trottel"),
        Hauptwort(wort: "Hanswurscht", genus: .m, deutsch: "Hanswurst"),
        Hauptwort(wort: "Dampfplauderer", genus: .m, deutsch: "Schwätzer"),
        Hauptwort(wort: "Gschaftlhuaba", genus: .m, deutsch: "Wichtigtuer"),
        Hauptwort(wort: "Saubeidl", genus: .m, deutsch: "Mistkerl"),
        Hauptwort(wort: "Rotzleffe", genus: .m, deutsch: "Rotzlöffel"),
        Hauptwort(wort: "Bierdimpfe", genus: .m, deutsch: "Biertrinker ohne Hirn"),
        Hauptwort(wort: "Hammeldepp", genus: .m, deutsch: "Volltrottel"),
        Hauptwort(wort: "Krautschädl", genus: .m, deutsch: "Dickkopf"),
        Hauptwort(wort: "Simpe", genus: .m, deutsch: "Einfaltspinsel"),
        Hauptwort(wort: "Zwiderwurzn", genus: .w, deutsch: "Griesgram"),
        Hauptwort(wort: "Ratschkathl", genus: .w, deutsch: "Tratschtante"),
        Hauptwort(wort: "Bissgurkn", genus: .w, deutsch: "zänkische Person"),
        Hauptwort(wort: "Funsn", genus: .w, deutsch: "eingebildete Ziege"),
        Hauptwort(wort: "Trutschn", genus: .w, deutsch: "Trampel"),
        Hauptwort(wort: "Schnepfn", genus: .w, deutsch: "dumme Gans"),
        Hauptwort(wort: "Hupfdohln", genus: .w, deutsch: "Zappelphilipp"),
        Hauptwort(wort: "Sumpfbiaschn", genus: .w, deutsch: "Kneipenhocker"),
        Hauptwort(wort: "Urschl", genus: .w, deutsch: "einfältige Frau"),
        Hauptwort(wort: "Goaß", genus: .w, deutsch: "Ziege"),
        Hauptwort(wort: "Kuah", genus: .w, deutsch: "Kuh"),
        Hauptwort(wort: "Gurkn", genus: .w, deutsch: "dumme Gurke"),
        Hauptwort(wort: "Ratschn", genus: .w, deutsch: "Tratschweib"),
        Hauptwort(wort: "Rindviech", genus: .s, deutsch: "Rindvieh"),
        Hauptwort(wort: "Gscheidhaferl", genus: .s, deutsch: "Besserwisser"),
        Hauptwort(wort: "Mistviech", genus: .s, deutsch: "Mistvieh"),
        Hauptwort(wort: "Krischperl", genus: .s, deutsch: "Schwächling"),
        Hauptwort(wort: "Hascherl", genus: .s, deutsch: "armes Würstchen"),
        Hauptwort(wort: "Fleischpflanzerl", genus: .s, deutsch: "Frikadelle"),
        Hauptwort(wort: "Oaschgsicht", genus: .s, deutsch: "Arschgesicht"),
        Hauptwort(wort: "Bürscherl", genus: .s, deutsch: "Bürschchen", nurFuer: .mann),
    ]

    private static func endung(_ genus: Genus) -> String {
        switch genus {
        case .m: return "a"
        case .w: return "e"
        case .s: return "s"
        }
    }

    /// Sächliche Wörter passen für beide Geschlechter (außer sie sind eingeschränkt).
    private static func passt(_ h: Hauptwort, fuer geschlecht: Geschlecht) -> Bool {
        switch h.genus {
        case .m: return geschlecht == .mann
        case .w: return geschlecht == .frau
        case .s: return h.nurFuer == nil || h.nurFuer == geschlecht
        }
    }

    private static func bilde(_ a: Adjektiv, _ h: Hauptwort) -> Schimpfwort {
        let roh = a.stamm + endung(h.genus) + " " + h.wort
        let text = roh.prefix(1).uppercased() + roh.dropFirst()
        return Schimpfwort(text: text, uebersetzung: "\(a.deutsch) + \(h.deutsch)")
    }

    /// Zufälliges Schimpfwort; nie zweimal das gleiche hintereinander.
    static func zufaellig(fuer geschlecht: Geschlecht, ausser letztes: Schimpfwort? = nil) -> Schimpfwort {
        let auswahl = hauptwoerter.filter { passt($0, fuer: geschlecht) }
        var neu: Schimpfwort
        repeat {
            neu = bilde(adjektive.randomElement()!, auswahl.randomElement()!)
        } while neu == letztes
        return neu
    }

    /// Schimpfwort des Tages: für jeden Tag fest, auf allen Geräten gleich.
    static func desTages(_ datum: Date = Date()) -> Schimpfwort {
        let tag = Calendar.current.ordinality(of: .day, in: .era, for: datum) ?? 0
        // Einfacher, fester Zufallsgenerator (LCG), damit es jeden Tag anders, aber reproduzierbar ist
        var x = UInt64(tag) &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
        let a = adjektive[Int((x >> 33) % UInt64(adjektive.count))]
        x = x &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
        let h = hauptwoerter[Int((x >> 33) % UInt64(hauptwoerter.count))]
        return bilde(a, h)
    }
}
