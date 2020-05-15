//
//  CurrentCData.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 15.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Модель данных JSON
struct CurrentCData: Codable {
    let timeseries: [String: Timesery]
}

// MARK: - Timesery
struct Timesery: Codable {
    let confirmed, deaths, recovered: Int
}
