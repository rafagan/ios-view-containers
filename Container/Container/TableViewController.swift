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
    let maxSections = 5
    let maxRows = 15
    lazy var dataIcon = [Int: [Icon]]()
    lazy var dataImage = [Int: [NetworkImage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataIcon = generateIcons(sections: maxSections, rows: maxRows)
        dataImage = generateImages(sections: maxSections, rows: maxRows)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return maxSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iconOrImage = arc4random_uniform(2) == 0
        let cell = tableView.dequeueReusableCell(
            withIdentifier: iconOrImage ? "icon" : "image", for: indexPath)
        
        if iconOrImage {
            let content = dataIcon[indexPath.section]![indexPath.row]
            
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
        } else {
            let content = dataImage[indexPath.section]![indexPath.row]
            
            cell.textLabel?.text = content.name
            cell.detailTextLabel?.text = content.description
            cell.imageView?.downloadImage(url: URL(string: content.link)!)
        }

        return cell
    }
}
