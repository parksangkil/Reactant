//
//  PagingCollectionView.swift
//  Reactant
//
//  Created by Filip Dolnik on 16.02.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import RxSwift

open class PagingCollectionView<CELL: UIView>: SimpleCollectionView<CELL> where CELL: Component {
    
    open override var configuration: Configuration {
        didSet {
            configuration.get(valueFor: Properties.Style.CollectionView.pageControl)(pageControl)
        }
    }
    
    open var showPageControl: Bool {
        get {
            return pageControl.visibility == .visible
        }
        set {
            pageControl.visibility = newValue ? .visible : .hidden
        }
    }
    
    public let pageControl = UIPageControl()
    
    public override init(cellFactory: @escaping () -> CELL = CELL.init, reloadable: Bool = true) {
        super.init(cellFactory: cellFactory, reloadable: reloadable)
    }
    
    open override func loadView() {
        super.loadView()
        
        children(
            pageControl
        )
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
    }
    
    open override func setupConstraints() {
        super.setupConstraints()
        
        pageControl.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.bottom.equalTo(8)
        }
    }
    
    open override func bind(items: [MODEL]) {
        super.bind(items: items)
        
        pageControl.numberOfPages = items.count
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        itemSize = collectionView.bounds.size
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x / itemSize.width)
    }
}
