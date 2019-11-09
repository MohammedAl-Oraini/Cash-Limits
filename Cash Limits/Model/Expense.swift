//
//  Expense.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 04/11/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class Expense: NSManagedObject {

    class func addExpense(container: NSPersistentContainer?,name:String,amount:Decimal) {
        if let container = container {
                 print("is main thread ? \(Thread.isMainThread)")
            let newExpense = Expense(context: container.viewContext)
            newExpense.amount = amount as NSDecimalNumber
            newExpense.date = Date()
            newExpense.expenceCategory = Category.LoadCategoryByName(container: container, name: name)
                 try? container.viewContext.save()
                 print("new Expense saved")
             } else {
                 print("Expense was not saved")
             }
    }
    
    class func loadExpenses(container: NSPersistentContainer?) -> [Expense]{
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            do {
                let expenses = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(expenses.count) expenses")
                return expenses
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
        return []
    }
    
}
