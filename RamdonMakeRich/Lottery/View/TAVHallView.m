//
//  TAVHallView.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallView.h"
#import "TAVHallCollectionViewCell.h"
#import "TAVHallCollectionViewCellLayout.h"
#import "TAVHallViewModel.h"

#import "TAVHistoryViewController.h"

static NSString *CellId = @"HallCellId";

@interface TAVHallView () 
//@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) TAVHallViewModel *viewModel;
@end
@implementation TAVHallView

- (instancetype)initWithFrame:(CGRect)frame withViewModel:(TAVBasicViewModel *)viewModel {
    self = [super initWithFrame:frame];
    if (self) {
        [self customerView];
        self.viewModel = (TAVHallViewModel *)viewModel;
    }
    return self;
}

- (void)customerView {
    
    self.dataArr = @[@"当期结果", @"历史", @"心水推荐", @"手动录入", @"待开发", @"彩种", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发", @"待开发"];
    
    TAVHallCollectionViewCellLayout *flowLayout = [[TAVHallCollectionViewCellLayout alloc]init];
//    [flowLayout setItemSize:CGSizeMake(self.frame.size.width * 0.5, self.frame.size.width * 0.5)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];/
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
//    [self.collectionView setScrollEnabled:YES];
    
    [self.collectionView registerClass:[TAVHallCollectionViewCell class] forCellWithReuseIdentifier:CellId];
    [self addSubview:self.collectionView];
}

- (void)setDelegate {
//    [self.collectionView setDelegate:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TAVHallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    
    [cell setBackgroundColor: [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:(int)arc4random_uniform(255) / 255.0 alpha:1.0]];
    
//    [cell setBackgroundColor:[UIColor blueColor]];
    cell.titleLabel.text = self.dataArr[indexPath.item];
//    UILabel *lable = [[UILabel alloc]initWithFrame:cell.frame];
//    [lable setText:self.dataArr[indexPath.item]];
//    [cell addSubview:lable];
    return cell;
}

// 在将对象设置为委托之前,请确保调用-rac_signalForSelector:.某些Apple框架会在设置委托对象时检查您的类是否响应某个委托方法选择器,并缓存该信息,因此,如果那时您尚未调用-rac_signalForSelector：并且您未明确实现方法,这些委托方法将永远不会被调用.
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


}


@end
