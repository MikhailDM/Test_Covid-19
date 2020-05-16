//
//  MainNetwork.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

//MARK: - DELEGATE
protocol TotalInfManagerDelegate {
    func didUpdateInformation(_ totalInfManager: TotalInfNetworkManager, information: TotalInfModel)
    func didFailWithError(error: Error)
}


//Получаем данные для основной статистики
class TotalInfNetworkManager {
//MARK: - VARIABLES
    //URL
    private let totalInformationURL = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/brief"
    //Делегат
    var delegate: TotalInfManagerDelegate?
    

//MARK: - ПОЛУЧАЕМ ИНФОРМАЦИЮ
    //Функция получения всей статистики
    func fetchAllInf() {
        performRequest(with: totalInformationURL)
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
                        print("Список информации по миру получен")
                        //print(information)
                        self.delegate?.didUpdateInformation(self, information: information)
                    }
                }
            }
            task.resume()
        }
    }
    
    //Парсим JSON
    private func parseJSON(_ totalInfData: Data) -> TotalInfModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TotalData.self, from: totalInfData)
            let confirmed = decodedData.confirmed
            let deaths = decodedData.deaths
            let recovered = decodedData.recovered
            //Наша модель текущей информации
            let totalInf = TotalInfModel(confirmedNum: confirmed, deathsNum: deaths, recoveredNum: recovered)
            return totalInf
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
