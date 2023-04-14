//
//  DriverDisplayStandings.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-05.
//

import UIKit

protocol DriverDisplayStandingsDelegate{
    func moveToOtherSeasonsView (_ sender : DriverDisplayStandingsUi)
    func driverDataToMove ( driver : DriverCellUI)
    }
// delegate exists here somewehre

class DriverDisplayStandingsUi : UIView{
    
    var delegate : DriverDisplayStandingsDelegate?
    private var drivers: [DriverCellUI] = []
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let lblStandingsText : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byClipping
        lbl.text = "Current Season Standings:"
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .white
        return lbl
    }()
    
    private let btnShowOtherSeasons : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 5
        btn.setTitle("Show Standings For Previous Seasons", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialise()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    private func initialise(){
        
        self.addSubview(lblStandingsText)
        self.addSubview(scrollView)
        self.addSubview(btnShowOtherSeasons)
        scrollView.addSubview(stackView)
        scrollView.showsHorizontalScrollIndicator = false
        stackView.axis = .horizontal
        
        // WOO IT WORKS
        btnShowOtherSeasons.addTarget(self, action: #selector(btnShowOtherSeasonsTouchUp), for: .touchUpInside)
        
        F1ErgastAPI.getCurrentStandings(){httpStatusCode,response in
            
            guard let standings = response["MRData"] as? [String:Any] else{
                return
            }
            guard let standingsTable = standings["StandingsTable"] as? [String:Any] else{
                return
            }

            if let currentStandings = F1CurrentDriversStandings.decode(json: standingsTable){
                
                for i in(0..<currentStandings.standingLists[0].driverStandings.count){
                    
                    DispatchQueue.main.async {
                         let driver = DriverCellUI()
                        
                        driver.driverURL = currentStandings.standingLists[0].driverStandings[i].driver.url
                        driver.nationality = currentStandings.standingLists[0].driverStandings[i].driver.nationality
                        driver.champPosition = currentStandings.standingLists[0].driverStandings[i].position
                        driver.team = currentStandings.standingLists[0].driverStandings[i].constructors[0].name
                        driver.name = "\(currentStandings.standingLists[0].driverStandings[i].driver.givenName!) \(currentStandings.standingLists[0].driverStandings[i].driver.familyName!)"
                        driver.addTarget(self, action: #selector(self.driverCellSelected), for: .touchUpInside)
                        self.drivers.append(driver)
                        self.stackView.addArrangedSubview(driver)
                        
                    }
                }
                
            } else {
                print("Error decoding!")
            }
            
        }failHandler: { httpStatusCode, errorMessage in
            print("Fail Handler: http code from api call \(httpStatusCode),\(errorMessage)")
        }
    }
    
    func applyConstraints(){
        self.layer.cornerRadius = 5
        self.backgroundColor = .gray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 220),
            self.widthAnchor.constraint(equalToConstant: 410),
            
            lblStandingsText.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            lblStandingsText.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: lblStandingsText.bottomAnchor,constant: 10),
            scrollView.heightAnchor.constraint(equalToConstant: 120),
            scrollView.widthAnchor.constraint(equalToConstant: 400),
           
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           
            btnShowOtherSeasons.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            btnShowOtherSeasons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btnShowOtherSeasons.heightAnchor.constraint(equalToConstant: 40),
            btnShowOtherSeasons.widthAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    @objc private func driverCellSelected(_ driverSelected : DriverCellUI){
        
        if self.delegate != nil{
            self.delegate?.driverDataToMove(driver: driverSelected)
        }
    }
    
    @objc private func btnShowOtherSeasonsTouchUp(){
       
        if self.delegate != nil {
            self.delegate!.moveToOtherSeasonsView(self)
        }
    }
}
