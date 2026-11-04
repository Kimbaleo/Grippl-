import SwiftUI
import UIKit

struct ContentView: View {
    @Environment(FavoritenSpeicher.self) private var favoriten
    @AppStorage("geschlecht") private var geschlecht: Geschlecht = .mann

    @State private var aktuell: Schimpfwort?
    @State private var teilBild: Image?
    @State private var kopiert = false
    @State private var zeigeFavoriten = false

    /// iPhone quer gedreht (Höhe „compact“) → Vollbild nur mit dem Schimpfwort.
    @Environment(\.verticalSizeClass) private var hoehenKlasse
    private var querformat: Bool { hoehenKlasse == .compact }

    var body: some View {
        Group {
            if querformat {
                vollbild
            } else {
                hochformat
            }
        }
        .tint(Color.gripplBlau)
        .beiSchuetteln { neu() }
        .sensoryFeedback(.impact(weight: .medium), trigger: aktuell)
        .onChange(of: geschlecht) {
            if aktuell != nil { neu() }
        }
        // Beim Drehen ohne vorhandenes Wort gleich eins erzeugen
        .onChange(of: querformat) {
            if querformat && aktuell == nil { neu() }
        }
        .onAppear {
            if querformat && aktuell == nil { neu() }
        }
    }

    // MARK: - Querformat: nur das Schimpfwort, bildschirmfüllend

    private var vollbild: some View {
        ZStack {
            Color.gripplHintergrund.ignoresSafeArea()

            if let s = aktuell {
                Text(s.text)
                    .font(.system(size: 220, weight: .heavy))
                    .tracking(-2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.primary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .id(s.text)
                    .transition(.opacity)
                    .accessibilityHint("Tippen für a neues Schimpfwort")
            }
        }
        // Tippen irgendwo erzeugt ein neues Wort (Schütteln geht auch)
        .contentShape(Rectangle())
        .onTapGesture { neu() }
        .statusBarHidden(true)
        .persistentSystemOverlays(.hidden)
    }

    // MARK: - Hochformat

    private var hochformat: some View {
        NavigationStack {
            ZStack {
                Color.gripplHintergrund.ignoresSafeArea()

                VStack {
                    Spacer(minLength: 48)
                    karte
                    Spacer()
                    Text("Tipp: Schüttl's Handy!")
                        .font(.footnote)
                        .foregroundStyle(Color.gripplLeise)
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 20)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        zeigeFavoriten = true
                    } label: {
                        Label("Gmerkt", systemImage: "heart.text.square")
                    }
                }
            }
            .sheet(isPresented: $zeigeFavoriten) {
                FavoritenView()
            }
        }
    }

    // MARK: - Karte

    private var karte: some View {
        VStack(alignment: .leading, spacing: 28) {
            Picker("Schimpfwort für", selection: $geschlecht) {
                ForEach(Geschlecht.allCases) { g in
                    Text(g.titel).tag(g)
                }
            }
            .pickerStyle(.segmented)

            ausgabe

            Button(action: neu) {
                Text("Schimpf!")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .buttonStyle(SchimpfKnopf())
        }
        .padding(.horizontal, 24)
        .padding(.top, 52)
        .padding(.bottom, 24)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.gripplFlaeche)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(Color.gripplLinie, lineWidth: 1)
        )
        // Schriftzug sitzt mittig auf dem oberen Rand der Karte
        .overlay(alignment: .topLeading) {
            GripplTitel()
                .padding(.leading, 24)
                .alignmentGuide(.top) { d in d[VerticalAlignment.center] }
        }
    }

    private var ausgabe: some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle()
                .fill(Color.gripplBlau)
                .frame(width: 3)

            VStack(alignment: .leading, spacing: 10) {
                if let s = aktuell {
                    Text(s.text)
                        .font(.system(size: 40, weight: .heavy))
                        .tracking(-0.8)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(Color.primary)
                        .id(s.text)
                        .transition(.opacity.combined(with: .offset(y: 6)))

                    Text("preißisch: \(s.uebersetzung)")
                        .font(.subheadline)
                        .foregroundStyle(Color.gripplLeise)

                    aktionen(fuer: s)
                } else {
                    Text("Grantla")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundStyle(Color.gripplLinie)
                    Text("Druck auf'n Knopf.")
                        .font(.subheadline)
                        .foregroundStyle(Color.gripplLeise)
                }
            }
            .padding(.leading, 20)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, minHeight: 160, alignment: .leading)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private func aktionen(fuer s: Schimpfwort) -> some View {
        HStack(spacing: 24) {
            Button {
                UIPasteboard.general.string = s.text
                kopiert = true
            } label: {
                Label(kopiert ? "Kopiert" : "Kopiern",
                      systemImage: kopiert ? "checkmark" : "doc.on.doc")
            }

            ShareLink(item: "\(s.text) 🥨\npreißisch: \(s.uebersetzung)") {
                Label("Teilen", systemImage: "square.and.arrow.up")
            }

            if let bild = teilBild {
                ShareLink(item: bild, preview: SharePreview(s.text, image: bild)) {
                    Label("Als Bild teilen", systemImage: "photo")
                }
            }

            Button {
                Sprecher.shared.sprich(s.text)
            } label: {
                Label("Vorlesen", systemImage: "speaker.wave.2")
            }

            Button {
                favoriten.umschalten(s)
            } label: {
                Label(favoriten.enthaelt(s) ? "Nimmer merken" : "Merken",
                      systemImage: favoriten.enthaelt(s) ? "heart.fill" : "heart")
            }
        }
        .labelStyle(.iconOnly)
        .font(.title3)
        .foregroundStyle(Color.gripplBlau)
        .padding(.top, 6)
    }

    // MARK: - Aktionen

    private func neu() {
        let s = Wortschatz.zufaellig(fuer: geschlecht, ausser: aktuell)
        withAnimation(.easeOut(duration: 0.25)) {
            aktuell = s
        }
        kopiert = false
        teilBild = TeilBild.rendern(s)
    }
}

/// Blauer Hauptknopf „Schimpf!“.
struct SchimpfKnopf: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.gripplAufBlau)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.gripplBlau)
            )
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
        .environment(FavoritenSpeicher())
}
