//
//  MomentVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation

class MomentListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        momentListRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreateTool.cellWith(className: UITableViewCell.self, tableView: tableView)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: - Request
    func momentListRequest() {
        Store.momentListPagingRequest(isFromStart: true) { result in
            switch result {
            case .success(let dataModel):
                smartPrint(prettyJSON(dataModel))
            case .failure(let error):
                HudTool.showInfoHud(error.errMsg)
            }
        }
    }
    
    //MARK: - Component
    lazy var tableView: UITableView = {
        let tableView = CreateTool.tableViewWith(style: .plain, backgroundColor: WHITE_FFFFFF, dataSource: self, delegate: self)
        return tableView
    }()
    
    //MARK: - Data
    
}
