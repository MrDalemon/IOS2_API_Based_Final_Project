//
//  TableViewCell.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-14.
//

import UIKit

class DriverTableCell: UITableViewCell {

    let driverName = UILabel()
    let champPostion = UILabel()
    let constructor = UILabel()
    let points = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialise(){
        
        contentView.addSubview(driverName)
        contentView.addSubview(constructor)
        contentView.addSubview(champPostion)
        contentView.addSubview(points)
        
        driverName.translatesAutoresizingMaskIntoConstraints = false
        champPostion.translatesAutoresizingMaskIntoConstraints = false
        constructor.translatesAutoresizingMaskIntoConstraints = false
        points.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            driverName.topAnchor.constraint(equalTo:contentView.topAnchor ,constant: 10),
            driverName.leadingAnchor.constraint(equalTo:contentView.leadingAnchor,constant: 10),
            
            constructor.topAnchor.constraint(equalTo:driverName.bottomAnchor ,constant: 10),
            constructor.leadingAnchor.constraint(equalTo:contentView.leadingAnchor ,constant: 10),
            
            champPostion.topAnchor.constraint(equalTo:contentView.topAnchor ,constant: 10),
            champPostion.leadingAnchor.constraint(equalTo:driverName.trailingAnchor ,constant: 10),
            
            points.topAnchor.constraint(equalTo: champPostion.bottomAnchor , constant: 10),
            points.leadingAnchor.constraint(equalTo: constructor.trailingAnchor , constant: 10)
        ])
        
    }

}
