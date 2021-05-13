//
//  MomentVC.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation
import Kingfisher
import ESPullToRefresh

class MomentListVC: UIViewController, PageVCProtocol, UICollectionViewDataSource, UICollectionViewDelegate, WaterfallLayoutDelegate {
    
    //MARK: - PageVCProtocol
    func pageVCDidAppear() {
        
    }
    
    
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
        if indexPath.row == dataArray.count - PAGE_SIZE {
            loadMoreData()
        }
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
            if isFromStart {
                self.collectionView.es.stopPullToRefresh()
            } else {
                self.collectionView.es.stopLoadingMore()
            }
            switch result {
            case .success(let dataModel):
                print(dataModel.description)
                self.downloadImages(dataArray: dataModel.items) {
                    self.dataArray = dataModel.totalItems //苹果已做局部刷新优化
                    self.collectionView.reloadData()
                    if self.dataArray.isEmpty {
                        self.blankView.showNoData()
                    } else {
                        self.blankView.hide()
                        if dataModel.hasMore == false {
                            self.collectionView.es.noticeNoMoreData()
                        }
                    }
                }
            case .failure(let error):
                if isFromStart {
                    self.dataArray = []
                    self.collectionView.reloadData()
                    self.blankView.showError(error)
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
                    completion() //框架已经做了线程转换
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
        collectionView.es.addPullToRefresh(animator: refreshHeader) { [unowned self] in
            self.reloadData()
        }
        collectionView.es.addInfiniteScrolling(animator: loadMoreFooter)  { [unowned self] in
            self.loadMoreData()
        }
        return collectionView
    }()
        
    lazy var refreshHeader: ESRefreshHeaderAnimator = {
        let refreshHeader = ESRefreshHeaderAnimator.init()
        refreshHeader.loadingDescription = "正在刷新数据中..."
        refreshHeader.releaseToRefreshDescription = "松开立即刷新"
        refreshHeader.pullToRefreshDescription = "下拉可以刷新"
        return refreshHeader
    }()
    
    lazy var loadMoreFooter: ESRefreshFooterAnimator = {
        let loadMoreFooter = ESRefreshFooterAnimator()
        loadMoreFooter.loadingDescription = "正在加载更多的数据..."
        loadMoreFooter.loadingMoreDescription = "上拉加载更多"
        loadMoreFooter.noMoreDataDescription = "已经全部加载完毕"
        return loadMoreFooter
    }()
    
    lazy var flowLayout: WaterfallLayout = {
        let flowLayout = WaterfallLayout(columnCount: 2, delegate: self)
        flowLayout.setup(columnSpacing: rem(5), rowSpacing: rem(5), sectionInset: UIEdgeInsets(top: rem(5), left: rem(5), bottom: rem(5), right: rem(5)))
        return flowLayout
    }()
    
    lazy var blankView = BlankView()
    
    //MARK: - Data
    var dataArray = [MomentItemModel]()
    
    let columnCount = 2
    
    var itemWidth: CGFloat = 0
        
}

