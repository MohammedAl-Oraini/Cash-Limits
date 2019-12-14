//
//  Page2ViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 03/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import Charts
import CoreData

class Page2ViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
     
     var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet weak var barChart: BarChartView!
    
    var dataEntryArry = [BarChartDataEntry]()
    var dateArray = [Date]()
    var spentArry = [Double]()
    let dateString = ["1","2","3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChart.animate(yAxisDuration: 2.0)
        barChart.pinchZoomEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawBordersEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.drawGridBackgroundEnabled = true
        barChart.chartDescription?.text = "Your Daily Spending Over The Week"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDates()
        loadSpent()
        loadDataEntries()
        setChart(dataPoints: dateString, values: spentArry)
        
    }
    
    func loadDataEntries() {
        dataEntryArry.removeAll()
         for date in dateArray {
            let spent = Expense.loadTotalExpensesOnDate(container: container, date: date) as NSNumber
            let dataEntry = BarChartDataEntry(x: Double(exactly: spent)!, yValues: spentArry, data: date)
             dataEntryArry.append(dataEntry)
         }

     }
    
    func loadDates() {
        dateArray.removeAll()
        // get the current calendar
        let calendar = NSCalendar.current
        // get the start of the day of the selected date
        let startDate = calendar.startOfDay(for: Date())
        // get the start of the day after the selected date
        for i in 0..<7 {
          let endDate = calendar.date(byAdding: .day, value: -i, to: startDate)!
            dateArray.append(endDate)
        }
        
    }
    
    func loadSpent() {
        spentArry.removeAll()
        for date in dateArray {
            let spent = Expense.loadTotalExpensesOnDate(container: container, date: date) as NSNumber
            spentArry.append(Double(exactly: spent)!)
        }
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
       barChart.noDataText = "You need to provide data for the chart."
       
       var dataEntries: [BarChartDataEntry] = []
       
       for i in 0..<dataPoints.count {
         let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
         dataEntries.append(dataEntry)
         }
         
         let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Spent")
         let chartData = BarChartData(dataSet: chartDataSet)
         barChart.data = chartData
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
