//
//  ExpandableTableViewVC.swift
//  ExpandableUITableView
//
//  Created by appinventiv on 01/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

//=============================================================//
//MARK: ExpandableTableViewVC Class
//=============================================================//

class ExpandableTableViewVC: UIViewController {
    
//=============================================================//
//MARK: Stored Property
//=============================================================//
    
    let sectionArray = ["Mobile","Laptop","City","Car","Country","Gender"]
    let listOne = ["Sony", "MotoRola","Nokia","Samsung","Lenevo","Mi"]
    let listTwo = ["Sony", "Dell", "Mac","Lenevo","Hp"]
    let listThree = ["Delhi","Dehradun","Noida","Jaipur","Mangalore"]
    let listFour = ["Honda","Maruti","Mahindra","BMW","Pourse","Ford"]
    let listFive = ["India","USA","UAE","SriLanka","Pakistan","Bangladesh","Miyamar","Nepal","China","Austrailia","India","USA","UAE","SriLanka","Pakistan","Bangladesh","Miyamar","Nepal","China","Austrailia","India","USA","UAE","SriLanka","Pakistan","Bangladesh","Miyamar","Nepal","China","Austrailia"]
    let listSix = ["Male","FeMale","TransGender"]
    
    var imageNameArray = [String]()
    
//=============================================================//
//MARK: Defining IBOutlet for UITableView
//=============================================================//
    
    @IBOutlet weak var expandableTableView: UITableView!
    
//=============================================================//
//MARK: View Method
//=============================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.expandableTableView.delegate = self
        self.expandableTableView.dataSource = self
        
        for tempIndex in 0..<sectionArray.count {
            imageNameArray.insert("down", at: tempIndex)
        }
        
    }
    
//======================================================================//
//MARK: Setting for viewing the inside list
//======================================================================//
    
    @IBAction func expandImageBtnTapped(_ sender: UIButton) {
        
        let section = sender.tag
        if imageNameArray[section] == "down" {
            imageNameArray[section] = "up"
        }
        else if imageNameArray[section] == "up" {
            imageNameArray[section] = "down"
        }
        expandableTableView.reloadData()
        
    }

}

//=============================================================//
//MARK: ExpandableTableViewVC Class Extension
//=============================================================//

extension ExpandableTableViewVC: UITableViewDelegate, UITableViewDataSource {
    
//=============================================================//
//MARK: Setting Number Of Cells
//=============================================================//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if imageNameArray[section] == "up" {

            switch section {
            case 0:
                return self.listOne.count
            case 1:
                return self.listTwo.count
            case 2:
                return self.listThree.count
            case 3:
                return self.listFour.count
            case 4:
                return self.listFive.count
            default:
                return self.listSix.count
            }
        }
        else {
            return 0
        }
        
    }
    
//=============================================================//
//MARK: Setting the Cell View
//=============================================================//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellForRowClass_ID", for: indexPath) as? CellForRowClass else { fatalError() }
        
        cell.expandImageBtnName.isHidden = true
        cell.backgroundColor = UIColor.orange
        switch indexPath.section {
        case 0:
            cell.nameLabel.text = listOne[indexPath.row]
        case 1:
            cell.nameLabel.text = listTwo[indexPath.row]
        case 2:
            cell.nameLabel.text = self.listThree[indexPath.row]
        case 3:
            cell.nameLabel.text = self.listFour[indexPath.row]
        case 4:
            cell.nameLabel.text = self.listFive[indexPath.row]
        default:
            cell.nameLabel.text = self.listSix[indexPath.row]
        }
        return cell
        
    }
    
//=============================================================//
//MARK: Setting the Cell Header View
//=============================================================//
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "cellForRowClass_ID") as? CellForRowClass else { fatalError("Cell Failed to load") }
    
        sectionCell.nameLabel.text = sectionArray[section]
        sectionCell.backgroundColor = UIColor.cyan
        sectionCell.expandImageBtnName.tag = section
        sectionCell.expandImageBtnName.isHidden = false
        sectionCell.expandImageBtnName.setImage(UIImage(named: imageNameArray[section]), for: .normal)
        
        return sectionCell
        
    }
    
//=============================================================//
//MARK: Setting Height Of the Cell
//=============================================================//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//=============================================================//
//MARK: Setting the number of Sections
//=============================================================//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
//=============================================================//
//MARK: Setting Height Of the Cell Header
//=============================================================//
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
//=============================================================//
//MARK: User Define Method for Getting IndexPath
//=============================================================//
    
    func getCell(button: UIButton) -> UITableViewCell{
        var cell : UIView = button
        while !(cell is CellForRowClass) {
            if let super_view = cell.superview {
                cell = super_view
            }else{}
        }
        guard let tableCell = cell as? CellForRowClass else {fatalError()}
        return tableCell
    }
 
}

//=============================================================//
//MARK: Class for Cell UIViews
//=============================================================//

class CellForRowClass: UITableViewCell {
    
//=============================================================//
//MARK: TableView IBOutlets
//=============================================================//
    
    @IBOutlet weak var expandImageBtnName: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
}
