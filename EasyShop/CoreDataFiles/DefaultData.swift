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

//var shopsList = [
//    Shops(id: 1001, name: "Bakery", position: 0, item: [
//        Items(name: "Muffins", position: 1),
//        Items(name: "Marshmallows", position: 2),
//        Items(name: "Cookies", position: 3),
//        Items(name: "Pancakes", position: 4),
//        Items(name: "Jam", position: 5),
//        Items(name: "Bread", position: 6),
//        Items(name: "Biscuit", position: 7),
//        Items(name: "Cracker", position: 8),
//        Items(name: "Pie", position: 9),
//        Items(name: "Tart", position: 10),
//        Items(name: "Pastry", position: 11),
//        Items(name: "Brownie", position: 12),
//        Items(name: "Whipped cream", position: 13)
//    ]), // end of shop
//    Shops(id: 1002, name: "Fish Shop", position: 1, item: [
//        Items(name: "Salmon", position: 1),
//        Items(name: "Tuna", position: 2),
//        Items(name: "Shrimps", position: 3),
//        Items(name: "Prawns", position: 4),
//        Items(name: "Sole", position: 5),
//        Items(name: "Swordfish", position: 6),
//        Items(name: "Cod", position: 7),
//        Items(name: "Herring", position: 8),
//        Items(name: "Mackerel", position: 9),
//        Items(name: "Perch", position: 10),
//        Items(name: "Sardines", position: 11),
//        Items(name: "Striped Bass", position: 12),
//        Items(name: "Octopus", position: 13)
//    ]), // end of shop
//    Shops(id: 1003, name: "Fruit Shop", position: 2, item: [
//        Items(name: "Grapes", position: 1),
//        Items(name: "Cherry", position: 2),
//        Items(name: "Watermelon", position: 3),
//        Items(name: "Banana", position: 4),
//        Items(name: "Blueberry", position: 5),
//        Items(name: "Açai", position: 6),
//        Items(name: "Avocado", position: 7),
//        Items(name: "Apricot", position: 8),
//        Items(name: "Pear", position: 9),
//        Items(name: "Mango", position: 10),
//        Items(name: "Coconut", position: 11),
//        Items(name: "Pomelo", position: 12),
//        Items(name: "Apple", position: 13)
//    ]), // end of shop
//    Shops(id: 1004, name: "Greengrocery", position: 3, item: [
//        Items(name: "Carrots", position: 1),
//        Items(name: "Brocoli", position: 2),
//        Items(name: "Asparagus", position: 3),
//        Items(name: "Cucumber", position: 4),
//        Items(name: "Eggplant", position: 5),
//        Items(name: "Beets", position: 6),
//        Items(name: "Bok Choy", position: 7),
//        Items(name: "Ginger Root", position: 8),
//        Items(name: "Collards", position: 9),
//        Items(name: "Artichoke", position: 10),
//        Items(name: "Cassava", position: 11),
//        Items(name: "Celery", position: 12),
//        Items(name: "Corn", position: 13)
//    ]), // end of shop
//    Shops(id: 1005, name: "BookShop", position: 4, item: [
//        Items(name: "Permanent Record", position: 1),
//        Items(name: "Steve Jobs", position: 2),
//        Items(name: "Hacker, Hoaxer, Whistleblower, Spy: The Many Faces of Anonymous", position: 3),
//        Items(name: "Elon Musk and the Quest for a Fantastic Future Young ", position: 4),
//        Items(name: "My lost brothers", position: 5),
//        Items(name: "The Lost Child of Philomena Lee", position: 6)
//    ]),
//    Shops(id: 1006, name: "MusicShop", position: 5, item: [
//        Items(name: "Thriller", position: 1),
//        Items(name: "A night at the Opera", position: 2),
//        Items(name: "Crossroads", position: 3),
//        Items(name: "So far so good", position: 4),
//        Items(name: "Dangerous", position: 5),
//        Items(name: "Tragic Kingdom", position: 6)
//    ]),
//    Shops(id: 1007, name: "VideoGame", position: 6, item: [
//        Items(name: "The last of us", position: 1),
//        Items(name: "Super Mario Bross", position: 2),
//        Items(name: "The Legend of Zelda", position: 3),
//        Items(name: "Call of duty", position: 4),
//        Items(name: "Fifa", position: 5),
//        Items(name: "Commandos", position: 6)
//    ]),
//    Shops(id: 1008, name: "MovieShop", position: 7, item: [
//        Items(name: "Interstellar", position: 1),
//        Items(name: "Inception", position: 2),
//        Items(name: "Zero Dark Thirty", position: 3),
//        Items(name: "Tenet", position: 4),
//        Items(name: "The Matrix", position: 5),
//        Items(name: "The big short", position: 6)
//    ]),
//    Shops(id: 1009, name: "TVShowsShop", position: 8, item: [
//        Items(name: "Lost", position: 1),
//        Items(name: "This is Us", position: 2),
//        Items(name: "The Walking dead", position: 3),
//        Items(name: "Two and a half men", position: 4),
//        Items(name: "The Wire", position: 5),
//        Items(name: "True Detective", position: 6)
//    ]),
//    Shops(id: 1010, name: "PetShop", position: 9, item: [
//        Items(name: "Leash", position: 1),
//        Items(name: "Necklaces", position: 2),
//        Items(name: "Straps", position: 3),
//        Items(name: "Beds", position: 4),
//        Items(name: "Treats", position: 5),
//        Items(name: "Crate", position: 6)
//    ]),
//    Shops(id: 1011, name: "Supermarket", position: 10, item: [
//        Items(name: "Soap", position: 1),
//        Items(name: "Shampoo", position: 2),
//        Items(name: "Broom", position: 3),
//        Items(name: "Mop", position: 4),
//        Items(name: "Towel", position: 5),
//        Items(name: "Napkin", position: 6)
//    ])
//]

