//
//  TAVHallModel.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallModel.h"

@interface TAVHallModel()

@end
@implementation TAVHallModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.lotteryTime = dic[@"opendate"];
        self.issueNo = dic[@"issueno"];
        self.bqNum = dic[@"refernumber"];
        self.sales = dic[@"saleamount"];
        self.jackpot = dic[@"totalmoney"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"number"]) {
        NSArray *redBallArr = [value componentsSeparatedByString:@" "];
        NSMutableArray *redArr = [NSMutableArray arrayWithCapacity:6];
        for (NSString *red in redBallArr) {
            [redArr addObject: [NSNumber numberWithInteger:[red integerValue]]];
        }
        self.rqNumArr = redArr.copy;
    }
    
    if ([key isEqualToString:@"prize"]) {
        NSMutableArray *numArr = [NSMutableArray arrayWithCapacity:6];
        NSMutableArray *moneyArr = [NSMutableArray arrayWithCapacity:6];
        for (NSDictionary *dic in value) {
            [numArr addObject:dic[@"num"]];
            [moneyArr addObject:dic[@"singlebonus"]];
        }
        self.prizeNumArr = numArr.copy;
        self.prizeMoneyArr = moneyArr.copy;
    }
    
}


@end
