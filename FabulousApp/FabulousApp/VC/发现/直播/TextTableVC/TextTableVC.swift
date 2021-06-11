//
//  TextTableVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/31.
//

import Foundation

class TextTableVC: UIViewController, PageVCDelegate, UITableViewDataSource, UITableViewDelegate, FoldTextCellDelegate {
    
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
        if model.actualHeight > model.foldHeight {
            if model.isOpen {
                return model.actualHeight + rem(40)
            } else {
                return model.foldHeight + rem(40)
            }
        } else {
            return model.actualHeight + rem(40)
        }
    }
    
    
    //MARK: - FoldTextCellDelegate
    func foldTextCellDidTapOpenClose(toOpen: Bool, index: Int) {
        print("toOpen:\(toOpen),index:\(index)")
        var newModel = dataArray[index]
        newModel.isOpen = toOpen
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
    lazy var dataArray = [TextModel(text: "天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨"),TextModel(text: "天青色等烟雨天"),TextModel(text: "天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨"),TextModel(text: "天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨"),TextModel(text: "天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等烟雨天青色等")]
    
    
}
