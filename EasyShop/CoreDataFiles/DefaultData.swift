import SwiftUI

struct Shops: Codable, Identifiable {
    var id: Int
    var name: String?
    var item: [Items]
}
struct Items: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String?
}

var shopsList = [
    Shops(id: 1001, name: "Bakery", item: [
        Items(name: "Muffins"),
        Items(name: "Marshmallows"),
        Items(name: "Cookies"),
        Items(name: "Pancakes"),
        Items(name: "Jam"),
        Items(name: "Bread"),
        Items(name: "Biscuit"),
        Items(name: "Cracker"),
        Items(name: "Pie"),
        Items(name: "Tart"),
        Items(name: "Pastry"),
        Items(name: "Brownie"),
        Items(name: "Whipped cream")
    ]), // end of shop
    Shops(id: 1002, name: "Fish Shop", item: [
        Items(name: "Salmon"),
        Items(name: "Tuna"),
        Items(name: "Shrimps"),
        Items(name: "Prawns"),
        Items(name: "Sole"),
        Items(name: "Swordfish"),
        Items(name: "Cod"),
        Items(name: "Herring"),
        Items(name: "Mackerel"),
        Items(name: "Perch"),
        Items(name: "Sardines"),
        Items(name: "Striped Bass"),
        Items(name: "Octopus")
    ]), // end of shop
    Shops(id: 1003, name: "Fruit Shop", item: [
        Items(name: "Grapes"),
        Items(name: "Cherry"),
        Items(name: "Watermelon"),
        Items(name: "Banana"),
        Items(name: "Blueberry"),
        Items(name: "Açai"),
        Items(name: "Avocado"),
        Items(name: "Apricot"),
        Items(name: "Pear"),
        Items(name: "Mango"),
        Items(name: "Coconut"),
        Items(name: "Pomelo"),
        Items(name: "Apple")
    ]), // end of shop
    Shops(id: 1001, name: "Greengrocery", item: [
        Items(name: "Carrots"),
        Items(name: "Brocoli"),
        Items(name: "Asparagus"),
        Items(name: "Cucumber"),
        Items(name: "Eggplant"),
        Items(name: "Beets"),
        Items(name: "Bok Choy"),
        Items(name: "Ginger Root"),
        Items(name: "Collards"),
        Items(name: "Artichoke"),
        Items(name: "Cassava"),
        Items(name: "Celery"),
        Items(name: "Corn")
    ]) // end of shop
]
