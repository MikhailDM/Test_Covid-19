//
//  MainNetwork.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation

//Протокол делегата
protocol TotalInfManagerDelegate {
    func didUpdateInformation(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

//Получаем данные для основной статистики
class TotalInfManager {
   let totalInformationURL = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/brief"
   
   var delegate: TotalInfManagerDelegate?
   
   func fetchWeather(cityName: String) {
       let urlString = "\(totalInformationURL)&q=\(cityName)"
       performRequest(with: urlString)
   }
   
   func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
       let urlString = "\(totalInformationURL)&lat=\(latitude)&lon=\(longitude)"
       performRequest(with: urlString)
   }
   
   func performRequest(with urlString: String) {
       if let url = URL(string: urlString) {
           let session = URLSession(configuration: .default)
           let task = session.dataTask(with: url) { (data, response, error) in
               if error != nil {
                   self.delegate?.didFailWithError(error: error!)
                   return
               }
               if let safeData = data {
                   if let weather = self.parseJSON(safeData) {
                       self.delegate?.didUpdateWeather(self, weather: weather)
                   }
               }
           }
           task.resume()
       }
   }
   
   func parseJSON(_ weatherData: Data) -> WeatherModel? {
       let decoder = JSONDecoder()
       do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           let id = decodedData.weather[0].id
           let temp = decodedData.main.temp
           let name = decodedData.name
           
           let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
           return weather
           
       } catch {
           delegate?.didFailWithError(error: error)
           return nil
       }
   }
   
   
   
}
