//
//  MineVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import Foundation

class MineVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - LifeCycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreateTool.cellWith(className: UITableViewCell.self, tableView: tableView)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        zoomHeader.offsetY = offsetY
    }
    
    //MARK: - Component
    lazy var tableView: UITableView = {
        let tableView = CreateTool.tableViewWith(style: .plain, backgroundColor: UIColor.white, dataSource: self, delegate: self)
        //设置tableHeaderView
        tableView.tableHeaderView = zoomHeader
        tableView.tableHeaderView?.height = zoomHeader.backImageSize.height
        return tableView
    }()
    
    lazy var zoomHeader = ZoomHeader()
        
}
