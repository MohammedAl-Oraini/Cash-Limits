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
    
    
    class func saveCategory(name:String,limit:Decimal,container: NSPersistentContainer?) -> Category?{
        if let container = container {
            print("is main thread ? \(Thread.isMainThread)")
            let newCategory = Category(context: container.viewContext)
            newCategory.name = name
            newCategory.limit = limit as NSDecimalNumber
            try? container.viewContext.save()
            print("new Category saved")
            return newCategory
        } else {
            print("category was not saved")
            return nil
        }
    }
    
    class func loadCategories(container: NSPersistentContainer?) -> [Category]{
        if let container = container {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                let categorys = try container.viewContext.fetch(request)
                print("Catagories loaded with :\(categorys.count) Category")
                return categorys
            } catch {
               print("error loading the Category")
            }
        }
        print("returned with an emity arry")
        return []
    }
    
    class func LoadCategoryByName(container: NSPersistentContainer?,name:String) -> Category? {
        if let container = container {
                  let request: NSFetchRequest<Category> = Category.fetchRequest()
                  do {
                      let categorys = try container.viewContext.fetch(request)
                      print("Catagories loaded with :\(categorys.count) Category")
                    for category in categorys {
                        if category.name == name {
                            return category
                        }
                    }
                  } catch {
                     print("error loading the Category")
                  }
              }
        print("category was not found")
        return nil
    }
    class func loadTotalLimits(container: NSPersistentContainer?) -> Decimal{
        if let container = container {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                let categories = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(categories.count) expense")
                var totallimits:Decimal = 0
                for category in categories {
                    totallimits += category.limit! as Decimal
                }
                return totallimits
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
        return 0
    }
    
    class func resetCategory(container: NSPersistentContainer?){
        if let container = container {
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                let categorys = try container.viewContext.fetch(request)
                print("Catagories loaded with :\(categorys.count) Category")
                for category in categorys {
                    container.viewContext.delete(category)
                }
            } catch {
               print("error loading the Category")
            }
        }
        print("returned with an emity arry")
    }

}
