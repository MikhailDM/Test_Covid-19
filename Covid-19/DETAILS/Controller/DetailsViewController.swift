//
//  DetailsViewController.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 15.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
//MARK: - LINKS    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

//MARK: - OBJECTS
    var currentInfManager = DetailsNetworkManager.shared
    
  
//MARK: - VARIABLES
    var country = Country(fullName: "", iso2: "")
    var timeTable = [CurrentCModel]()
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Назначаем имя страны
        countryNameLabel.text = country.fullName
        //Назначаем себя делегатом менеджера получения всей информации
        currentInfManager.delegate = self
        //Test
        currentInfManager.fetchAllInf(url: country.url)        
    }
    
    
    
//MARK: - FUNCTIONS
   

    
}



//MARK: - EXTENSION. TOTALINFORMATION DELEGATE
extension DetailsViewController: DetailsNetworkManagerDelegate {
    //Обновление информации при загрузке данных
    func didUpdateInformation(_ detailsInfManager: DetailsNetworkManager, information: [CurrentCModel]) {
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузки перед показом view
        DispatchQueue.main.async {
            self.timeTable = information
            self.dateSorting()
            //self.timeTable = self.timeTable.sorted { ($1.date ).localizedCaseInsensitiveCompare($0.date ) == .orderedDescending}
            self.tableView.reloadData()
        }
    }
    //Ошибка сети
    func didFailWithError(error: Error) {
        print(error)
    }
    
    //Метод форматирования списка моделей
    private func dateSorting() {
        let df = DateFormatter()
        df.dateFormat = "M/d/yy"
        timeTable = timeTable.sorted {df.date(from: $0.date)! > df.date(from: $1.date)!}
    }
}



// MARK: - UITABLEVIEWDATASOURSE
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsTableViewCell
        
        cell.dayLabel.text = timeTable[indexPath.row].date
        cell.confirmedLabel.text = String(timeTable[indexPath.row].confirmedNum)
        cell.deathsLabel.text = String(timeTable[indexPath.row].deathsNum)
        cell.recoveredLabel.text = String(timeTable[indexPath.row].recoveredNum)
        return cell
    }
}
