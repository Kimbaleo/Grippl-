import SwiftUI
import UIKit

extension Notification.Name {
    static let geschuettelt = Notification.Name("grippl.geschuettelt")
}

/// Fängt die Schüttel-Geste des iPhones ab und meldet sie weiter.
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .geschuettelt, object: nil)
        }
    }
}

private struct BeiSchuetteln: ViewModifier {
    let aktion: () -> Void

    func body(content: Content) -> some View {
        content.onReceive(NotificationCenter.default.publisher(for: .geschuettelt)) { _ in
            aktion()
        }
    }
}

extension View {
    /// Führt `aktion` aus, wenn das iPhone geschüttelt wird.
    func beiSchuetteln(_ aktion: @escaping () -> Void) -> some View {
        modifier(BeiSchuetteln(aktion: aktion))
    }
}
