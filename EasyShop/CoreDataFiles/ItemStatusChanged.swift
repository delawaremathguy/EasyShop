import Foundation

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
