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
    var totalInfManager = TotalInfNetworkManager.shared
    
    
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
    }
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
        //Настраиваем ячейку
        cell.flagLabel.text = countries[indexPath.row].flag
        cell.countryLabel.text = countries[indexPath.row].fullName
        cell.tintColor = .blue
        return cell
    }
}
