//  Jerry'sHint.swift
//  EasyShop
//  Created on 15/11/20.
/*
 1. DRAWING A LINE
 on the “drawing a line” idea, it would be easy to section out the items in a list to include “those in the cart,” so let me know if you want to go in that direction.
 
 2. CLASS NEWSHOP - Done, just missing .order
 my belief is that when you want to create new objects or delete existing objects, let the Core Data class do it for you (rather than have to pass around the managedObjectContext all over the place so some View can do it).  also, if you modify a Core Data object in any way that affects other CD objects (like changing “select” on an Item and having to update “select” on a Shop), do that through a method defined in the class.

 you might want to add similar functionality to the Shop class.
 
 3. DEFAULT DATA - DATA MODEL?
 When I’m developing an app that only exists on the simulator and doesn’t have much real data, I can change the data model; remove the app from the simulator; and then restart (with the new model and no existing data).

 Once I move the app to a device or start to develop a lot of data, I use the ShoppingList strategy: find a way to dump the data that’s been created in json format, or even email it to myself from a device.  Then, I can use that data to seed any new Core Data model change at startup (with not many code changes).

 Once the app gets out, however, making changes to the data model is handled by versioning the Core Data model.  I’ve done that before, and would do it in ShoppingList if I do go back to it and add a new Date field (some people may be using it; I’d hate to lose any data they have created).

 Basically, Core Data will migrate an existing data model to a new one, and it’s essentially free when it involves a simple addition, deletion, or renaming of an attribute.  There’s almost nothing to do other than to say “this is version 2 of my data model,” and the data will be migrated for you when the app starts up.
 ----
 Once I move the app to a device or start to develop a lot of data, I use the ShoppingList strategy: find a way to dump the data that’s been created in json format, or even email it to myself from a device.  Then, I can use that data to seed any new Core Data model change at startup (with not many code changes).
 ShoppingList has this capability already, although it does not do anything with the SQL files directly.  it can offload its Core Data database to JSON files and then, using those, repopulate the database from those JSON files.  you just need a way to go from a Core Data entity to a JSON struct and back, and then a mechanism to offload those files (either simply to the console window or via email).
 ---
 for one app i have now just about finished, i offload all the Core Data entities using JSON proxy records, basically writing all entities of each type to a single file.  for example, in ShoppingList, there are two entities, so two files get written (all the ShoppingItems and all the Locations).  relationships are easy to write out when everything has a id: UUID attribute — just write the id of what’s referenced in a Core Data entity.

 also in my current app, there are some entities that have attributes which are data (compressed jpeg data), so i write those out as separate files, naming them using the id of the entity they belong to; that makes it easy to reload later.

 if i want to use all this output as seed data in the future, i simply copy it into the app bundle (i.e., include in the Xcode project) and then write code to open up all the files and put everything back together again.  nothing need be done here with an asset catalog.

 
 */
