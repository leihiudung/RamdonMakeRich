//
//  TAVLotteryPO.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

//#import "TAVBasicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVLotteryPO : NSObject

@property (nonatomic, strong) NSString *lottery_time; //开奖日期 2020-01-01
@property (nonatomic, strong) NSNumber *issus; // 期数
@property (nonatomic, strong) NSArray *rqNumArr;
@property (nonatomic, strong) NSNumber *rq1;
@property (nonatomic, strong) NSNumber *rq2;
@property (nonatomic, strong) NSNumber *rq3;
@property (nonatomic, strong) NSNumber *rq4;
@property (nonatomic, strong) NSNumber *rq5;
@property (nonatomic, strong) NSNumber *rq6;
@property (nonatomic, strong) NSNumber *bq;
@property (nonatomic, strong) NSNumber *sold_in_all; // 销售额
@property (nonatomic, strong) NSNumber *jackpot; // 奖池

@property (nonatomic, strong) NSArray *prizeNumArr;
@property (nonatomic, strong) NSArray *prizeMoneyArr;

@property (nonatomic, strong) NSNumber *first_prize_winner;
@property (nonatomic, strong) NSNumber *first_prize_money;


@property (nonatomic, strong) NSNumber *second_prize_winner;
@property (nonatomic, strong) NSNumber *second_prize_money;

@property (nonatomic, strong) NSNumber *third_prize_winner;
@property (nonatomic, strong) NSNumber *third_prize_money;

@property (nonatomic, strong) NSNumber *fouth_prize_winner;
@property (nonatomic, strong) NSNumber *fouth_prize_money;

@property (nonatomic, strong) NSNumber *fifth_prize_winner;
@property (nonatomic, strong) NSNumber *fifth_prize_money;

@property (nonatomic, strong) NSNumber *sixth_prize_winner;
@property (nonatomic, strong) NSNumber *sixth_prize_money;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
