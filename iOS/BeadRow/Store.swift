import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [BeadType] = []
    @Published var isPro: Bool = false

    static let freeLimit = 8

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("beadrow_items.json")
    }()

    init() {
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: BeadType) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: BeadType) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: BeadType) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([BeadType].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static let seedData: [BeadType] = [
        BeadType(colorName: "Colorname 1", size: "Size 1", finish: "Finish 1", quantity: 10.0, notes: "Notes 1"),
        BeadType(colorName: "Colorname 2", size: "Size 2", finish: "Finish 2", quantity: 20.0, notes: "Notes 2"),
        BeadType(colorName: "Colorname 3", size: "Size 3", finish: "Finish 3", quantity: 30.0, notes: "Notes 3")
    ]
}
