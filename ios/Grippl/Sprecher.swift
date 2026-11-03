import AVFoundation

/// Liest Schimpfwörter mit der deutschen Systemstimme vor.
final class Sprecher {
    static let shared = Sprecher()

    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func sprich(_ text: String) {
        // Auch hörbar, wenn der Stummschalter an ist; andere Audio-Wiedergabe wird kurz leiser
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.duckOthers])
        try? AVAudioSession.sharedInstance().setActive(true)

        synthesizer.stopSpeaking(at: .immediate)
        let aeusserung = AVSpeechUtterance(string: text)
        aeusserung.voice = AVSpeechSynthesisVoice(language: "de-DE")
        aeusserung.rate = 0.45
        aeusserung.pitchMultiplier = 0.9
        synthesizer.speak(aeusserung)
    }
}
