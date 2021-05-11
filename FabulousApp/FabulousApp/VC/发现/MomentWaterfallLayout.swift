//
//  MomentWaterfallLayout.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation

protocol MomentWaterfallLayoutDelegate: AnyObject {
    func momentWaterfallLayoutItemHeight(for itemWidth: CGFloat, at indexPath: IndexPath) -> CGFloat
}

class MomentWaterfallLayout: UICollectionViewFlowLayout {
    
    /**
     瀑布流的关键：
     下一个Item加到目前最短的那一列。
     具体实现：
     🐭定义一个columnLenghtDic来实时记录每一列的长度
     🐭重写4个方法/属性，旨在重写每一个UICollectionViewLayoutAttributes对象的frame
     🐭计算长度需要用到columnSpacing, rowSpacing, sectionInset，干脆提供了一个setup简便方法
     */
    
    //MARK: - LifeCycle
    init(columnCount: Int, delegate: MomentWaterfallLayoutDelegate) {
        self.columnCount = columnCount
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OverRide
    override func prepare() {
        //初始化columnLengthDic
        for item in 1...columnCount {
            columnLengthDic[item] = sectionInset.top
        }
        //重写每一个UICollectionViewLayoutAttributes对象的frame
        self.attributesArray.removeAll()
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        for item in 0..<itemCount {
            let indexPath = IndexPath(row: item, section: 0)
            let attributes = layoutAttributesForItem(at: indexPath)
            attributesArray.append(attributes)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath as IndexPath)
        let contentWidth:CGFloat = collectionView!.width - sectionInset.left - sectionInset.right
        let itemWidth = (contentWidth - minimumInteritemSpacing * CGFloat(self.columnCount - 1)) / CGFloat.init(self.columnCount)
        let itemHeight = delegate.momentWaterfallLayoutItemHeight(for: itemWidth, at: indexPath) //外界计算得到
        //找出最短列
        var shortestColumn = 1 //先假设第一列是最短列
        for item in columnLengthDic { //遍历每一列的长度，一旦小于最短列，该列就是最短列
            if item.value < columnLengthDic[shortestColumn]! {
                shortestColumn = item.key
            }
        }
        //新的item加到最短列下
        let itemX = sectionInset.left + (minimumInteritemSpacing + itemWidth) * CGFloat(shortestColumn - 1)
        let itemY = columnLengthDic[shortestColumn]! + minimumLineSpacing
        attributes.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
        //保存最短列的新长度
        columnLengthDic[shortestColumn] = attributes.frame.maxY
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            //找出最长列
            var longestColumn = 1 //先假设第一列是最短列
            for item in columnLengthDic { //遍历每一列的长度，一旦大于最长列，该列就是最长列
                if item.value > columnLengthDic[longestColumn]!  {
                    longestColumn = item.key
                }
            }
            return CGSize(width: 0, height: columnLengthDic[longestColumn]! + sectionInset.bottom)
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    //MARK: - Setup
    func setup(columnSpacing: CGFloat, rowSpacing: CGFloat, sectionInset: UIEdgeInsets) {
        self.minimumInteritemSpacing = columnSpacing //列间距
        self.minimumLineSpacing = rowSpacing //行间距
        self.sectionInset = sectionInset
    }
    
    //MARK: - Component
    weak var delegate: MomentWaterfallLayoutDelegate!
    
    //MARK: - Data
    var columnCount: Int
    
    var columnLengthDic = [Int : CGFloat]() //记录列最大Y值的字典
    
    var attributesArray = [UICollectionViewLayoutAttributes]()
    
    
}
