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
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var recoveredProgressView: UIProgressView!
    @IBOutlet weak var deathsProgressView: UIProgressView!
    @IBOutlet weak var totalProgressView: UIProgressView!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    
    
//MARK: - OBJECTS
    var currentInfManager = DetailsNetworkManager.shared
    
  
//MARK: - VARIABLES
    var country = Country(fullName: "", iso2: "")
    var timeTable = [CurrentCModel(date: "Loading...", confirmedNum: 0, deathsNum: 0, recoveredNum: 0)]
    
    //Информация для графиков
    var totalConfirmed = 0
    var totalDeaths = 0
    var totalRecovered = 0
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Назначаем имя страны
        //countryNameLabel.text = country.fullName
        //Назначаем себя делегатом менеджера получения всей информации
        currentInfManager.delegate = self
        //Test
        currentInfManager.fetchAllInf(url: country.url)
        //Показываем бар навигации
        navigationController?.navigationBar.isHidden = false
        //Заголовок бара
        title = country.fullName
    }
    
    
//MARK: - FUNCTIONS
    
}



//MARK: - EXTENSION. TOTALINFORMATION DELEGATE
extension DetailsViewController: DetailsNetworkManagerDelegate {
    //Обновление информации при загрузке данных
    func didUpdateInformation(_ detailsInfManager: DetailsNetworkManager, information: [CurrentCModel]) {
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузки перед показом view
        DispatchQueue.main.async {
            //Массив из обьектов
            self.timeTable = information
            //Сортировка
            self.dateSorting()
            //Перегрузка списка
            self.tableView.reloadData()
            
            //Число выздоровивших
            self.totalRecovered = self.timeTable[0].recoveredNum
            print(self.totalRecovered)
            //Число умерших
            self.totalDeaths = self.timeTable[0].deathsNum
            print(self.totalDeaths)
            //Общее число
            self.totalConfirmed = self.timeTable[0].confirmedNum
            print(self.totalConfirmed)
            
            //Настройка графиков
            self.setUpSchedule()
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
    //Метод настройки графиков
    private func  setUpSchedule() {
        let totalRecoveredFloat = Float(totalRecovered) / Float(totalConfirmed)
        let totalDeathsFloat = Float(totalDeaths) / Float(totalConfirmed)
        
        recoveredProgressView.setProgress(totalRecoveredFloat, animated: true)
        deathsProgressView.setProgress(totalDeathsFloat, animated: true)
        totalProgressView.setProgress(1.0, animated: true)
        
        totalLabel.text = "Confirmed: \(totalConfirmed)"
        recoveredLabel.text = "Recovered: \(totalRecovered)"
        deathsLabel.text = "Deaths: \(totalDeaths)"
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
