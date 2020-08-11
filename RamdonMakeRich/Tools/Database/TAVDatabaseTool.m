//
//  DatabaseTool.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/1.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVDatabaseTool.h"
#import "TAVHallModel.h"
#import <FMDB/FMDB.h>

@interface TAVDatabaseTool ()
@property (nonatomic, strong) FMDatabase *db;

@end
@implementation TAVDatabaseTool

static TAVDatabaseTool *databaseTool;

+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseTool = [[self alloc]init];
    });
    return databaseTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseTool = [super allocWithZone:zone];
    });
    return databaseTool;
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return [TAVDatabaseTool share];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [TAVDatabaseTool share];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDatabase];
    }
    return self;
}

- (void)initDatabase {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:@"lottle.sqlite"];
    _db = [FMDatabase databaseWithPath:filePath];
    if (_db) {
        [self createTable];
    } else {
        NSLog(@"建立数据库失败");
    }
    
    
}

- (void)createTable {
    NSString *ballTable = @"create table t_issue (id integer primary key autoincrement, rq1 integer, rq2 integer, rq3 integer, rq4 integer, rq5 integer, rq6 integer, bq integer, sold_in_all integer, first_prize_winner integer, first_prize_money integer, second_prize_winner integer, second_prize_money integer, third_prize_winner integer, third_prize_money integer, fourth_prize_winner integer default 0, fourth_prize_money integer default 0, fifth_prize_winner integer default 0, fifth_prize_money integer default 0, sixth_prize_winner integer default 0, sixth_prize_money integer default 0, jackpot integer, issus text, lottery_time text, create_time timestamp default CURRENT_TIMESTAMP);";
    
    [_db open];
    NSError *createError;
    BOOL flag = [_db executeUpdate:ballTable];
    [_db close];
    
}

/// 保存lottery记录
/// @param model lottery的model
- (BOOL)saveLottery:(TAVHallModel *)model {
    [_db open];
    NSDate *date = [NSDate date];
    
    NSError *saveError;
    BOOL flag =  [_db executeUpdate:@"insert into t_issue (rq1, rq2, rq3, rq4, rq5, rq6, bq, sold_in_all, first_prize_winner, first_prize_money, second_prize_winner, second_prize_money, third_prize_winner, third_prize_money, fourth_prize_winner, fourth_prize_money, fifth_prize_winner, fifth_prize_money, sixth_prize_winner, sixth_prize_money, jackpot, issus, lottery_time, create_time) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?, ?, ?, ?, ?, ?);" values:@[model.rqNumArr[0], model.rqNumArr[1], model.rqNumArr[2], model.rqNumArr[3], model.rqNumArr[4], model.rqNumArr[5], model.bqNum, model.sales, model.prizeNumArr[0], model.prizeMoneyArr[0], model.prizeNumArr[1], model.prizeMoneyArr[1], model.prizeNumArr[2], model.prizeMoneyArr[2], model.prizeNumArr[3], model.prizeMoneyArr[3],model.prizeNumArr[4], model.prizeMoneyArr[4], model.prizeNumArr[5], model.prizeMoneyArr[5], model.jackpot, model.issueNo, model.lotteryTime, @(date.timeIntervalSince1970)] error:&saveError];
    [_db close];
    return flag;
}

- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssueno:(id _Nullable)toIssueno andLimit:(NSNumber * _Nullable)limit {
    NSDictionary *resultDic;
    [_db open];
    NSError *queryError;
    FMResultSet *resultSet = [_db executeQuery:@"select * from t_issueno where issue >= ? and issue <= ? limit ?;" values:@[issueno, toIssueno, limit == nil ? @20 : limit] error:&queryError];
    if (queryError != nil) {
        resultDic = [self createErrorMsg:queryError.description];
        [_db close];
        return resultDic;
    }
    
    NSMutableArray *resultArr = [NSMutableArray array];
    while (resultSet.next) {
        int columnCount = resultSet.columnCount;
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < columnCount; i++) {
            NSString *key = [resultSet columnNameForIndex:i];
            id value = [resultSet valueForKey:key];
            [mutableDic setObject:value forKey:key];
        }
        [resultArr addObject:mutableDic.copy];
    }
    resultDic = [self createMsg:resultArr.copy];

    [_db close];
    return resultDic;
}

- (NSDictionary *)createErrorMsg:(NSString *)msg {
    NSDictionary *errorDic = @{@"status": @(-1), @"msg": msg};
    return errorDic;
}

- (NSDictionary *)createMsg:(id)msg {
    NSDictionary *errorDic = @{@"status": @(0), @"msg": msg};
    return errorDic;
}
@end
