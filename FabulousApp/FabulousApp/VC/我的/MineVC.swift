//
//  MineVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import Foundation

class MineVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(zoomBackgroundkView) //包含背景图片，可以
        view.addSubview(navBar) //透明
        view.addSubview(tableView) //header透明，高度是图片高度-navBar高度
        view.addSubview(backButton)
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
        NAV_BAR_HEIGHT = view.safeAreaInsets.top + navigationController!.navigationBar.height //此处取到的值才准
        zoomBackgroundkView.frame = CGRect(origin: .zero, size: zoomBackgroundkView.backImageSize)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(NAV_BAR_HEIGHT)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        tableView.tableHeaderView?.height = zoomBackgroundkView.backImageSize.height - NAV_BAR_HEIGHT
        backButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rem(19), height: rem(18)))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(rem(10))
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
        return 100
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tableView下拉时tableHeaderView会变长,offsetY为负;上拉时offsetY为正
        let offsetY = scrollView.contentOffset.y
        if offsetY < zoomBackgroundkView.backImageSize.height - NAV_BAR_HEIGHT {
            let realHeaderHeight = zoomBackgroundkView.backImageSize.height - NAV_BAR_HEIGHT
            zoomBackgroundkView.setup(offsetY: offsetY, realHeaderHeight: realHeaderHeight)
            navBar.setup(offsetY: offsetY, realHeaderHeight: realHeaderHeight)
            headerView.setup(offsetY: offsetY, realHeaderHeight: realHeaderHeight)
        }
    }
    
    //MARK: - Component
    lazy var zoomBackgroundkView = MineZoomView(backImage: #imageLiteral(resourceName: "header_1"))
    
    lazy var navBar = MineNavBar()
    
    lazy var tableView: UITableView = {
        let tableView = CreateTool.tableViewWith(style: .plain, backgroundColor: UIColor.clear, dataSource: self, delegate: self)
        //从状态栏顶部开始布局(保证初始的offsetY为0)
        tableView.contentInsetAdjustmentBehavior = .never
        //设置tableHeaderView
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    lazy var headerView = MineHeaderView()
    
    lazy var backButton = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "arrow-left"))
    
    var NAV_BAR_HEIGHT: CGFloat = 0
    

}
