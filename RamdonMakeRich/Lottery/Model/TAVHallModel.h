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
@property (nonatomic, strong) NSNumber *rq0Num;
@property (nonatomic, strong) NSNumber *rq1Num;
@property (nonatomic, strong) NSNumber *rq2Num;
@property (nonatomic, strong) NSNumber *rq3Num;
@property (nonatomic, strong) NSNumber *rq4Num;
@property (nonatomic, strong) NSNumber *rq5Num;
@property (nonatomic, strong) NSNumber *bqNum;
@property (nonatomic, strong) NSNumber *sales; // 销售额
@property (nonatomic, strong) NSNumber *jackpot; // 奖池

@property (nonatomic, strong) NSArray *prizeNumArr;
@property (nonatomic, strong) NSArray *prizeMoneyArr;

@property (nonatomic, strong) NSNumber *firstPrizeNum;
@property (nonatomic, strong) NSNumber *firstPrizeMoney;


@property (nonatomic, strong) NSNumber *secondPrizeNum;
@property (nonatomic, strong) NSNumber *secondPrizeMoney;


@property (nonatomic, strong) NSNumber *thirdPrizeNum;
@property (nonatomic, strong) NSNumber *thirdPrizeMoney;

@property (nonatomic, strong) NSNumber *fouthPrizeNum;
@property (nonatomic, strong) NSNumber *fourthPrizeMoney;

@property (nonatomic, strong) NSNumber *fifthPrizeNum;
@property (nonatomic, strong) NSNumber *fifthPrizeMoney;

@property (nonatomic, strong) NSNumber *sixthPrizeNum;
@property (nonatomic, strong) NSNumber *sixthPrizeMoney;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
