import WidgetKit
import SwiftUI

// MARK: - Daten

struct TagesEintrag: TimelineEntry {
    let date: Date
    let wort: Schimpfwort
}

/// Liefert das Schimpfwort des Tages und aktualisiert um Mitternacht.
struct TagesProvider: TimelineProvider {
    func placeholder(in context: Context) -> TagesEintrag {
        TagesEintrag(date: Date(), wort: Wortschatz.desTages())
    }

    func getSnapshot(in context: Context, completion: @escaping (TagesEintrag) -> Void) {
        completion(placeholder(in: context))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TagesEintrag>) -> Void) {
        let jetzt = Date()
        let kalender = Calendar.current
        let morgen = kalender.date(byAdding: .day, value: 1, to: kalender.startOfDay(for: jetzt))
            ?? jetzt.addingTimeInterval(86_400)
        let eintrag = TagesEintrag(date: jetzt, wort: Wortschatz.desTages(jetzt))
        completion(Timeline(entries: [eintrag], policy: .after(morgen)))
    }
}

// MARK: - Ansicht

struct TagesWidgetAnsicht: View {
    @Environment(\.widgetFamily) private var familie
    let eintrag: TagesEintrag

    var body: some View {
        switch familie {
        case .accessoryRectangular:
            // Sperrbildschirm
            VStack(alignment: .leading, spacing: 2) {
                Text("Schimpfwort des Tages")
                    .font(.caption2)
                    .widgetAccentable()
                Text(eintrag.wort.text)
                    .font(.headline)
                    .minimumScaleFactor(0.6)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        default:
            VStack(alignment: .leading, spacing: 6) {
                Text("Schimpfwort des Tages")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gripplBlau)
                Spacer(minLength: 0)
                Text(eintrag.wort.text)
                    .font(.system(size: familie == .systemSmall ? 22 : 30, weight: .heavy))
                    .minimumScaleFactor(0.5)
                    .lineLimit(3)
                Text("preißisch: \(eintrag.wort.uebersetzung)")
                    .font(.caption2)
                    .foregroundStyle(Color.gripplLeise)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Widget

struct GripplWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "GripplTageswort", provider: TagesProvider()) { eintrag in
            TagesWidgetAnsicht(eintrag: eintrag)
                .containerBackground(Color.gripplFlaeche, for: .widget)
        }
        .configurationDisplayName("Schimpfwort des Tages")
        .description("Jeden Tag a frisches bayerisches Schimpfwort.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])
    }
}

@main
struct GripplWidgets: WidgetBundle {
    var body: some Widget {
        GripplWidget()
    }
}
