//
//  Page1ViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 03/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import Charts
import CoreData

class Page1ViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //MARK: - IBOutlet

    @IBOutlet weak var pieChart: PieChartView!
    
    //MARK: - data source
    
    var dataEntryArry = [PieChartDataEntry]()
    var categoryCollection:[Category] = []
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.chartDescription?.text = "Pie Chart for category spendings"
        pieChart.centerText = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategories()
        loadDataEntries()
        updateChartData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataEntryArry.removeAll()
        categoryCollection.removeAll()
    }
    
    //MARK: - load funcs
    
    func loadDataEntries() {
        for category in categoryCollection {
            let spent = Expense.loadCategoryExpenses(container: container, name: category.name!) as NSNumber
            let dataEntry = PieChartDataEntry(value: Double(truncating: spent))
            dataEntry.label = category.name
            dataEntryArry.append(dataEntry)
        }
        
    }
    
    func loadCategories() {
        for category in Category.loadCategories(container:container) {
            categoryCollection.append(category)
        }
    }
    

    func updateChartData(){
        let chartDataSet = PieChartDataSet(entries: dataEntryArry, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors = colorsOfCharts(numbersOfColor: dataEntryArry.count)
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    //MARK: - helper func
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
}
