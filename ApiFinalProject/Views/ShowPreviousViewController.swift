//
//  ShowPreviousViewController.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-14.
//

import UIKit

class ShowPreviousViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource,
                                  UITableViewDelegate, UITableViewDataSource {
   
    
    
    let YearPicker = UIPickerView()
    var years : [String] = []
    var drivers : [Driver] = []
    let tableView = UITableView()
    
    private let btnPopulateTableView : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 5
        btn.setTitle("Get Data For Selected Year", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialise()
        applyConstraints()

        // Do any additional setup after loading the view.
    }
    
    func initialise(){
        view.addSubview(YearPicker)
        view.addSubview(btnPopulateTableView)
        view.addSubview(tableView)
        YearPicker.dataSource = self
        YearPicker.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(DriverTableCell.self, forCellReuseIdentifier: "driverCell")
        tableView.rowHeight = 75
        
        for i in(0..<74){
            var calc : Int = 2023-i
            years.append(String(calc))
        }
        
        btnPopulateTableView.addTarget(self, action: #selector(getTableData), for: .touchUpInside)
    }
    
    func applyConstraints(){
        YearPicker.translatesAutoresizingMaskIntoConstraints = false
        btnPopulateTableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            YearPicker.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 10),
            YearPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            YearPicker.heightAnchor.constraint(equalToConstant: 150),
            YearPicker.widthAnchor.constraint(equalToConstant: 100),
            
            btnPopulateTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            btnPopulateTableView.trailingAnchor.constraint(equalTo: YearPicker.trailingAnchor,constant: -10),
            btnPopulateTableView.heightAnchor.constraint(equalToConstant: 50),
            btnPopulateTableView.widthAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: YearPicker.bottomAnchor ,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    @objc func getTableData(){
        // api call goes here
        
        drivers.removeAll()
        
        F1ErgastAPI.getPreviousStandings(year: years[YearPicker.selectedRow(inComponent: 0)]){httpStatusCode,response in
            
            guard let standings = response["MRData"] as? [String:Any] else{
                return
            }
            guard let standingsTable = standings["StandingsTable"] as? [String:Any] else{
                return
            }

            if let previousStandings = F1CurrentDriversStandings.decode(json: standingsTable){
                
                for i in(0..<previousStandings.standingLists[0].driverStandings.count){
                    
                    let driver = Driver(name: "", championshipPos: "", constructor: "", points: "")
                    
                    driver.name = "\(previousStandings.standingLists[0].driverStandings[i].driver.givenName!) \(previousStandings.standingLists[0].driverStandings[i].driver.familyName!)"
                    
                    driver.championshipPos = previousStandings.standingLists[0].driverStandings[i].position!
                    
                    driver.points = previousStandings.standingLists[0].driverStandings[i].points!
                    
                    driver.constructor = previousStandings.standingLists[0].driverStandings[i].constructors[0].name!
                    
                    self.drivers.append(driver)
                    print(self.drivers.count)
                    print(self.drivers[i].name)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        } failHandler: { httpStatusCode, errorMessage in
            print("Fail Handler: http code from api call \(httpStatusCode),\(errorMessage)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "driverCell", for: indexPath) as! DriverTableCell
        
        cell.driverName.text = drivers[indexPath.row].name
        cell.constructor.text = drivers[indexPath.row].constructor
        cell.champPostion.text = drivers[indexPath.row].championshipPos
        cell.points.text = drivers[indexPath.row].points
        
        return cell
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
}

