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
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    

//MARK: - OBJECTS
    var currentInfManager = DetailsNetworkManager.shared
    
  
//MARK: - VARIABLES
    var country = Country(fullName: "", iso2: "")
    
    
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
        print(information.last?.date)
        print(information.last?.confirmedNum)        
        print(information.last?.deathsNum)
        print(information.last?.recoveredNum)
        
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузки перед показом view
        /*DispatchQueue.main.async {
            self.confirmedLabel.text = String(information.confirmedNum)
            self.deathLabel.text = String(information.deathsNum)
            self.recoveredLabel.text = String(information.recoveredNum)
        }*/
    }
    //Ошибка сети
    func didFailWithError(error: Error) {
        print(error)
    }
}
