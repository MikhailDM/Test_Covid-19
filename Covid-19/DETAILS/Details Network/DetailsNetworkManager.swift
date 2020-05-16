//
//  DetailsNetworkManager.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 15.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

//MARK: - DELEGATE
protocol DetailsNetworkManagerDelegate {
    func didUpdateInformation(_ detailsInfManager: DetailsNetworkManager, information: [CurrentCModel])
    func didFailWithError(error: Error)
}


//Получаем данные для основной статистики
class DetailsNetworkManager {
//MARK: - INIT
    static var shared = DetailsNetworkManager()
    private init(){}
    
    
//MARK: - VARIABLES
    //Делегат
    var delegate: DetailsNetworkManagerDelegate?
    

//MARK: - ПОЛУЧАЕМ ИНФОРМАЦИЮ
    //Функция получения статистики по стране
    func fetchAllInf(url: String) {
        performRequest(with: url)
    }
    
    //Интернет сессия
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let information = self.parseJSON(safeData) {
                        print("Список информации по стране получен")
                        //print(information)
                        self.delegate?.didUpdateInformation(self, information: information)
                    }
                }
            }
            task.resume()
        }
    }
    
    //Парсим JSON
    private func parseJSON(_ currentCData: Data) -> [CurrentCModel]? {
        //Массив из моделей дня для текущей страны
        var daysArray = [CurrentCModel]()
        //Декодер
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CurrentCData].self, from: currentCData)
            //Словарь дней
            let dictionaryDays = decodedData[0]
            for (day, statistic) in dictionaryDays.timeseries {
                let currentDay = day
                let confirmed = statistic.confirmed
                let deaths = statistic.deaths
                let recovered = statistic.recovered
                //Mодель текущей страны
                let currentInf = CurrentCModel(date: currentDay, confirmedNum: confirmed, deathsNum: deaths, recoveredNum: recovered)
                //Прибавляем модель к массиву моделей
                daysArray.append(currentInf)
            }
            return daysArray
            //return daysArray.sorted{ $0.confirmedNum > $1.confirmedNum }
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
