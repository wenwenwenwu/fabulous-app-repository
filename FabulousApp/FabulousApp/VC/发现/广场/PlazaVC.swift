//
//  PlazaVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

class PlazaVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        plazaInfoRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = dataModel else { return 0 }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = dataModel else { return 0 }
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let sceneTypeCell = CreateTool.cellWith(className: PlazaCell_Type.self, tableView: tableView)
                sceneTypeCell.setupSceneTypeLayout()
                sceneTypeCell.setup(modelArray: sceneTypeCellModelArray)
                return sceneTypeCell
            } else {
                let goalTypeCell = CreateTool.cellWith(className: PlazaCell_Type.self, tableView: tableView)
                goalTypeCell.setupGoalTypeLayout()
                goalTypeCell.setup(modelArray: goalTypeCellModelArray)
                return goalTypeCell
            }
        } else {
            let userCell = CreateTool.cellWith(className: PlazaCell_User.self, tableView: tableView)
            userCell.setupUserLayout()
            userCell.setup(modelArray: userCellModelArray)
            return userCell
        }
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlazaCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = PlazaSectionHeader()
        if section == 0 {
            sectionHeader.setup(title: "穿搭广场")
        } else {
            sectionHeader.setup(title: "时尚改造师")
        }
        return sectionHeader        
    }
    
    //MARK: - Request
    func plazaInfoRequest() {
        Store.plazaInfoRequest { result in
            switch result {
            case .success(let dataModel):
                self.dataModel = dataModel
                self.tableView.reloadData()
            case .failure(let error):
                HudTool.showInfoHud(error.errMsg)
            }
        }
    }
    
    //MARK: - Method
    
    //MARK: - Component
    lazy var tableView: UITableView = {
        let tableView = CreateTool.tableViewWith(style: .plain, backgroundColor: WHITE_FFFFFF, dataSource: self, delegate: self)
        tableView.sectionHeaderHeight = rem(30)
        return tableView
    }()
    
    //MARK: - Data
    var dataModel: PlazaModel!
    
    var sceneTypeCellModelArray: [PlazaTypeCellModel] {
        let dataArray = dataModel.publish.info.map({ item in
            return PlazaTypeCellModel(imageURL: item.extProps.iconURL, title: item.name)
        })
        return dataArray
    }
    
    var goalTypeCellModelArray: [PlazaTypeCellModel] {
        let dataArray1 = dataModel.styleWoman.info.map({ item in
            return PlazaTypeCellModel(imageURL: item.extProps.iconURL, title: item.name)
        })
        let dataArray2 = dataModel.needs.info.map({ item in
            return PlazaTypeCellModel(imageURL: item.extProps.womanURL, title: item.name)
        })
        
        return dataArray1 + dataArray2
    }
    
    var userCellModelArray: [PlazaOUserInfoItemModel] {
        return dataModel.oUser.info
    }
    
}
