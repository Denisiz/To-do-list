//
//  ViewController.swift
//  OurToDoList
//
//  Created by Денис on 09.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    
    
    ///.............делаем табличку<
    private let table: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "ячейка")
        return table
        
        
        
    }()
    ///............делаем табличку>
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "Список дел"
        view.addSubview(table)
        table.dataSource = self
        ///выше написано что мы сами будем предоставлять данные для таблицы
        ///выше написано что мы добавляем кнопку+<
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                    action: #selector(didTapAdd))
    }
        ///создаём оповещение для ввода<
        @objc private func didTapAdd() {
            let alert = UIAlertController(
                title: "Новая задача",
                message: "Введите текст",
                preferredStyle: .alert)
            ///.........заполнитель текста<
            alert.addTextField { field in
                field.placeholder = "Я хочу сделать..."
            }
            ///.........заполнитель текста>
            alert.addAction(UIAlertAction(
                title: "Отмена",
                style: .cancel,
                handler: nil))
            alert.addAction(UIAlertAction(
                title: "Готово",
                style: .default,
                handler: { [weak self] (_) in
                    if let field = alert.textFields?.first {
                        if let text = field.text, !text.isEmpty {
                         
            ///сюда введём новый пункт списка дел
            DispatchQueue.main.async {
                var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                currentItems.append(text)
                UserDefaults.standard.setValue(currentItems, forKey: "items")
                self?.items.append(text)
                self?.table.reloadData()
            }
        }
    }
}))
    
            ///кнопка ввод/отмены
            
            present(alert, animated: true)
            
        }
        ///создаём оповещение для ввода>
        ///выше написано что мы добавляем кнопку+>
    ///придаём форму<
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    ///придаём форму>
    
                
    
    ///создаёт и возвращает ячейку<
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return items.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ячейка",
                    for: indexPath)
                
                cell.textLabel?.text = items[indexPath.row]
                return cell
    ///создаёт и возвращает ячейку>

            }

}
