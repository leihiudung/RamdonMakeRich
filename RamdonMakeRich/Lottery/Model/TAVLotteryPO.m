//
//  TAVLotteryPO.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVLotteryPO.h"
#import <objc/runtime.h>

#define rqNum(num) rq##num

@interface TAVLotteryPO()


@end

@implementation TAVLotteryPO

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
//        self.prize_winner_arr = @[self.first_prize_winner, self.second_prize_winner, self.third_prize_winner, self.fourth_prize_winner, self.fifth_prize_winner, self.sixth_prize_winner];
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"opendate"]) {
        self.lottery_time = value;
    } else if ([key isEqualToString:@"issueno"]) {
        self.issue = value;
    } else if ([key isEqualToString:@"refernumber"]) {
        self.bq = value;
    } else if ([key isEqualToString:@"saleamount"]) {
        self.sold_in_all = value;
    } else if ([key isEqualToString:@"totalmoney"]) {
        self.jackpot = value;
    } else if ([key isEqualToString:@"refernumber"]) {
        self.bq = value;
    } else if ([key isEqualToString:@"number"]) {
        NSArray *redBallArr = [value componentsSeparatedByString:@" "];
        NSMutableArray *redArr = [NSMutableArray arrayWithCapacity:6];
        
//        objc_property_t properties = class_getProperty([self class], <#const char * _Nonnull name#>)
        
        for (NSString *red in redBallArr) {
            const char *redName = [[NSString stringWithFormat:@"_rq%lu", (unsigned long)[redBallArr indexOfObject:red] + 1] cStringUsingEncoding:NSUTF8StringEncoding];
            objc_property_t properties = class_getProperty([self class], redName);
            Ivar ivar = class_getInstanceVariable([TAVLotteryPO class], redName);
            object_setIvar(self, ivar, [NSNumber numberWithInt:red.intValue]);
            
        }
        self.rqNumArr = redArr.copy;
    } else if ([key isEqualToString:@"prize"]) {
        if ([value isKindOfClass:[NSNumber class]] && ![value boolValue]) {
            return;
        }
        
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
