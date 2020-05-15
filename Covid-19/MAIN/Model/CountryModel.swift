//
//  CountryModel.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 15.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Модель страны
struct Country {
    var fullName: String
    var iso2: String
    //Флаг страны в зависимости от ISO2
    var flag: String {
        return  iso2
                .unicodeScalars
                .map({ 127397 + $0.value })
                .compactMap(UnicodeScalar.init)
                .map(String.init)
                .joined()
    }
    //Ссылка на данные в зависимости от страны
    var url: String {
        return  ("https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2=\(iso2)&onlyCountries=true")
    }
}

//Расширение возвращающее массив моделей стран
extension Country {
    static func all() -> [Country] {
        return [
            Country(fullName: "Afghanistan", iso2: "AF"),
            Country(fullName: "Albania", iso2: "AL"),
            Country(fullName: "Russia", iso2: "RU"),
        ]
    }
}
