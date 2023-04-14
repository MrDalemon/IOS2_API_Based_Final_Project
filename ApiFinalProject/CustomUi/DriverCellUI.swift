//
//  DriverCellUI.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-05.
//

import UIKit

class DriverCellUI: UIButton{

    var name :String?{
        didSet{
            lblName.text = name
        }
    }
    var champPosition : String?{
        didSet{
            lblChampPostion.text = champPosition
        }
    }
    // going to need to change it and or figure out where the photo is coming from
    var team : String? {
        didSet{
            lblTeam.text = team
        }
    }
    var nationality : String?{
        didSet{
            lblNationality.text = nationality
        }
    }
    // used for showing all of the driver stats
    var driverURL : String?
    
    
    private let lblName = createLabel(fontSize: 12, numofLines: 2, defaultText: "Set Name")
    private let lblChampPostion = createLabel(fontSize: 15, numofLines: 1, defaultText: "0")
    private let lblNationality = createLabel(fontSize: 12, numofLines: 1, defaultText: "Canidian")
    private let lblTeam = createLabel(fontSize: 15, numofLines: 1, defaultText: "arrows")
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemeted")
    }
    
    static func createLabel(fontSize : CGFloat , numofLines : Int , defaultText : String?)-> UILabel{
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byClipping
        lbl.numberOfLines = numofLines
        lbl.text = defaultText
        lbl.font = .systemFont(ofSize: fontSize)
        lbl.textColor = .white
        return lbl
    }

    private func initialise() {
        self.backgroundColor = .black
        // per team background color? possibly
        
        self.layer.cornerRadius = 10
        addSubview(lblName)
        addSubview(lblChampPostion)
        addSubview(lblTeam)
        addSubview(lblNationality)
    }
    
    private func applyConstraints(){
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 120),
            self.widthAnchor.constraint(equalToConstant: 100),
            
            lblName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            lblName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lblTeam.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10),
            lblTeam.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lblChampPostion.topAnchor.constraint(equalTo: lblTeam.bottomAnchor, constant: 10),
            lblChampPostion.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lblNationality.topAnchor.constraint(equalTo: lblChampPostion.bottomAnchor,constant: 10),
            lblNationality.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
