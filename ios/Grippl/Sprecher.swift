import AVFoundation

/// Liest Schimpfwörter mit der deutschen Systemstimme vor.
final class Sprecher: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = Sprecher()

    private let synthesizer = AVSpeechSynthesizer()

    /// Wartende Aufrufer von `sprichUndWarte`, je Äußerung.
    private var wartend: [ObjectIdentifier: CheckedContinuation<Void, Never>] = [:]

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Liest vor und kehrt sofort zurück (für Knöpfe in der App).
    func sprich(_ text: String) {
        synthesizer.speak(vorbereiten(text))
    }

    /// Liest vor und kehrt erst zurück, wenn fertig gesprochen ist
    /// (für den Action-Button / Kurzbefehle, damit die App so lange aktiv bleibt).
    func sprichUndWarte(_ text: String) async {
        await withCheckedContinuation { (fortsetzung: CheckedContinuation<Void, Never>) in
            let aeusserung = vorbereiten(text)
            wartend[ObjectIdentifier(aeusserung)] = fortsetzung
            synthesizer.speak(aeusserung)
        }
    }

    private func vorbereiten(_ text: String) -> AVSpeechUtterance {
        // Auch hörbar, wenn der Stummschalter an ist; andere Audio-Wiedergabe wird kurz leiser
        let sitzung = AVAudioSession.sharedInstance()
        try? sitzung.setCategory(.playback, options: [.duckOthers])
        try? sitzung.setActive(true)

        synthesizer.stopSpeaking(at: .immediate)

        let aeusserung = AVSpeechUtterance(string: text)
        aeusserung.voice = AVSpeechSynthesisVoice(language: "de-DE")
        aeusserung.rate = 0.45
        aeusserung.pitchMultiplier = 0.9
        return aeusserung
    }

    private func beendet(_ aeusserung: AVSpeechUtterance) {
        wartend.removeValue(forKey: ObjectIdentifier(aeusserung))?.resume()
        if !synthesizer.isSpeaking {
            // Andere Musik/Podcasts wieder laut stellen
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        }
    }

    // MARK: - AVSpeechSynthesizerDelegate

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        beendet(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        beendet(utterance)
    }
}
