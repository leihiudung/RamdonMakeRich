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
            [weakSelf requestLotteryHistoryFrom:dic[@"from_index"] toIssue:dic[@"to_index"] withResultBlock:^(id resultArr) {
                NSArray *arr = (NSArray *)resultArr;
                if ([arr count] == 0) {
                    [subscriber sendCompleted];
                    return;
                }
                [self saveLotteryHistory:arr];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [subscriber sendNext:[self createMsg:[self parseInHistoryPO:arr]]];
                    [subscriber sendCompleted];
                });
                
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
            NSArray *resultArr = resultDic[@"data"];
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

    [[TAVNetworkTool share] requestLotteryHistory:issueno == nil ? toIssueno : issueno withResultBlock:^(id _Nonnull resultDic) {
        NSDictionary *dic = resultDic;
        NSMutableArray *modelArr = [NSMutableArray array];
        if (dic != nil && [dic objectForKey:@"data"]) {
            [modelArr addObjectsFromArray:dic[@"data"][@"list"]];
        }
        resultBlock(modelArr.copy);
    }];
    
}

- (void)saveLotteryHistory:(NSArray *)lotteryArr {
    for (NSDictionary *lotteryDic in lotteryArr) {
        TAVHallModel *model = [[TAVHallModel alloc]initWithDictionary:lotteryDic];
        BOOL saveFlag = [[TAVDatabaseTool share] saveLottery:model];
        
    }
    __block NSArray *hottestArr = lotteryArr.copy;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *saveDic;
        NSDictionary *resultDic = [[TAVDatabaseTool share] queryHottestLimit:@1].firstObject;
        if (resultDic == nil) {
            saveDic = [NSMutableDictionary dictionary];
            for (int i = 0; i < 33; i++) {
                saveDic[[NSString stringWithFormat:@"rq%d", i + 1]] = @0;
            }
            for (int j = 0; j < 16; j++) {
                saveDic[[NSString stringWithFormat:@"bq%d", j + 1]] = @0;
            }
            saveDic[@"odd_even_ratio"] = @-1;
            saveDic[@"red_sum"] = @0;
            saveDic[@"issue"] = @0;
        } else {
            saveDic = resultDic.mutableCopy;
        }
        
        
        for (NSUInteger i = hottestArr.count - 1; i > 0; i--) {
            NSDictionary *lotteryDic = hottestArr[i];
            TAVHallModel *model = [[TAVHallModel alloc]initWithDictionary:lotteryDic];
            
            int oddNum = 0;
            int redSum = 0;
            for (int i = 0; i < model.rqNumArr.count; i++) {
                id rqValue = model.rqNumArr[i];
                saveDic[[NSString stringWithFormat:@"rq%@", rqValue]] = @([saveDic[[NSString stringWithFormat:@"rq%@", rqValue]] integerValue] + 1);
                redSum += [rqValue integerValue];
                if ([rqValue integerValue] % 2 != 0) {
                    oddNum++;
                }
            }
            saveDic[@"odd_even_ratio"] = @(oddNum);
            saveDic[@"red_sum"] = @(redSum);
            
            saveDic[@"issue"] = lotteryDic[@"issueno"];
            
            saveDic[[NSString stringWithFormat:@"bq%@", model.bqNum]] = @([saveDic[[NSString stringWithFormat:@"bq%@", model.bqNum]] integerValue] + 1);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[TAVDatabaseTool share] saveHottest:saveDic];
            });

        }
        
    });

}

- (NSArray *)parseInHistoryPO:(NSArray *)histories {
    NSMutableArray *lotteryArr = [NSMutableArray array];
    for (NSDictionary *lotteryDic in histories) {
        TAVLotteryPO *lotteryPO = [[TAVLotteryPO alloc]initWithDictionary:lotteryDic];
        [lotteryArr addObject:lotteryPO];
    }
    return lotteryArr.copy;
}

- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssue:(id _Nullable)toIssueno withLimit:(id)limit {
    NSDictionary *resultDic = [[TAVDatabaseTool share] queryLotteryHistory:issueno toIssueno:toIssueno andLimit:limit];
    
    return resultDic;
}


@end
