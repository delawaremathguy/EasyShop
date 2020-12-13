import SwiftUI

struct Shops: Codable, Identifiable {
    var id: Int
    var name: String?
    var position: Double
    var item: [Items]
}
struct Items: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String?
    var position: Double
}

var shopsList = [
    Shops(id: 1001, name: "Bakery", position: 0.0, item: [
        Items(name: "Muffins", position: 1.0),
        Items(name: "Marshmallows", position: 2.0),
        Items(name: "Cookies", position: 3.0),
        Items(name: "Pancakes", position: 4.0),
        Items(name: "Jam", position: 5.0),
        Items(name: "Bread", position: 6.0),
        Items(name: "Biscuit", position: 7.0),
        Items(name: "Cracker", position: 8.0),
        Items(name: "Pie", position: 9.0),
        Items(name: "Tart", position: 10.0),
        Items(name: "Pastry", position: 11.0),
        Items(name: "Brownie", position: 12.0),
        Items(name: "Whipped cream", position: 13.0)
    ]), // end of shop
    Shops(id: 1002, name: "Fish Shop", position: 1.0, item: [
        Items(name: "Salmon", position: 1.0),
        Items(name: "Tuna", position: 2.0),
        Items(name: "Shrimps", position: 3.0),
        Items(name: "Prawns", position: 4.0),
        Items(name: "Sole", position: 5.0),
        Items(name: "Swordfish", position: 6.0),
        Items(name: "Cod", position: 7.0),
        Items(name: "Herring", position: 8.0),
        Items(name: "Mackerel", position: 9.0),
        Items(name: "Perch", position: 10.0),
        Items(name: "Sardines", position: 11.0),
        Items(name: "Striped Bass", position: 12.0),
        Items(name: "Octopus", position: 13.0)
    ]), // end of shop
    Shops(id: 1003, name: "Fruit Shop", position: 2.0, item: [
        Items(name: "Grapes", position: 1.0),
        Items(name: "Cherry", position: 2.0),
        Items(name: "Watermelon", position: 3.0),
        Items(name: "Banana", position: 4.0),
        Items(name: "Blueberry", position: 5.0),
        Items(name: "Açai", position: 6.0),
        Items(name: "Avocado", position: 7.0),
        Items(name: "Apricot", position: 8.0),
        Items(name: "Pear", position: 9.0),
        Items(name: "Mango", position: 10.0),
        Items(name: "Coconut", position: 11.0),
        Items(name: "Pomelo", position: 12.0),
        Items(name: "Apple", position: 13.0)
    ]), // end of shop
    Shops(id: 1001, name: "Greengrocery", position: 3.0, item: [
        Items(name: "Carrots", position: 1.0),
        Items(name: "Brocoli", position: 2.0),
        Items(name: "Asparagus", position: 3.0),
        Items(name: "Cucumber", position: 4.0),
        Items(name: "Eggplant", position: 5.0),
        Items(name: "Beets", position: 6.0),
        Items(name: "Bok Choy", position: 7.0),
        Items(name: "Ginger Root", position: 8.0),
        Items(name: "Collards", position: 9.0),
        Items(name: "Artichoke", position: 10.0),
        Items(name: "Cassava", position: 11.0),
        Items(name: "Celery", position: 12.0),
        Items(name: "Corn", position: 13.0)
    ]) // end of shop
]
