# Grippl 🥨

Da bayerische Schimpfwort-Generator: auf **„Schimpf!“** drücken –
und scho kriagt ma a zünftigs bayerisches Schimpfwort (z. B. *greislicha
Gschaftlhuaba*), samt preißischer Übersetzung.

## Starten

Einfach `index.html` im Browser öffnen. Keine Installation, kein Build.

## Als App aufs iPhone

Grippl is a Web-App (PWA): Auf'm Home-Bildschirm schaut's aus und funktioniert
wia a richtige App – eigenes Icon, Vollbild, geht a ohne Netz.

1. **Online stellen** (einmalig), z. B. mit GitHub Pages:
   Repository → *Settings* → *Pages* → *Build and deployment* →
   Source „Deploy from a branch“, Branch auswählen, Ordner `/ (root)`, *Save*.
   Nach a paar Minuten is die App unter `https://<benutzer>.github.io/<repo>/`
   erreichbar. (Bei privaten Repositories braucht GitHub Pages an kostenpflichtigen Plan –
   alternativ geht jeder andere statische Hoster, z. B. Netlify.)
2. Die Adresse am iPhone in **Safari** öffnen.
3. Unten auf **Teilen** (Quadrat mit Pfeil) tippen → **„Zum Home-Bildschirm“** → *Hinzufügen*.

Danach startet Grippl über's Icon im Vollbild. Nach'm ersten Start funktioniert's
a offline. In der App gibt's zusätzlich an **Teilen**-Knopf (WhatsApp, Nachrichten …).

Dateien dafür: `manifest.webmanifest` (App-Name, Farben, Icons), `sw.js`
(Offline-Speicher – bei Änderungen die Versionsnummer `grippl-v1` erhöhen),
`icons/` (App-Icons).

## Wia's geht

- Adjektiv-Stamm + Hauptwort werden zufällig kombiniert, die Endung passt
  sich ans Geschlecht an (*damischa Depp*, *damische Funsn*, *damischs Rindviech*).
- Per Schieberegler wählt ma vorher, ob's für an **Mann** oder a **Frau** sei soi.
  Sächliche Wörter (*Rindviech*, *Gscheidhaferl* …) passen für beide.
- Ausgegeben wird nur der Ausdruck selbst, ohne ganzen Satz.
- Schlichtes, modernes Design mit Dunkelmodus.
- „Kopiern“ legt den Ausdruck in die Zwischenablage.

## Echte iPhone-App (Ordner `ios/`)

Im Ordner `ios/` liegt Grippl als native iPhone-App (Swift/SwiftUI) mit Extras:
Schütteln für a neues Wort, Querformat-Vollbild (iPhone drehen → nur des Schimpfwort, riesig), Vorlesen, Merken (Favoriten), Teilen als Text oder Bild,
Haptik und a Widget „Schimpfwort des Tages“ für Home- und Sperrbildschirm.

**Voraussetzungen:** Mac mit **Xcode 16 oder neuer** (kostenlos im Mac App Store), iPhone mit **iOS 17 oder neuer**.

### Aufs eigene iPhone (kostenlos)

1. Repository auf den Mac holen: in GitHub auf **Code → Download ZIP** und entpacken
   (oder `git clone https://github.com/Kimbaleo/Grippl-.git`).
2. `ios/Grippl.xcodeproj` per Doppelklick in Xcode öffnen.
3. Xcode → **Settings → Accounts** → **+** → mit der eigenen **Apple-ID** anmelden.
4. Links im Projekt auf **Grippl** (blaues Symbol) klicken → Reiter **Signing & Capabilities**:
   - Target **Grippl**: bei *Team* das eigene Team („Persönliches Team“) wählen.
   - Target **GripplWidgetExtension**: ebenso das Team wählen.
   - Meldet Xcode, die Bundle-ID sei vergeben: bei beiden Targets `de.kimbaleo` durch
     etwas Eigenes ersetzen (z. B. `de.deinname`) – das Widget muss mit der App-ID beginnen
     (`….grippl` und `….grippl.widget`).
5. iPhone per Kabel anschließen, entsperren, „Diesem Computer vertrauen“ bestätigen.
6. Am iPhone **Einstellungen → Datenschutz & Sicherheit → Entwicklermodus** einschalten
   (Neustart nötig).
7. In Xcode oben das iPhone als Ziel wählen und **▶︎ (⌘ R)** drücken.
8. Beim ersten Start am iPhone: **Einstellungen → Allgemein → VPN & Geräteverwaltung** →
   Entwickler-App vertrauen.

Mit kostenlosem Konto läuft die App **7 Tage**, danach einfach erneut mit ▶︎ aufspielen.

### Action-Button belegen (ab iPhone 15 Pro)

Lang drücken → sofort a Schimpfwort, laut vorgelesen, ohne dass die App aufgeht.

1. Grippl **einmal öffnen** (dann kennt das iPhone die Aktion).
2. **Einstellungen → Action-Taste** → seitlich wischen bis **„Kurzbefehl“**.
3. **„Kurzbefehl auswählen“** → unter den Apps **Grippl** → **„Schimpf!“**.

Es gilt die in der App eingestellte Auswahl **Mann/Frau**. Die gleiche Aktion gibt's
auch in der Kurzbefehle-App, in Spotlight und per Siri („Schimpf mit Grippl“).

### Im App Store veröffentlichen

1. Beim **Apple Developer Program** anmelden (99 €/Jahr): developer.apple.com/programs
2. In Xcode bei beiden Targets das bezahlte Team wählen.
3. In **App Store Connect** eine neue App mit derselben Bundle-ID anlegen.
4. `datenschutz.html` ergänzen (Name, E-Mail) und über GitHub Pages veröffentlichen.
5. Xcode: Ziel **Any iOS Device** → **Product → Archive** → **Distribute App** → *App Store Connect*.
6. In App Store Connect Texte, Screenshots, Datenschutz-Angaben ausfüllen und
   **Zur Prüfung einreichen**. Vorlagen dafür stehen in [`ios/APPSTORE.md`](ios/APPSTORE.md).

Ois nur a Gaudi – ned bös gmoant!
