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
            [weakSelf requestLotteryHistoryFrom:dic[@"from_issueno"] toIssue:dic[@"to_issueno"] andLimit:[dic[@"limit"] intValue] withResultBlock:^(id resultArr) {
                NSArray *arr = (NSArray *)resultArr;
                if ([arr count] == 0) {
                    [subscriber sendCompleted];
                    return;
                }
                
                NSMutableArray *lotteryInServerArr = [NSMutableArray array];
                for (NSDictionary *lotteryDic in arr) {
                    TAVLotteryPO *tempPO = [[TAVLotteryPO alloc]initWithDictionary:lotteryDic];
                    [lotteryInServerArr addObject:tempPO];
                }
                
                NSMutableArray *tempArr = [NSMutableArray arrayWithArray:lotteryInServerArr];
//                [tempArr addObjectsFromArray:self.lotteryHistoryArr];

                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.lotteryHistoryArr = tempArr.copy;
                    [self saveLotteryHistory:arr];
                    [subscriber sendNext:[self createMsg:lotteryInServerArr]];
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
            
            if (resultArr.count > 0) {
                for (NSDictionary *dic in resultArr) {
                    TAVLotteryPO *po = [[TAVLotteryPO alloc]initWithDictionary:dic];
                    [poArr addObject:po];
                }
                self.lotteryHistoryArr = poArr.copy;
                
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
- (void)requestLotteryHistoryFrom:(id _Nullable)issueno toIssue:(NSString * _Nullable)toIssueno andLimit:(int)limit withResultBlock:(void (^)(id))resultBlock {

    [[TAVNetworkTool share] requestLotteryHistory:issueno == nil ? toIssueno : issueno andLimit:limit withResultBlock:^(id _Nonnull resultDic) {
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
    NSArray *hottestArr = lotteryArr.copy;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSMutableDictionary *saveDic;
        NSArray *resultInDBArr = [[TAVDatabaseTool share] queryHottestLimit200AndOrder:OrderByAsc];
        NSDictionary *resultDic = resultInDBArr.firstObject;
//        if (resultDic == nil) {
            NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
            for (int i = 0; i < 33; i++) {
                saveDic[[NSString stringWithFormat:@"rq%d", i + 1]] = @0;
            }
            for (int j = 0; j < 16; j++) {
                saveDic[[NSString stringWithFormat:@"bq%d", j + 1]] = @0;
            }
            saveDic[@"odd_even_ratio"] = @-1;
            saveDic[@"red_sum"] = @0;
            saveDic[@"issue"] = @0;
        
        int countForAnotherCondition = 200;
        
        // 新增表
        for (NSUInteger i = 0; i < hottestArr.count; i++) {
            NSDictionary *lotteryDic = hottestArr[hottestArr.count - 1 - i];
            TAVHallModel *model = [[TAVHallModel alloc]initWithDictionary:lotteryDic];
            
            int oddNum = 0;
            int redSum = 0;
            for (int j = 0; j < model.rqNumArr.count; j++) {
                id rqValue = model.rqNumArr[j];
                saveDic[[NSString stringWithFormat:@"rq%@", rqValue]] = @([saveDic[[NSString stringWithFormat:@"rq%@", rqValue]] integerValue] + 1);
                redSum += [rqValue integerValue];
                if ([rqValue integerValue] % 2 != 0) {
                    oddNum++;
                }
            }
            
            saveDic[@"odd_even_ratio"] = @(oddNum);
            saveDic[@"red_sum"] = @(redSum);
            
            saveDic[@"issue"] = lotteryDic[@"issueno"];
            
            saveDic[[NSString stringWithFormat:@"bq%d", model.bqNum.intValue]] = @([saveDic[[NSString stringWithFormat:@"bq%d", model.bqNum.intValue]] integerValue] + 1);
            
            [[TAVDatabaseTool share] saveHottest:saveDic to:countForAnotherCondition];
            NSLog(@"operation save %d", i);
        }
        
        // 更新表
        for (NSUInteger i = 0; i < resultInDBArr.count; i++) {
            NSDictionary *lotteryDic = resultInDBArr[i];
            NSEnumerator *keyEnum = [lotteryDic keyEnumerator];
            NSMutableDictionary *tempDic = saveDic.mutableCopy;
            
            
            id keyStr;
            while (keyStr = [keyEnum nextObject]) {
                if ([keyStr containsString:@"bq"] || [keyStr containsString:@"rq"]) {
                    tempDic[keyStr] = @([saveDic[keyStr] integerValue] + [lotteryDic[keyStr] integerValue]);
                }
                
            }
            tempDic[@"issue"] = lotteryDic[@"issue"];
            
            [[TAVDatabaseTool share] updateHottest:tempDic.copy to:countForAnotherCondition];
            NSLog(@"operation update %lu %@", (unsigned long)i, tempDic[@"rq1"]);
        }
        
        NSArray *resultArr = [[TAVDatabaseTool share] queryHottestLimit200AndOrder:OrderByDesc];
        if (resultArr.count > 200) {
            [[TAVDatabaseTool share] deleteHottest:resultArr.lastObject];
        }


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

