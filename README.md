#  Cash limits

## Description :

This app helps users from Saudi Arabia to manage thier spendings by putting limits on categories they choise and giveing them a nice over view of thier spendings over time.

The app have 4 tab views:

- Home : Here the user can add thier income and the categories they like to put limits on and add expencses to the category .
- History : Here they have a table view of thier spendings and they can order them by time or amount .
- Graphs : In this tab you can view the pie chart for the total category spending and view the second bar chart for the total spending over the last week . 
- Settings: Here you can see the exchange rate of the currencies and see the added income. 

### Home 

When the app first starts it will open this tab here you can  add your income by tapping the income button . By tapping the + button you can add a new category and set its limit , after that you can add expense to this category by tapping the add expense button.

### History 

This tab show the history of the user spendings . Each cell have three informations the amount ,the date and the category .

### Graphs 

The graphs are organised using a page view controller the firs page have the pie chart and the second page have the bar chart.  The graphs were built using [Charts](https://github.com/danielgindi/Charts). form the auther danielgindi. 

### Settings

in the manage currency page you can update the excange rate of the currencies using the refresh button. I used the [Fixer API](https://fixer.io) to get the current exchange rates.

## Set up :

this project was built using Xcode v 11 , Swift 5 and works only on iOS 13. 
you need to add a dependecy using the swift package manager , you can do that by going to the project file Cash Limits then navigate to the  swift packages then press the + button then add this link (https://github.com/danielgindi/Charts) ,make sure the version is 3.4.0  .
The API Key can be added by gonig to the model folder then network folder then then open the Client file and change it.

## Author :

[Mohammed Al-Oraini](https://github.com/MohammedAl-Oraini) .



