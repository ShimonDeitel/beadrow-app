import Foundation

struct BeadType: Identifiable, Codable, Equatable {
    let id: UUID
    var createdAt: Date
    var colorName: String
    var size: String
    var finish: String
    var quantity: Double
    var notes: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        colorName: String = "",
        size: String = "",
        finish: String = "",
        quantity: Double = 0,
        notes: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.colorName = colorName
        self.size = size
        self.finish = finish
        self.quantity = quantity
        self.notes = notes
    }
}
