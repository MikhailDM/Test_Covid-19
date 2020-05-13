//
//  MainViewController.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
//MARK: - LABELS
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    
//MARK: - OBJECTS
    var totalInfManager = TotalInfManager()
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Назначаем себя делегатом менеджера получения всей информации
        totalInfManager.delegate = self
        
        //Получаем все данные
        totalInfManager.fetchAllInf()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//MARK: - EXTENSION. TOTALINFORMATION DELEGATE
extension MainViewController: TotalInfManagerDelegate {
    //Обновление информации при загрузке данных
    func didUpdateInformation(_ totalInfManager: TotalInfManager, information: TotalInfModel) {
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузку перед показом view
        DispatchQueue.main.async {
            self.confirmedLabel.text = String(information.confirmedNum)
            self.deathLabel.text = String(information.deathsNum)
            self.recoveredLabel.text = String(information.recoveredNum)
        }
    }
    
    //Ошибка сети
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
