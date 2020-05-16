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
    //Ссылка на статистику по дням. Финальное значение - текущее по стране
    var url: String {
        return  ("https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2=\(iso2)&onlyCountries=true")
    }
}

//Расширение возвращающее массив моделей стран
extension Country {
    static func all() -> [Country] {
        return [
            //Country(fullName: "Afghanistan", iso2: "AF"),
            //Country(fullName: "Albania", iso2: "AL"),
            //Country(fullName: "Russia", iso2: "RU"),
            Country(fullName: "Afghanistan", iso2: "AF"),
            Country(fullName: "Albania", iso2: "AL"),
            Country(fullName: "Algeria", iso2: "DZ"),
            
            Country(fullName: "Andorra", iso2: "AD"),
            Country(fullName: "Angola", iso2: "AO"),
            
            Country(fullName: "Antigua and Barbuda", iso2: "AG"),
            Country(fullName: "Argentina", iso2: "AR"),
            Country(fullName: "Armenia", iso2: "AM"),
            
            Country(fullName: "Australia", iso2: "AU"),
            Country(fullName: "Austria", iso2: "AT"),
            Country(fullName: "Azerbaijan", iso2: "AZ"),
            
            Country(fullName: "Bahrain", iso2: "BH"),
            Country(fullName: "Bangladesh", iso2: "BD"),
            Country(fullName: "Barbados", iso2: "BB"),
            Country(fullName: "Belarus", iso2: "BY"),
            Country(fullName: "Belgium", iso2: "BE"),
            Country(fullName: "Belize", iso2: "BZ"),
            Country(fullName: "Benin", iso2: "BJ"),
            
            Country(fullName: "Bhutan", iso2: "BT"),
            Country(fullName: "Bolivia", iso2: "BO"),
            
            Country(fullName: "Bosnia and Herzegovina", iso2: "BA"),
            Country(fullName: "Botswana", iso2: "BW"),
            
            Country(fullName: "Brazil", iso2: "BR"),
            
            Country(fullName: "Bulgaria", iso2: "BG"),
            Country(fullName: "Burundi", iso2: "BI"),
            
            Country(fullName: "Cambodia", iso2: "KH"),
            Country(fullName: "Cameroon", iso2: "CM"),
            Country(fullName: "Canada", iso2: "CA"),
            
            Country(fullName: "Central African Republic", iso2: "CF"),
            Country(fullName: "Chad", iso2: "TD"),
            Country(fullName: "Chile", iso2: "CL"),
            Country(fullName: "China", iso2: "CN"),
            
            Country(fullName: "Colombia", iso2: "CO"),
            
            Country(fullName: "Costa Rica", iso2: "CR"),
            Country(fullName: "Croatia", iso2: "HR"),
            Country(fullName: "Cuba", iso2: "CU"),
            
            Country(fullName: "Cyprus", iso2: "CY"),
                        
            Country(fullName: "Denmark", iso2: "DK"),
            Country(fullName: "Djibouti", iso2: "DJ"),
            Country(fullName: "Dominica", iso2: "DM"),
            Country(fullName: "Dominican Republic", iso2: "DO"),
            Country(fullName: "Ecuador", iso2: "EC"),
            Country(fullName: "Egypt", iso2: "EG"),
            Country(fullName: "El Salvador", iso2: "SV"),
            Country(fullName: "Equatorial Guinea", iso2: "GQ"),
            Country(fullName: "Eritrea", iso2: "ER"),
            Country(fullName: "Estonia", iso2: "EE"),
            
            Country(fullName: "Ethiopia", iso2: "ET"),
            Country(fullName: "Fiji", iso2: "FJ"),
            Country(fullName: "Finland", iso2: "FI"),
            Country(fullName: "France", iso2: "FR"),
            
            Country(fullName: "Gabon", iso2: "GA"),
           
            Country(fullName: "Georgia", iso2: "GE"),
            Country(fullName: "Germany", iso2: "DE"),
            Country(fullName: "Ghana", iso2: "GH"),
            
            Country(fullName: "Greece", iso2: "GR"),
            
            Country(fullName: "Grenada", iso2: "GD"),
            
            Country(fullName: "Guatemala", iso2: "GT"),
            
            Country(fullName: "Guinea", iso2: "GN"),
            
            Country(fullName: "Guyana", iso2: "GY"),
            Country(fullName: "Haiti", iso2: "HT"),
            
            Country(fullName: "Honduras", iso2: "HN"),
            
            Country(fullName: "Hungary", iso2: "HU"),
            Country(fullName: "Iceland", iso2: "IS"),
            Country(fullName: "India", iso2: "IN"),
            Country(fullName: "Indonesia", iso2: "ID"),
            Country(fullName: "Iran ", iso2: "IR"),
            Country(fullName: "Iraq", iso2: "IQ"),
            Country(fullName: "Ireland", iso2: "IE"),
            
            Country(fullName: "Israel", iso2: "IL"),
            Country(fullName: "Italy", iso2: "IT"),
            Country(fullName: "Jamaica", iso2: "JM"),
            Country(fullName: "Japan", iso2: "JP"),
            
            Country(fullName: "Kazakhstan", iso2: "KZ"),
            Country(fullName: "Kenya", iso2: "KE"),
            
            Country(fullName: "Korea", iso2: "KR"),
            Country(fullName: "Kuwait", iso2: "KW"),
            Country(fullName: "Kyrgyzstan", iso2: "KG"),
            
            Country(fullName: "Latvia", iso2: "LV"),
            Country(fullName: "Lebanon", iso2: "LB"),
            Country(fullName: "Lesotho", iso2: "LS"),
            Country(fullName: "Liberia", iso2: "LR"),
            Country(fullName: "Libya", iso2: "LY"),
            Country(fullName: "Liechtenstein", iso2: "LI"),
            Country(fullName: "Lithuania", iso2: "LT"),
            Country(fullName: "Luxembourg", iso2: "LU"),
            
            Country(fullName: "Madagascar", iso2: "MG"),
            Country(fullName: "Malawi", iso2: "MW"),
            Country(fullName: "Malaysia", iso2: "MY"),
            Country(fullName: "Maldives", iso2: "MV"),
            Country(fullName: "Mali", iso2: "ML"),
            Country(fullName: "Malta", iso2: "MT"),
            
            Country(fullName: "Mauritania", iso2: "MR"),
            Country(fullName: "Mauritius", iso2: "MU"),
            
            Country(fullName: "Mexico", iso2: "MX"),
            
            Country(fullName: "Moldova", iso2: "MD"),
            Country(fullName: "Monaco", iso2: "MC"),
            Country(fullName: "Mongolia", iso2: "MN"),
            Country(fullName: "Montenegro", iso2: "ME"),
            
            Country(fullName: "Morocco", iso2: "MA"),
            Country(fullName: "Mozambique", iso2: "MZ"),
            
            Country(fullName: "Namibia", iso2: "NA"),
            
            Country(fullName: "Nepal", iso2: "NP"),
            Country(fullName: "Netherlands", iso2: "NL"),
            
            Country(fullName: "New Zealand", iso2: "NZ"),
            Country(fullName: "Nicaragua", iso2: "NI"),
            Country(fullName: "Niger", iso2: "NE"),
            Country(fullName: "Nigeria", iso2: "NG"),
            
            Country(fullName: "Norway", iso2: "NO"),
            Country(fullName: "Oman", iso2: "OM"),
            Country(fullName: "Pakistan", iso2: "PK"),
            
            Country(fullName: "Panama", iso2: "PA"),
            Country(fullName: "Papua New Guinea", iso2: "PG"),
            Country(fullName: "Paraguay", iso2: "PY"),
            Country(fullName: "Peru", iso2: "PE"),
            Country(fullName: "Philippines", iso2: "PH"),
            
            Country(fullName: "Poland", iso2: "PL"),
            Country(fullName: "Portugal", iso2: "PT"),
            
            Country(fullName: "Qatar", iso2: "QA"),

            Country(fullName: "Romania", iso2: "RO"),
            Country(fullName: "Russian Federation", iso2: "RU"),
            Country(fullName: "Rwanda", iso2: "RW"),
            
            Country(fullName: "San Marino", iso2: "SM"),
            
            Country(fullName: "Saudi Arabia", iso2: "SA"),
            Country(fullName: "Senegal", iso2: "SN"),
            Country(fullName: "Serbia", iso2: "RS"),
            Country(fullName: "Seychelles", iso2: "SC"),
            Country(fullName: "Sierra Leone", iso2: "SL"),
            Country(fullName: "Singapore", iso2: "SG"),
            Country(fullName: "Slovakia", iso2: "SK"),
            Country(fullName: "Slovenia", iso2: "SI"),
            
            Country(fullName: "Somalia", iso2: "SO"),
            Country(fullName: "South Africa", iso2: "ZA"),
            
            Country(fullName: "South Sudan", iso2: "SS"),
            Country(fullName: "Spain", iso2: "ES"),
            Country(fullName: "Sri Lanka", iso2: "LK"),
            Country(fullName: "Sudan", iso2: "SD"),
            
            Country(fullName: "Sweden", iso2: "SE"),
            Country(fullName: "Switzerland", iso2: "CH"),
            Country(fullName: "Syrian Arab Republic", iso2: "SY"),
            
            Country(fullName: "Tajikistan", iso2: "TJ"),
            Country(fullName: "Tanzania", iso2: "TZ"),
            Country(fullName: "Thailand", iso2: "TH"),
            
            Country(fullName: "Togo", iso2: "TG"),
           
            Country(fullName: "Trinidad and Tobago", iso2: "TT"),
            Country(fullName: "Tunisia", iso2: "TN"),
            Country(fullName: "Turkey", iso2: "TR"),
                        
            Country(fullName: "Uganda", iso2: "UG"),
            Country(fullName: "Ukraine", iso2: "UA"),
            Country(fullName: "United Arab Emirates", iso2: "AE"),
            Country(fullName: "United Kingdom", iso2: "GB"),
            Country(fullName: "United States of America", iso2: "US"),
            Country(fullName: "Uruguay", iso2: "UY"),
            Country(fullName: "Uzbekistan", iso2: "UZ"),
            
            Country(fullName: "Venezuela", iso2: "VE"),
            Country(fullName: "Viet Nam", iso2: "VN"),
            Country(fullName: "Yemen", iso2: "YE"),
            Country(fullName: "Zambia", iso2: "ZM"),
            Country(fullName: "Zimbabwe", iso2: "ZW"),
        ]
    }
}
