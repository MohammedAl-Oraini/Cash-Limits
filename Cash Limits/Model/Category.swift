//
//  Category.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 12/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class Category: NSManagedObject {
    
    //MARK: - helper methods
    
    
    class func saveCategory(name:String,limit:Decimal,container: NSPersistentContainer?){
        if let container = container {
            print("is main thread ? \(Thread.isMainThread)")
            let newCategory = Category(context: container.viewContext)
            newCategory.name = name
            newCategory.limit = limit as NSDecimalNumber
            try? container.viewContext.save()
            print("new Category saved")
        } else {
            print("category was not saved")
        }
        
    }
    
    class func loadCategories(container: NSPersistentContainer?) -> [Category]{
        if let container = container {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                let Category = try container.viewContext.fetch(request)
                print("Catagories loaded with :\(Category.count) Category")
                return Category
            } catch {
               print("error loading the Category")
            }
        }
        print("returned with an emity arry")
        return []
    }

}
