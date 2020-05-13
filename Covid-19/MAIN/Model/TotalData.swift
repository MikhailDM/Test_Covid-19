//
//  TotalModel.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import Foundation
//Модель данных JSON
struct TotalData: Codable {
    var confirmed: Int
    var deaths: Int
    var recovered: Int
}
