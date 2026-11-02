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

Ois nur a Gaudi – ned bös gmoant!
