// Service Worker: hält die App offline verfügbar.
// Bei Änderungen an den Dateien die Versionsnummer erhöhen.
const CACHE = "grippl-v1";
const DATEIEN = [
  "./",
  "./index.html",
  "./manifest.webmanifest",
  "./icons/apple-touch-icon.png",
  "./icons/icon-192.png",
  "./icons/icon-512.png",
];

self.addEventListener("install", (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(DATEIEN)));
  self.skipWaiting();
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch", (e) => {
  if (e.request.method !== "GET") return;
  e.respondWith(
    caches.match(e.request, { ignoreSearch: true }).then((treffer) => {
      if (treffer) return treffer;
      // Alles andere (z. B. die Schrift von Google Fonts) beim ersten Laden mitspeichern
      return fetch(e.request).then((antwort) => {
        if (antwort.ok || antwort.type === "opaque") {
          const kopie = antwort.clone();
          caches.open(CACHE).then((c) => c.put(e.request, kopie));
        }
        return antwort;
      }).catch(() => caches.match("./index.html"));
    })
  );
});
