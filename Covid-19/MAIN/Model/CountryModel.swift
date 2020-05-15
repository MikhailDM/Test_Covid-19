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
    var flag: String {
        return  iso2
                .unicodeScalars
                .map({ 127397 + $0.value })
                .compactMap(UnicodeScalar.init)
                .map(String.init)
                .joined()
    }
}

//Расширение возвращающее массив моделей стран
extension Country {
    static func all() -> [Country] {
        return [
            Country(fullName: "Австралия", iso2: "AU"),
            Country(fullName: "Австрия", iso2: "AT"),            
        ]
    }
}
