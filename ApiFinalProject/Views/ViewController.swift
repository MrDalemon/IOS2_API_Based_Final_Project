//
//  ViewController.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-05.
//

import UIKit

class ViewController: UIViewController, DriverDisplayStandingsDelegate{
    
    
    
var displayDriverStandings : DriverDisplayStandingsUi = DriverDisplayStandingsUi()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialise()
        applyConstraints()
      }
    
    func initialise(){
        
        view.addSubview(displayDriverStandings)
        displayDriverStandings.delegate = self
    }
    
    func applyConstraints(){
        
        displayDriverStandings.translatesAutoresizingMaskIntoConstraints = false
        displayDriverStandings.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayDriverStandings.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func moveToOtherSeasonsView(_ sender: DriverDisplayStandingsUi) {
        print("the button display other seasons was clicked")
        // move to the other seasons view controller
        performSegue(withIdentifier: "goToPreviousSeasons", sender: self)
    }
    
    func driverDataToMove(driver: DriverCellUI) {
        print("driver name: \(driver.name!) championship pos: \(driver.champPosition!)")
        // works better and looks niceer than making a details page (also the url was in the api call)
        UIApplication.shared.open(URL(string: driver.driverURL!)!)
    }
    
}

