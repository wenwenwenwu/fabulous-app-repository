//
//  MomentVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation
import Kingfisher
import ESPullToRefresh

class MomentListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, WaterfallLayoutDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(blankView)
        title = "发现"
        reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        blankView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "momentCell", for: indexPath) as! MomentCell
        cell.setup(model: dataArray[indexPath.row])
        return cell

    }
    
    //MARK: - MomentWaterfallLayoutDelegate
    func momentWaterfallLayoutItemHeight(for itemWidth: CGFloat, at indexPath: IndexPath) -> CGFloat {
        let heightWidthRatio = dataArray[indexPath.row].cover.heightWidthRatio
        return itemWidth * heightWidthRatio + rem(40)
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == dataArray.count - PAGE_SIZE {
//            loadMoreData()
//        }
    }
    
    //MARK: - Action
    @objc func reloadData() {
        momentListRequest(isFromStart: true)
    }
    
    @objc func loadMoreData() {
        momentListRequest(isFromStart: false)
    }
    
    //MARK: - Request
    func momentListRequest(isFromStart: Bool) {
        Store.momentListPagingRequest(isFromStart: isFromStart) { result in
            switch result {
            case .success(let dataModel):
                print(dataModel.description)
                self.collectionView.es.stopPullToRefresh()
//                self.collectionView.mj_header!.endRefreshing()
                self.downloadImages(dataArray: dataModel.items) {
                    self.dataArray = dataModel.totalItems
                    self.collectionView.reloadData()
                    if self.dataArray.isEmpty {
                        self.blankView.showNoData()
                    } else {
                        self.blankView.hide()
                        self.collectionView.es.stopLoadingMore()
                        if dataModel.hasMore == false {
//                            self.collectionView.mj_footer?.endRefreshingWithNoMoreData()
                            self.collectionView.es.noticeNoMoreData()
                        }
                    }
                }
            case .failure(let error):
                if isFromStart {
                    self.collectionView.es.stopPullToRefresh()
                    self.dataArray = []
                    self.blankView.showError(error)
                    self.collectionView.reloadData()
                } else {
                    HudTool.showInfoHud(error.errMsg)
                }
            }
        }
    }
    
    //MARK: - Method
    func downloadImages(dataArray: [MomentItemModel], completion : @escaping (() -> Void)) {
        var imageURLArray = [URL]()
        for item in dataArray {            
            if let coverURL = item.cover.realURL {
                imageURLArray.append(coverURL)
            }
            if let avatarURL = item.user.avatarURL {
                imageURLArray.append(avatarURL)
            }
        }
        let prefetcher = ImagePrefetcher.init(urls: imageURLArray) { _,_,_  in
            completion()
        }
        prefetcher.start()
    }
    
    
    
    //MARK: - Component
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = GRAY_F0F0F0
        collectionView.register(MomentCell.self, forCellWithReuseIdentifier: "momentCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        let header = ESRefreshHeaderAnimator.init()
        header.loadingDescription = "加载中"
//        collectionView.es.addPullToRefresh { [unowned self] in
//            self.reloadData()
//        }
        collectionView.es.addPullToRefresh(animator: header) { [unowned self] in
            self.reloadData()
        }
        collectionView.es.addInfiniteScrolling { [unowned self] in
            self.loadMoreData()
        }
//        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(reloadData))
//        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        return collectionView
    }()
    
    lazy var blankView = BlankView()
    
    lazy var flowLayout: WaterfallLayout = {
        let flowLayout = WaterfallLayout(columnCount: 2, delegate: self)
        flowLayout.setup(columnSpacing: rem(5), rowSpacing: rem(5), sectionInset: UIEdgeInsets(top: rem(5), left: rem(5), bottom: rem(5), right: rem(5)))
        return flowLayout
    }()
    
    //MARK: - Data
    var dataArray = [MomentItemModel]()
    
    let columnCount = 2
    
    var itemWidth: CGFloat = 0
        
}

