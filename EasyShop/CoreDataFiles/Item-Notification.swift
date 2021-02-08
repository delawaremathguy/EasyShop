import Foundation

extension Notification.Name {
    static let itemStatusChanged = Notification.Name(rawValue: "itemStatusChanged")
    
}

class ItemStatusChanged: ObservableObject {
    
    @objc func itemStatusChanged() {
        objectWillChange.send()
    }
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(itemStatusChanged),
                                               name: .itemStatusChanged,
                                               object: nil)
    }
}
