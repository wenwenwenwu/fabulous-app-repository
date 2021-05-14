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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(pageViewDidScrollUp), name: .SCROLL_UP, object: nil)
        setupLayout(isUp: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        searchView.snp.makeConstraints { (make) in
//            make.height.equalTo(rem(60))
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            make.left.right.equalToSuperview()
//        }
//        selectView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(searchView.snp.bottom)
//            make.height.equalTo(rem(40))
//        }
//        pageView.snp.makeConstraints { (make) in
//            make.top.equalTo(selectView.snp.bottom)
//            make.left.bottom.right.equalToSuperview()
//        }
//    }
//
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
    
    //MARK: - SelectViewDelegate
    func selectViewDidTapButton(_ currentTitleIndex: Int) {
        pageView.select(currentTitleIndex)
    }
    
    //MARK: - Action
    @objc func pageViewDidScrollUp() {
        setupLayout(isUp: true)
    }
    
    //MARK: - Setup
    func setupLayout(isUp: Bool) {
        if isUp {
            UIView.animate(withDuration: 1) { [unowned self] in
                searchView.snp.remakeConstraints { (make) in
                    make.height.equalTo(rem(60))
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.left.equalTo(selectView.scrollViewWidth)
                    make.right.equalToSuperview()
                }
                selectView.snp.makeConstraints { (make) in
                    make.left.top.equalToSuperview()
                    make.right.equalTo(searchView.snp.left)
                    make.height.equalTo(rem(60))
                }
                pageView.snp.makeConstraints { (make) in
                    make.top.equalTo(selectView.snp.bottom)
                    make.left.bottom.right.equalToSuperview()
                }
            }
        } else {
            UIView.animate(withDuration: 1) { [unowned self] in
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
        }
    }
    
    
    //MARK: - Component
    lazy var searchView = SearchView()
    
    lazy var pageView = PageView(ownerVC: self, pageVCArray: [plazaVC, momentListVC])
    
    lazy var momentListVC = MomentListVC()
    
    lazy var plazaVC = PlazaVC()
    
    lazy var selectView = SelectView(titleArray: ["广场","动态"])
    
}
