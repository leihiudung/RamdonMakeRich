

//
//  TAVHistoryViewController.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHistoryViewController.h"
#import "TAVHallViewModel.h"
#import "TAVLotteryPO.h"

/**
 先到数据中查询最新10条记录,当存在就显示.不存在就向服务器加载
 */

@interface TAVHistoryViewController ()

@end

@implementation TAVHistoryViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self)weakSelf = self;
    [[((TAVHallViewModel *)self.viewModel).queryLotteryHistoryCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        NSArray *arr = x;
        if (arr.count == 0) {
            [weakSelf requestSomeHistory];
            return;
        }
        for (TAVLotteryPO *lotteryPO in arr) {
            NSLog(@"done");
        }
        
    }];
    
}


- (void)requestSomeHistory {
    NSDictionary *paramDic = @{};
    
    __weak typeof(self)weakSelf = self;
    [[[(TAVHallViewModel *)self.viewModel requestLotteryHistoryCommand] execute:paramDic] subscribeNext:^(id  _Nullable x) {
       NSDictionary *dic = (NSDictionary *)x;
       if ([dic[@"state"] integerValue] == -1) {
           
           return;
       }

    } error:^(NSError * _Nullable error) {
       
    } completed:^{
        
    }];
}

@end
