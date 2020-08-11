//
//  TAVHallViewController.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallViewController.h"
#import "TAVHistoryViewController.h"
#import "TAVHallView.h"

#import "TAVHallViewModel.h"
#import "TAVHistoryViewModel.h"

#import <RealReachability.h>

@interface TAVHallViewController () {
    
}
@property (assign , nonatomic , readonly) ReachabilityStatus NetWorkStatus;

@property (nonatomic, strong) TAVHallView *hallView;
@end

@implementation TAVHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GLobalRealReachability startNotifier];
//    [self customerView:NO];
    [[RACObserve(self, NetWorkStatus) skip:1] subscribeNext:^(id  _Nullable x) {
        if ([x integerValue] != 0) {
            [self customerView:YES];
            return;
        }
        [self customerView:NO];
    }];
    
    RAC(self, NetWorkStatus) = [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRealReachabilityChangedNotification object:nil] map:^id _Nullable(NSNotification * _Nullable value) {
        return @([value.object currentReachabilityStatus]);
    }] startWith:@([GLobalRealReachability currentReachabilityStatus])] distinctUntilChanged];
    
}

- (void)bindViewModel {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewframe %@", self.view);
//    [self customerView:NO];
}

- (void)customerView:(BOOL)networkFlag {
    self.hallView = [[TAVHallView alloc]initWithFrame:self.view.frame withViewModel:self.viewModel];
//    [self.hallView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.hallView];
    
    __weak typeof(self)weakSelf = self;
    [[self.hallView rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSIndexPath *param = x.second;
        if (param.item == 1) {
//            [[((TAVHallViewModel *)self.viewModel).queryLotteryHistoryCommand execute:nil] subscribeNext:^(id  _Nullable x) {
//                NSArray *arr = x;
//                if (arr.count == 0) {
//                    [weakSelf requestSomeHistory];
//                }
//
//            }];
            [weakSelf showHistoryFunction];
            
        }
       
    }];
//    [self.hallView setDelegate];
}


// 历史数据
- (void)showHistoryFunction {
    TAVHistoryViewController *historyController = [[TAVHistoryViewController alloc]initWithViewModel:self.viewModel];
    
    [self.navigationController pushViewController:historyController animated:YES];
    
}
@end
