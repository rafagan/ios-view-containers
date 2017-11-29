//
//  TableViewController.swift
//  Container
//
//  Created by Rafagan Abreu on 28/11/17.
//  Copyright © 2017 Rafagan Abreu. All rights reserved.
//

import UIKit
import DataKit

class TableViewController: UITableViewController {
    let maxSections = 2
    let maxRows = 5
    var data = [Int: [Icon]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = generateIcons(sections: maxSections, rows: maxRows)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return maxSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let content = data[indexPath.section]![indexPath.row]
        
        cell.textLabel?.text = content.name
        cell.detailTextLabel?.text = content.description
        
        var img = UIImage(named: content.imageName)
        img = img?.withRenderingMode(.alwaysTemplate)
        cell.imageView?.image = img
        cell.imageView?.tintColor =
            UIColor(displayP3Red: CGFloat(normalizedRandom()),
                    green: CGFloat(normalizedRandom()),
                    blue: CGFloat(normalizedRandom()),
                    alpha: 1)

        return cell
    }
}
