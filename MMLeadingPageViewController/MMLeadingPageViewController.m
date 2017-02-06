//
//  MMLoadingPageViewController.m
//  MMWebLoading
//
//  Created by Tttttty on 2017/2/6.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import "MMLeadingPageViewController.h"

@interface MMLeadingPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (copy ,nonatomic )MMLeadingPageHandler setupCellHandler;
@property (copy ,nonatomic )MMLeadingPageFinishHandler finishHandler;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger count;

@end


static NSString *const MMleadingPageCellId = @"MMleadingPageCellId";

@implementation MMLeadingPageViewController

-(instancetype)initWithPageCount:(int)pageCount setupCellHandler:(MMLeadingPageHandler)setupCellHandler finishHandler
                        :(MMLeadingPageFinishHandler)finishHandler{
    
    _setupCellHandler = setupCellHandler;
    
    _finishHandler = finishHandler;
    
    _count = pageCount;

    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.pageControl];

    [self.collectionView registerClass:[MMLeadingPageCollectionViewCell class] forCellWithReuseIdentifier:MMleadingPageCellId];
    return self;

    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MMLeadingPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MMleadingPageCellId forIndexPath:indexPath];
    if (indexPath.row != self.count-1) {
        cell.finishBtn.hidden = YES;
    }else {
        cell.finishBtn.hidden = NO;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    // 设置数据
    if (self.setupCellHandler) {
        self.setupCellHandler(cell, indexPath);
    }
    return cell;
}

- (void)finishBtnOnClick:(UIButton *)finishBtn {
    if (self.finishHandler) {
        self.finishHandler(finishBtn);
    }
}

#pragma mark - getter
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.count;
        pageControl.currentPage = 0;
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:self.count];
        CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width)/2;
        // 距离屏幕下方为 50 请根据具体情况修改吧
        CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - 50.f);
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        _pageControl = pageControl;
    }
    return _pageControl;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor redColor];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}
@end
