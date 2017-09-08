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
    
    // Array for Header
    let sectionArray = ["Mobile","Laptop","City","Car","Country","Gender"]
    
    // Arrays for each Sections
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
        
        // Registering Cell and Header
        let headerRegister = UINib(nibName: "CustomHeader", bundle: nil)
        self.expandableTableView.register(headerRegister, forHeaderFooterViewReuseIdentifier: "customHeader_ID")
        
        let cellRegister = UINib(nibName: "CustomCell", bundle: nil)
        self.expandableTableView.register(cellRegister, forCellReuseIdentifier: "customCell_ID")
        
        // Inserting the default image name for the UpORDown Button
        for tempIndex in 0..<self.sectionArray.count {
            self.imageNameArray.insert("down", at: tempIndex)
        }
        
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
      
        if self.imageNameArray[section] == "up" {

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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell_ID") as? CustomCell else { fatalError() }
        
        switch indexPath.section {
        case 0:
            cell.innerListLabel.text = self.listOne[indexPath.row]
        case 1:
            cell.innerListLabel.text = self.listTwo[indexPath.row]
        case 2:
            cell.innerListLabel.text = self.listThree[indexPath.row]
        case 3:
            cell.innerListLabel.text = self.listFour[indexPath.row]
        case 4:
            cell.innerListLabel.text = self.listFive[indexPath.row]
        default:
            cell.innerListLabel.text = self.listSix[indexPath.row]
        }
        return cell
        
    }
    
//=============================================================//
//MARK: Setting the Cell Header View
//=============================================================//
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let sectionCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader_ID") as? CustomHeader else { fatalError("Header Failed to load") }
        
        // Adding Target(IBAction for UpORDown Button
        sectionCell.upDownImageBtnName.addTarget(self, action: #selector(self.expandImageBtnTapped(_:)), for: .touchUpInside)
    
        sectionCell.headerNameLabel.text = self.sectionArray[section]
        sectionCell.contentView.backgroundColor = UIColor.lightGray
        sectionCell.upDownImageBtnName.tag = section
        sectionCell.upDownImageBtnName.setImage(UIImage(named: self.imageNameArray[section]), for: .normal)
        
        return sectionCell
        
    }
    
//=============================================================//
//MARK: Action for UpOrDown Button
//=============================================================//
    
    @objc func expandImageBtnTapped(_ sender: UIButton) {
        
        let section = sender.tag
        if self.imageNameArray[section] == "down" {
            self.imageNameArray[section] = "up"
        }
        else if self.imageNameArray[section] == "up" {
            self.imageNameArray[section] = "down"
        }
        self.expandableTableView.reloadSections([section], with: .automatic)
        
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
        return self.sectionArray.count
    }
    
//=============================================================//
//MARK: Setting Height Of the Cell Header
//=============================================================//
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    
}
