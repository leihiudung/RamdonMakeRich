//
//  TAVHallModel.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVBasicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVHallModel : TAVBasicModel

@property (nonatomic, strong) NSString *lotteryTime; //开奖日期 2020-01-01
@property (nonatomic, strong) NSNumber *issueNo; // 期数
@property (nonatomic, strong) NSArray *rqNumArr;
@property (nonatomic, strong) NSNumber *bqNum;
@property (nonatomic, strong) NSNumber *sales; // 销售额
@property (nonatomic, strong) NSNumber *jackpot; // 奖池

@property (nonatomic, strong) NSArray *prizeNumArr;
@property (nonatomic, strong) NSArray *prizeMoneyArr;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
