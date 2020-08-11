//
//  TAVHallView.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAVBasicViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVHallView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;


- (instancetype)initWithFrame:(CGRect)frame withViewModel:(TAVBasicViewModel *)viewModel;

- (void)setDelegate;
@end

NS_ASSUME_NONNULL_END
