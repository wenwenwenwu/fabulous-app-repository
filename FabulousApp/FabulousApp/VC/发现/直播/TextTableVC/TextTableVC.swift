//
//  TextTableVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/31.
//

import Foundation

class TextTableVC: UIViewController, PageVCDelegate, UITableViewDataSource, UITableViewDelegate, FoldTextCellDelegate {
    
    //MARK: - LifeCycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_FFFFFF
        view.addSubview(tableView)
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreateTool.cellWith(className: FoldTextCell.self, tableView: tableView)
        cell.delegate = self
        cell.setupText(model: dataArray[indexPath.row], index: indexPath.row)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArray[indexPath.row]
        print("\(model.actualHeight),\(model.foldHeight)")
        let otherHeight = rem(100)
        if model.actualHeight > model.foldHeight {
            if model.isOpen {
                return model.actualHeight + otherHeight
            } else {
                return model.foldHeight + otherHeight
            }
        } else {
            return model.actualHeight + otherHeight
        }
    }
    
    
    //MARK: - FoldTextCellDelegate
    //🐶
    func foldTextCellDidTapOpenClose(index: Int) {
        let newModel = dataArray[index]
        dataArray[index] = newModel
        let selectedIndexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
    
    //MARK: - Component
    lazy var tableView: UITableView = {
        let tableView = CreateTool.tableViewWith(style: .plain, backgroundColor: WHITE_FFFFFF, dataSource: self, delegate: self)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    //MARK: - Data
    lazy var dataArray = [TextModel(text: "天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨")]
    
    
}
