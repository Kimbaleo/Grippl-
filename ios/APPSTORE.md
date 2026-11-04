# App-Store-Eintrag – Vorlagen

Texte zum Kopieren in **App Store Connect** (appstoreconnect.apple.com).

## Grunddaten

| Feld | Vorschlag |
|---|---|
| Name | Grippl |
| Untertitel (max. 30 Zeichen) | Bayerische Schimpfwörter |
| Kategorie | Unterhaltung (Nebenkategorie: Referenz) |
| Bundle-ID | `de.kimbaleo.grippl` (muss zu Xcode passen) |
| Preis | Kostenlos |
| Datenschutz-URL | `https://kimbaleo.github.io/Grippl-/datenschutz.html` |
| Support-URL | `https://github.com/Kimbaleo/Grippl-` |

## Beschreibung

```
Grantig? Dann sag's auf Bairisch!

Grippl erzeugt per Knopfdruck – oder durch Schütteln des iPhones – ein zünftiges
bayerisches Schimpfwort. Vom „greislichn Gschaftlhuaba“ bis zur „narrischn Ratschkathl“:
Hunderte Kombinationen, grammatikalisch passend für Mann oder Frau.

• Schimpfwort per Knopfdruck oder Schütteln
• Für Mann oder Frau – die Endungen passen sich an
• Preißische Übersetzung zu jedem Wort
• Vorlesen lassen
• Action-Button: lang drücken – und Grippl schimpft sofort laut los
• Merken, kopieren und teilen – auch als Bild
• Widget „Schimpfwort des Tages“ für Home- und Sperrbildschirm
• Hell- und Dunkelmodus
• Keine Werbung, kein Konto, keine Datenerfassung

Ois nur a Gaudi – ned bös gmoant!
```

## Schlüsselwörter (max. 100 Zeichen, mit Komma, ohne Leerzeichen)

```
bayerisch,bairisch,schimpfwörter,dialekt,mundart,bayern,beleidigung,witz,lustig,grantig,oktoberfest
```

## Werbetext (optional, max. 170 Zeichen)

```
Jeden Tag a frisches Schimpfwort: Schüttl dein iPhone und lern Bairisch von seiner derbsten Seite.
```

## App-Datenschutz („Datenschutz-Etiketten“)

- Frage „Erfassen Sie Daten von dieser App?“ → **Nein, wir erfassen keine Daten.**

## Altersfreigabe (Fragebogen)

- „Obszöner oder derber Humor“: **Selten/leicht** → ergibt voraussichtlich **12+**.
- Alles andere: **Keine**.

## Exportbestimmungen (Verschlüsselung)

- Die App nutzt keine eigene Verschlüsselung → bei der Frage **„Keine der genannten Algorithmen“** wählen.

## EU-Händlerstatus (Digital Services Act)

- Als Privatperson mit kostenloser Hobby-App: **„Kein Händler“** (Kontaktdaten werden dann nicht öffentlich angezeigt).

## Hinweise für die Prüfung (App Review Notes)

```
Grippl is a humorous Bavarian dialect app. It generates playful Bavarian insults
(with Standard German translation) by tapping the button or shaking the device.
Features: male/female word forms, text-to-speech, favorites stored on-device,
sharing as text or image, and a "word of the day" widget for home and lock screen.
No account, no network access, no data collection.

Background audio: the App Shortcut "Schimpf!" (usable via Action button, Shortcuts
and Siri) generates a word and reads it aloud with AVSpeechSynthesizer without opening
the app. The audio background mode is required so this speech output is audible while
the intent runs in the background. To test: run the app once, then in the Shortcuts app
run "Schimpf!" from Grippl.
```

## Screenshots

Benötigt werden Screenshots fürs **6,9-Zoll-iPhone** (z. B. iPhone 16 Pro Max, 1320 × 2868 px).
Am einfachsten im Simulator: Xcode → *Product → Destination* „iPhone 16 Pro Max“ → App starten →
im Simulator **⌘ S** drückt einen Screenshot auf den Schreibtisch.
Vorschlag für 3–5 Bilder: Startbildschirm mit Schimpfwort, Mann/Frau-Umschalter, Favoriten-Liste,
Widget auf dem Home-Bildschirm, Teilen-Bild.
