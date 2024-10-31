//
//  TableViewHandlerProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import UIKit

protocol TableViewHandlerProtocol: UITableViewDataSource, UITableViewDelegate {
    func configure(tableView: UITableView)
    func updateStateData(_ states: [StateModel])
    func updateNationData(_ nations: [NationModel])
}
