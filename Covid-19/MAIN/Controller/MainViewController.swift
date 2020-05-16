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
    var totalInfManager = TotalInfNetworkManager()
    
    
//MARK: - VARIABLES    
    var countries = Country.all()
    
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Назначаем себя делегатом менеджера получения всей информации
        totalInfManager.delegate = self
        //Получаем все данные статистики по всему миру
        totalInfManager.fetchAllInf()
    }
    //Прячем бар навигации
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
 
    
//MARK: - ACTIONS
    //Сортировка по убыванию
    @IBAction func sortingButtonZPressed(_ sender: UIButton) {
        countries = countries.sorted{ $0.fullName > $1.fullName }
        tableView.reloadData()
    }
    //Сортировка по возрастанию
    @IBAction func sortingButtonAPressed(_ sender: UIButton) {
        countries = countries.sorted{ $0.fullName < $1.fullName }
        tableView.reloadData()
    }
    
    
//MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "detailsSegue" else { return }
        //Индекс нажатой ячейки
        let indexPath = tableView.indexPathForSelectedRow!
        //Обьект нажатой ячейки
        let country = countries[indexPath.row]
        //Добираемся до контроллера назначения
        if let detailsVC = segue.destination as? DetailsViewController {
            //Передаем обьект
            detailsVC.country = country
        }
        
        
        /*
         if segue.identifier == "MySegueId" {
             if let nextViewController = segue.destination as? NextViewController {
                     nextViewController.valueOfxyz = "XYZ" //Or pass any values
                     nextViewController.valueOf123 = 123
             }
         }
         
         let navigationVC = segue.destination as! UINavigationController
         //Верхний контроллер
         let detailsVC = navigationVC.topViewController as! DetailsViewController
         //Передаем обьект
         detailsVC.country = country
         //detailsVC.title = "Edit"
         */
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
    func didUpdateInformation(_ totalInfManager: TotalInfNetworkManager, information: TotalInfModel) {
        //Выполняем в асинхронном режиме чтобы не ждать завершения загрузки перед показом view
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




// MARK: - UITABLEVIEWDATASOURSE
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        cell.flagLabel.text = countries[indexPath.row].flag
        cell.countryLabel.text = countries[indexPath.row].fullName
        cell.tintColor = .blue
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
