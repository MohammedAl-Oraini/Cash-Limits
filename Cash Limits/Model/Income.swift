//
//  Income.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 24/11/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class Income: NSManagedObject {

    //MARK: - helper methods
    
    
    class func saveIncome(name:String,amount:Decimal,container: NSPersistentContainer?){
        if let container = container {
            print("is main thread ? \(Thread.isMainThread)")
            let newCategory = Income(context: container.viewContext)
            newCategory.name = name
            newCategory.amount = amount as NSDecimalNumber
            try? container.viewContext.save()
            print("new Income saved")
        } else {
            print("income was not saved")
        }
    }
    
    class func loadIncomes(container: NSPersistentContainer?) -> Decimal{
        if let container = container {
            let request: NSFetchRequest<Income> = Income.fetchRequest()
            do {
                let incomes = try container.viewContext.fetch(request)
                print("Incomes loaded with :\(incomes.count) incomes")
                var totalIncome:Decimal = 0
                for income in incomes {
                    totalIncome += income.amount! as Decimal
                }
                return totalIncome
            } catch {
               print("error loading the incomes")
            }
        }
        print("returned with an emity arry")
        return 0
    }
    
    class func loadIncomeArry(container: NSPersistentContainer?) -> [Income]{
        if let container = container {
            let request: NSFetchRequest<Income> = Income.fetchRequest()
            do {
                let incomes = try container.viewContext.fetch(request)
                print("Incomes loaded with :\(incomes.count) incomes")
                return incomes
            } catch {
               print("error loading the incomes")
            }
        }
        print("returned with an emity arry")
        return []
    }
}
