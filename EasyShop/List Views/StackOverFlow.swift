/*
 import CoreData

 class SelectionHandler {

     func clearSelection(in context: NSManagedObjectContext) {
         for item in currentSelected(in: context) {
             item.isSelected = false
         }
     }

     func selectProduct(_ product: Product) {
         guard let context = product.managedObjectContext else {
             assertionFailure("broken !")
             return
         }

         clearSelection(in: context)
         product.isSelected = true
     }

     func currentSelected(in context: NSManagedObjectContext) -> [Product] {
         let request = NSFetchRequest<Product>(entityName: Product.entity().name!)
         let predicate = NSPredicate(format: "isSelected == YES")
         request.predicate = predicate

         do {
             let result = try context.fetch(request)
             return result
         } catch  {
             print("fetch error =",error)
             return []
         }

     }

 }
 ------------------
 which you can then use to select your desired product.

 SelectionHandler().selectProduct(product)

 As it stands your NavigationLink will do nothing because
 the parent list is not held in a NavigationView so you'll
 need to change the body of ViewList to look like this.
 -----------------
 var body: some View {
     NavigationView {
         VStack {
             HStack {
                 TextField("Create product with name", text: $newName)
                 Button(action: {
                     self.add()
                     self.newName = ""
                 })
                 { Image(systemName: "plus") }
             }
             .padding()
             List {
                 ForEach(list, id: \.self) { product in
                     ViewItem(product: product)
                 }
             }
         }
     }
 }
 --------------
 and in ViewItem , Product should be an ObservedObject
 so that changes are detected in the managedObject.
 -------------
 struct ViewItem: View {

     @ObservedObject var product: Product
     @State var refresh: Bool = false

     var checkmarkImage: some View {
         return Group {
             if self.product.isSelected {
                 Image(systemName: "checkmark")
             } else {
                 Image(systemName: "checkmark").colorInvert()
             }
         }
     }

     var body: some View {
         NavigationLink(destination: ViewDetail(product: product, refresh: $refresh)) {
             HStack {
                 checkmarkImage
                 Text(product.name ?? "wat")
             }
         }
     }
 }
 ------------
 The original Button won't play with the NavigationLink
 but you can simply apply the selection to onAppear in ViewDetail
 -----------
 struct ViewDetail: View {

     @ObservedObject var product: Product
     @Binding var refresh: Bool

     var body: some View {
         VStack {
             Text("Hello, World!")
             Text("Product is \(product.name ?? "wat")")
         }
         .onAppear {
             SelectionHandler().selectProduct(self.product)
         }
     }
 }
 */
