//
//  LiveVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/17.
//

import UIKit

class LiveVC: UIViewController, PageViewDelegate, SelectViewNewDelegate, SelectViewDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_FFFFFF
        view.addSubview(searchView)
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
        searchView.snp.makeConstraints { (make) in
            make.height.equalTo(rem(60))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        selectView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom)
            make.height.equalTo(rem(40))
        }
        pageView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .SCROLL_UP, object: nil)

    }
    
    //MARK: - PageViewDelegate
    func pageViewDidScroll(_ scrollRatio: CGFloat) {
        selectView.moveSliderBar(scrollRatio)
    }
    
    func pageViewDidChangePage(_ currentPageIndex: Int) {
        selectView.select(currentPageIndex)
    }
    
    //MARK: - SelectViewNewDelegate
    func selectViewDidTapButton(_ currentTitleIndex: Int) {
        pageView.select(currentTitleIndex)
    }
    
    //MARK: - Action
    @objc func pageViewDidScrollUp() {
//        setupLayout(isUp: true)
    }
    
    //MARK: - Setup
    
    //MARK: - Component
    lazy var searchView = SearchView()
    
    lazy var pageView = PageView(ownerVC: self, pageVCArray: [ViewController(), ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController(),ViewController()])
    
    
    
    lazy var selectView = SelectViewNew(titleArray: ["第一天","第二天","第三天","第四天","第五天","第六天","第七天","第八天","第九天","第十天","第十一天","第十二天","第十三天","第十四天","第十五天","第十六天","第十七天","第十八天","第十九天","第二十天","第二十一天","第二十二天"])
    
}

