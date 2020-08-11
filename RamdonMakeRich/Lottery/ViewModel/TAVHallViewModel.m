//
//  TAVBasicViewModel.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallViewModel.h"
#import "TAVHallModel.h"
#import "TAVLotteryPO.h"

@interface TAVHallViewModel()

@end

@implementation TAVHallViewModel

- (instancetype)initWitnViewModelProtocol:(id<TAVViewModelProtocol>)viewModelPro {
    self = [super initWitnViewModelProtocol:viewModelPro];
    if (self) {
//        self.viewModelPro = viewModelPro;
    }
    return self;
}

- (void)initCommand {
    [super initCommand];
    
    __weak typeof(self)weakSelf = self;
    self.requestLotteryHistoryCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            if ([input isKindOfClass:[NSArray class]]) {
                return nil;
            }
            NSDictionary *dic = (NSDictionary *)input;
            [weakSelf requestLotteryHistoryFrom:dic[@"from_index"] toIssue:dic[@"to_index"] withResultBlock:^(id resultDic) {
                NSDictionary *dic = (NSDictionary *)resultDic;
                if ([dic[@"state"] integerValue] == -1) {
                    [subscriber sendCompleted];
                    return;
                }
                [self saveLotteryHistory:dic[@"msg"]];
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
            }];
            
            
            return nil;
        }];
        return signal;
    }];
    
    self.queryLotteryHistoryCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSDictionary *dic = input;
            NSDictionary *resultDic = [self queryLotteryHistory:dic[@"from_issueno"] toIssue:dic[@"to_issueno"] withLimit:dic[@"limit"]];
            if ([dic[@"state"] integerValue] == -1) {
                [subscriber sendCompleted];
                return nil;
            }
            
            NSMutableArray *poArr = [NSMutableArray array];
            NSArray *resultArr = resultDic[@"msg"];
            for (NSDictionary *dic in resultArr) {
                TAVLotteryPO *po = [[TAVLotteryPO alloc]initWithDictionary:dic];
                [poArr addObject:po];
            }
            [subscriber sendNext:poArr.copy];
            [subscriber sendCompleted];
            return nil;
        }];
        return signal;
    }];
    
    
}

/// 加载lottery的历史信息
/// @param issueno 开始期数
/// @param toIssueno 结束期数
- (void)requestLotteryHistoryFrom:(id _Nullable)issueno toIssue:(NSString * _Nullable)toIssueno withResultBlock:(void (^)(id))resultBlock {
//    if (issueno == nil && toIssueno == nil) {
//        return;
//    }
    [[TAVNetworkTool share] requestLotteryHistory:issueno == nil ? toIssueno : issueno withResultBlock:^(id _Nonnull resultDic) {
        resultBlock(resultDic);
    }];
    
}

- (void)saveLotteryHistory:(NSArray *)histories {
    for (TAVHallModel *model in histories) {
        [[TAVDatabaseTool share] saveLottery:model];
    }
}

- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssue:(id _Nullable)toIssueno withLimit:(id)limit {
    NSDictionary *resultDic = [[TAVDatabaseTool share] queryLotteryHistory:issueno toIssueno:toIssueno andLimit:limit];
    
    return resultDic;
}


@end
