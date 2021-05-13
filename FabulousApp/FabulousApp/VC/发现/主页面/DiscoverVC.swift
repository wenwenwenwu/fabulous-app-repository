//
//  DiscoverVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/13.
//

import UIKit

class DiscoverVC: UIViewController, PageViewDelegate, SelectViewDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_FFFFFF
        view.addSubview(pageView)
        view.addSubview(selectView)
        pageView.delegate = self
        selectView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(rem(80))
        }
        pageView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    //MARK: - PageViewDelegate
    func pageViewDidChangePage(_ currentPageIndex: Int) {
        selectView.setup(currentPageIndex)
    }
    
    //MARK: - SelectViewDelegate
    func selectViewDidTapButton(_ currentIndex: Int) {
        pageView.page(currentIndex)
    }
    
    //MARK: - Component
    lazy var pageView = PageView(ownerVC: self, pageVCArray: [plazaVC, momentListVC])
    
    lazy var momentListVC = MomentListVC()
    
    lazy var plazaVC = PlazaVC()
    
    lazy var selectView = SelectView(titleArray: ["广场","动态"])
    
}
