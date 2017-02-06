//
//  MMLoadingPageViewController.h
//  MMWebLoading
//
//  Created by Tttttty on 2017/2/6.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMLeadingPageCollectionViewCell.h"
typedef void(^MMLeadingPageHandler)(MMLeadingPageCollectionViewCell *cell,NSIndexPath *index);
typedef void(^MMLeadingPageFinishHandler)(UIButton *sender);

@interface MMLeadingPageViewController : UIViewController

-(instancetype)initWithPageCount:(int)pageCount setupCellHandler:(MMLeadingPageHandler)setupCellHandler finishHandler
                        :(MMLeadingPageFinishHandler)finishHandler;
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (assign, nonatomic, readonly) NSInteger count;
@property (strong, nonatomic, readonly) UIPageControl *pageControl;

@end
