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
    
    //MARK: - helper methods

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
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
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
    
    class func loadExpensesWithAmountSort(container: NSPersistentContainer?) -> [Expense]{
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            let sort = NSSortDescriptor(key: "amount", ascending: false)
            request.sortDescriptors = [sort]
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
    
    class func loadCategoryExpenses(container: NSPersistentContainer?,name:String) -> Decimal{
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            let category = Category.LoadCategoryByName(container: container, name: name)
            let predicate = NSPredicate(format: "expenceCategory == %@", category!)
            request.predicate = predicate
            do {
                let expenses = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(expenses.count) expenses")
                var spent:Decimal = 0
                for expense in expenses {
                    spent += expense.amount! as Decimal
                }
                return spent
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
        return 0
    }
    class func loadTotalExpenses(container: NSPersistentContainer?) -> Decimal{
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            do {
                let expenses = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(expenses.count) expense")
                var totalExpenses:Decimal = 0
                for expense in expenses {
                    totalExpenses += expense.amount! as Decimal
                }
                return totalExpenses
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
        return 0
    }
    
    class func loadTotalExpensesOnDate(container: NSPersistentContainer?,date: Date) -> Decimal{
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            // get the current calendar
            let calendar = NSCalendar.current
            // get the start of the day of the selected date
            let startDate = calendar.startOfDay(for: date)
            // get the start of the day after the selected date
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
            // create a predicate to filter between start date and end date
            let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate! as NSDate)
            request.predicate = predicate
            do {
                let expenses = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(expenses.count) expense")
                var totalExpenses:Decimal = 0
                for expense in expenses {
                    totalExpenses += expense.amount! as Decimal
                }
                return totalExpenses
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
        return 0
    }
    
    class func resetExpense(container: NSPersistentContainer?){
        if let container = container {
            let request: NSFetchRequest<Expense> = Expense.fetchRequest()
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            do {
                let expenses = try container.viewContext.fetch(request)
                print("Expenses loaded with :\(expenses.count) expenses")
                for expense in expenses {
                    container.viewContext.delete(expense)
                }
            } catch {
               print("error loading the expenses")
            }
        }
        print("returned with an emity arry")
    }
    
}
