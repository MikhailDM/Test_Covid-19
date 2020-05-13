//
//  MainViewController.swift
//  Covid-19
//
//  Created by Михаил Дмитриев on 13.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
//MARK: - LINKS
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
//MARK: - OBJECTS
    var totalInfManager = TotalInfManager()
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Назначаем себя делегатом менеджера получения всей информации
        totalInfManager.delegate = self
        
        //Получаем все данные статистики по всему миру
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
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузкиы перед показом view
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




// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as UITableViewCell

        cell.textLabel!.text = "TEST"
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let meal = user.meals?[indexPath.row] as? Meal, editingStyle == .delete else { return }
        
        context.delete(meal)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }*/
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "My happy meal time"
     }
     
     */
}
