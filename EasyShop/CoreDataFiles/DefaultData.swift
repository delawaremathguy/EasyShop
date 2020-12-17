import SwiftUI

struct Shops: Codable, Identifiable {
    var id: Int
    var name: String?
    var position: Int32
    var item: [Items]
}
struct Items: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String?
    var position: Int32
}

var shopsList = [
    Shops(id: 1001, name: "Bakery", position: 0, item: [
        Items(name: "Muffins", position: 1),
        Items(name: "Marshmallows", position: 2),
        Items(name: "Cookies", position: 3),
        Items(name: "Pancakes", position: 4),
        Items(name: "Jam", position: 5),
        Items(name: "Bread", position: 6),
        Items(name: "Biscuit", position: 7),
        Items(name: "Cracker", position: 8),
        Items(name: "Pie", position: 9),
        Items(name: "Tart", position: 10),
        Items(name: "Pastry", position: 11),
        Items(name: "Brownie", position: 12),
        Items(name: "Whipped cream", position: 13)
    ]), // end of shop
    Shops(id: 1002, name: "Fish Shop", position: 1, item: [
        Items(name: "Salmon", position: 1),
        Items(name: "Tuna", position: 2),
        Items(name: "Shrimps", position: 3),
        Items(name: "Prawns", position: 4),
        Items(name: "Sole", position: 5),
        Items(name: "Swordfish", position: 6),
        Items(name: "Cod", position: 7),
        Items(name: "Herring", position: 8),
        Items(name: "Mackerel", position: 9),
        Items(name: "Perch", position: 10),
        Items(name: "Sardines", position: 11),
        Items(name: "Striped Bass", position: 12),
        Items(name: "Octopus", position: 13)
    ]), // end of shop
    Shops(id: 1003, name: "Fruit Shop", position: 2, item: [
        Items(name: "Grapes", position: 1),
        Items(name: "Cherry", position: 2),
        Items(name: "Watermelon", position: 3),
        Items(name: "Banana", position: 4),
        Items(name: "Blueberry", position: 5),
        Items(name: "Açai", position: 6),
        Items(name: "Avocado", position: 7),
        Items(name: "Apricot", position: 8),
        Items(name: "Pear", position: 9),
        Items(name: "Mango", position: 10),
        Items(name: "Coconut", position: 11),
        Items(name: "Pomelo", position: 12),
        Items(name: "Apple", position: 13)
    ]), // end of shop
    Shops(id: 1004, name: "Greengrocery", position: 3, item: [
        Items(name: "Carrots", position: 1),
        Items(name: "Brocoli", position: 2),
        Items(name: "Asparagus", position: 3),
        Items(name: "Cucumber", position: 4),
        Items(name: "Eggplant", position: 5),
        Items(name: "Beets", position: 6),
        Items(name: "Bok Choy", position: 7),
        Items(name: "Ginger Root", position: 8),
        Items(name: "Collards", position: 9),
        Items(name: "Artichoke", position: 10),
        Items(name: "Cassava", position: 11),
        Items(name: "Celery", position: 12),
        Items(name: "Corn", position: 13)
    ]), // end of shop
    Shops(id: 1005, name: "BookShop", position: 4, item: [
        Items(name: "Permanent Record", position: 1),
        Items(name: "Steve Jobs", position: 2),
        Items(name: "Hacker, Hoaxer, Whistleblower, Spy: The Many Faces of Anonymous", position: 3),
        Items(name: "Elon Musk and the Quest for a Fantastic Future Young ", position: 4),
        Items(name: "My lost brothers", position: 5),
        Items(name: "The Lost Child of Philomena Lee", position: 6)
    ]),
    Shops(id: 1006, name: "MusicShop", position: 5, item: [
        Items(name: "Thriller", position: 1),
        Items(name: "A night at the Opera", position: 2),
        Items(name: "Crossroads", position: 3),
        Items(name: "So far so good", position: 4),
        Items(name: "Dangerous", position: 5),
        Items(name: "Tragic Kingdom", position: 6)
    ]),
    Shops(id: 1007, name: "VideoGame", position: 6, item: [
        Items(name: "The last of us", position: 1),
        Items(name: "Super Mario Bross", position: 2),
        Items(name: "The Legend of Zelda", position: 3),
        Items(name: "Call of duty", position: 4),
        Items(name: "Fifa", position: 5),
        Items(name: "Commandos", position: 6)
    ]),
    Shops(id: 1008, name: "MovieShop", position: 7, item: [
        Items(name: "Interstellar", position: 1),
        Items(name: "Inception", position: 2),
        Items(name: "Zero Dark Thirty", position: 3),
        Items(name: "Tenet", position: 4),
        Items(name: "The Matrix", position: 5),
        Items(name: "The big short", position: 6)
    ]),
    Shops(id: 1009, name: "TVShowsShop", position: 8, item: [
        Items(name: "Lost", position: 1),
        Items(name: "This is Us", position: 2),
        Items(name: "The Walking dead", position: 3),
        Items(name: "Two and a half men", position: 4),
        Items(name: "The Wire", position: 5),
        Items(name: "True Detective", position: 6)
    ]),
    Shops(id: 1010, name: "PetShop", position: 9, item: [
        Items(name: "Leash", position: 1),
        Items(name: "Necklaces", position: 2),
        Items(name: "Straps", position: 3),
        Items(name: "Beds", position: 4),
        Items(name: "Treats", position: 5),
        Items(name: "Crate", position: 6)
    ]),
    Shops(id: 1011, name: "Supermarket", position: 10, item: [
        Items(name: "Soap", position: 1),
        Items(name: "Shampoo", position: 2),
        Items(name: "Broom", position: 3),
        Items(name: "Mop", position: 4),
        Items(name: "Towel", position: 5),
        Items(name: "Napkin", position: 6)
    ])
]