// Mercadona

var shopsList = [
    Shops(id: 1001, name: "Fruta y Verdura", position: 0, item: [
        Items(name: "Lechuga", position: 1),
        Items(name: "Tomate", position: 2),
        Items(name: "Cebolla", position: 3),
        Items(name: "Ajo", position: 4),
        Items(name: "Berenjenas", position: 5),
        Items(name: "Calabacin", position: 6),
        Items(name: "Patatas", position: 7),
        Items(name: "Bonitato", position: 8),
        Items(name: "Calabaza", position: 9),
        Items(name: "Zanahoria", position: 10),
        
        Items(name: "Manzana", position: 11),
        Items(name: "Naranja", position: 12),
        Items(name: "Mandarina", position: 13),
        Items(name: "Kiwi", position: 14),
        Items(name: "Uva", position: 15),
        Items(name: "Aguacate", position: 16),
        Items(name: "Limon", position: 17),
        Items(name: "Platano", position: 18),
        Items(name: "Melon", position: 19),
        Items(name: "Sandia", position: 20)
    ]),
    
    Shops(id: 1002, name: "Limpieza", position: 1, item: [
        Items(name: "Guantes plastico", position: 1),
        Items(name: "Sanitol", position: 2),
        Items(name: "Lejia", position: 3),
        Items(name: "Bolsas basura", position: 4),
        Items(name: "Limpiador WC", position: 5),
        Items(name: "Detergente platos", position: 6),
        Items(name: "Detergente ropa", position: 7),
        Items(name: "Suavizante ropa", position: 8),
        Items(name: "Blanqueador camisas", position: 9),
        Items(name: "Papel higienico", position: 10),
        Items(name: "Toallitas perros", position: 11)
    ]),
    
    Shops(id: 1003, name: "Picar", position: 2, item: [
        Items(name: "Nachos", position: 1),
        Items(name: "Cheddar nachos", position: 2),
        Items(name: "Patatas fritas", position: 3),
        Items(name: "Queso curado", position: 4),
        Items(name: "Fuet", position: 5),
        Items(name: "Hummus", position: 6),
        Items(name: "Olivas", position: 7),
        Items(name: "Popcorn", position: 8),
        Items(name: "Guacamole", position: 9),
        Items(name: "Tortillas Mexicanas", position: 10),
        Items(name: "Triangulos Verdes", position: 11),
        Items(name: "Nueces", position: 12),
        Items(name: "Pistachos", position: 13),
        Items(name: "Frutos secos mix", position: 14),
        Items(name: "Cacahuetes", position: 15)
    ]),
    
    Shops(id: 1004, name: "Bebida", position: 3, item: [
        Items(name: "Agua 8L", position: 1),
        Items(name: "Coca Zero", position: 2),
        Items(name: "Cerveza", position: 3),
        Items(name: "Cava", position: 4),
        Items(name: "JackDaniels Honey", position: 5),
        Items(name: "Monster", position: 6),
        Items(name: "Te", position: 7),
        Items(name: "Cafe", position: 8),
        Items(name: "Leche Cat", position: 9),
        Items(name: "Leche Fede", position: 10)
    ]),
    
    Shops(id: 1005, name: "Dulces", position: 4, item: [
        Items(name: "Natillas choco", position: 1),
        Items(name: "Nutella", position: 2),
        Items(name: "Nocilla", position: 3),
        Items(name: "Circulos choco", position: 4),
        Items(name: "Tableta choco", position: 5),
        Items(name: "Culan", position: 6)
    ]),
    
    Shops(id: 1006, name: "Resto", position: 5, item: [
        Items(name: "Huevos", position: 1),
        Items(name: "Pollo", position: 2),
        Items(name: "Cereales", position: 3),
        Items(name: "Tortilla", position: 4),
        Items(name: "Pizza", position: 5),
        Items(name: "Pan cereal", position: 6),
        Items(name: "Pan centeno", position: 7),
        Items(name: "Tomate Lata", position: 8),
        Items(name: "Garbanzos", position: 9),
        Items(name: "Lentejas", position: 10),
        Items(name: "Arroz", position: 11),
        Items(name: "Atun lata", position: 12),
        Items(name: "Galletas Espelta", position: 13),
        Items(name: "Queso fresco", position: 14),
        Items(name: "Pavo Lonchas", position: 15),
        Items(name: "Queso Lonchas", position: 16),
        Items(name: "Maiz", position: 17),
        Items(name: "Mozzarella", position: 18),
        Items(name: "Pan rallado", position: 19),
        Items(name: "Pasta", position: 20),
        Items(name: "Salchichas", position: 21),
        Items(name: "Carne picada", position: 22),
        Items(name: "Tomate frito", position: 23)
    ]),
    
    Shops(id: 1007, name: "Condimentos", position: 6, item: [
        Items(name: "Aceite Oliva", position: 1),
        Items(name: "Aceite Girasol", position: 2),
        Items(name: "Vinagre", position: 3),
        Items(name: "Salsa Soja", position: 4),
        Items(name: "Salsa Teriyaki", position: 5),
        Items(name: "Ketchup", position: 6),
        Items(name: "Mostaza", position: 7),
        Items(name: "Mayonesa", position: 8),
        Items(name: "BBQ", position: 9),
        Items(name: "Sal", position: 10)
    
    ])
]


