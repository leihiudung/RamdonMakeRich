//
//  DatabaseTool.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/1.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVDatabaseTool.h"
#import "TAVHallModel.h"
#import "TAVFileDatabaseTool.h"
#import <FMDB/FMDB.h>

const static NSInteger DB_VERSION = 1;

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
        NSString *databaseVersion = [TAVFileDatabaseTool obtainDatabaseVersion];
        if (databaseVersion == nil) {
            [self createTable];
        } else {
            if ([databaseVersion integerValue] < DB_VERSION) {
                [self updateDatabase:[databaseVersion integerValue]];
            }
        }
        
    } else {
        NSLog(@"建立数据库失败");
    }
    
    
}

- (void)createTable {
    
    
    NSString *ballTable = @"create table t_issue (id integer primary key autoincrement, rq1 integer, rq2 integer, rq3 integer, rq4 integer, rq5 integer, rq6 integer, bq integer, sold_in_all integer, first_prize_winner integer, first_prize_money integer, second_prize_winner integer, second_prize_money integer, third_prize_winner integer, third_prize_money integer, fourth_prize_winner integer default 0, fourth_prize_money integer default 0, fifth_prize_winner integer default 0, fifth_prize_money integer default 0, sixth_prize_winner integer default 0, sixth_prize_money integer default 0, jackpot integer, issue text, lottery_time text, create_time timestamp default CURRENT_TIMESTAMP);";
    
    NSString *topHottestTable = @"create table t_top_hottest (id integer primary key autoincrement, rq1 integer default 0, rq2 integer default 0, rq3 integer default 0, rq4 integer default 0, rq5 integer default 0, rq6 integer default 0, rq7 integer default 0, rq8 integer default 0, rq9 integer default 0, rq10 integer default 0, rq11 integer default 0, rq12 integer default 0, rq13 integer default 0, rq14 integer default 0, rq15 integer default 0, rq16 integer default 0, rq17 integer default 0, rq18 integer default 0, rq19 integer default 0, rq20 integer default 0, rq21 integer default 0, rq22 integer default 0, rq23 integer default 0, rq24 integer default 0, rq25 integer default 0, rq26 integer default 0, rq27 integer default 0, rq28 integer default 0, rq29 integer default 0, rq30 integer default 0, rq31 integer default 0, rq32 integer default 0, rq33 integer default 0, bq1 integer default 0, bq2 integer default 0, bq3 integer default 0, bq4 integer default 0, bq5 integer default 0, bq6 integer default 0, bq7 integer default 0, bq8 integer default 0, bq9 integer default 0, bq10 integer default 0, bq11 integer default 0, bq12 integer default 0, bq13 integer default 0, bq14 integer default 0, bq15 integer default 0, bq16 integer default 0, odd_even_ratio integer, red_sum integer, issue text, create_time timestamp default CURRENT_TIMESTAMP, update_time timestamp default CURRENT_TIMESTAMP)";

    NSString *top30HottestTable = @"create table t_hottest_30 (id integer primary key autoincrement, rq1 integer default 0, rq2 integer default 0, rq3 integer default 0, rq4 integer default 0, rq5 integer default 0, rq6 integer default 0, rq7 integer default 0, rq8 integer default 0, rq9 integer default 0, rq10 integer default 0, rq11 integer default 0, rq12 integer default 0, rq13 integer default 0, rq14 integer default 0, rq15 integer default 0, rq16 integer default 0, rq17 integer default 0, rq18 integer default 0, rq19 integer default 0, rq20 integer default 0, rq21 integer default 0, rq22 integer default 0, rq23 integer default 0, rq24 integer default 0, rq25 integer default 0, rq26 integer default 0, rq27 integer default 0, rq28 integer default 0, rq29 integer default 0, rq30 integer default 0, rq31 integer default 0, rq32 integer default 0, rq33 integer default 0, bq1 integer default 0, bq2 integer default 0, bq3 integer default 0, bq4 integer default 0, bq5 integer default 0, bq6 integer default 0, bq7 integer default 0, bq8 integer default 0, bq9 integer default 0, bq10 integer default 0, bq11 integer default 0, bq12 integer default 0, bq13 integer default 0, bq14 integer default 0, bq15 integer default 0, bq16 integer default 0, odd_even_ratio integer, red_sum integer, issue text, create_time timestamp default CURRENT_TIMESTAMP, update_time timestamp default CURRENT_TIMESTAMP)";
    
    NSString *top50HottestTable = @"create table t_hottest_50 (id integer primary key autoincrement, rq1 integer default 0, rq2 integer default 0, rq3 integer default 0, rq4 integer default 0, rq5 integer default 0, rq6 integer default 0, rq7 integer default 0, rq8 integer default 0, rq9 integer default 0, rq10 integer default 0, rq11 integer default 0, rq12 integer default 0, rq13 integer default 0, rq14 integer default 0, rq15 integer default 0, rq16 integer default 0, rq17 integer default 0, rq18 integer default 0, rq19 integer default 0, rq20 integer default 0, rq21 integer default 0, rq22 integer default 0, rq23 integer default 0, rq24 integer default 0, rq25 integer default 0, rq26 integer default 0, rq27 integer default 0, rq28 integer default 0, rq29 integer default 0, rq30 integer default 0, rq31 integer default 0, rq32 integer default 0, rq33 integer default 0, bq1 integer default 0, bq2 integer default 0, bq3 integer default 0, bq4 integer default 0, bq5 integer default 0, bq6 integer default 0, bq7 integer default 0, bq8 integer default 0, bq9 integer default 0, bq10 integer default 0, bq11 integer default 0, bq12 integer default 0, bq13 integer default 0, bq14 integer default 0, bq15 integer default 0, bq16 integer default 0, odd_even_ratio integer, red_sum integer, issue text, create_time timestamp default CURRENT_TIMESTAMP, update_time timestamp default CURRENT_TIMESTAMP)";
    
    NSString *top100HottestTable = @"create table t_hottest_100 (id integer primary key autoincrement, rq1 integer default 0, rq2 integer default 0, rq3 integer default 0, rq4 integer default 0, rq5 integer default 0, rq6 integer default 0, rq7 integer default 0, rq8 integer default 0, rq9 integer default 0, rq10 integer default 0, rq11 integer default 0, rq12 integer default 0, rq13 integer default 0, rq14 integer default 0, rq15 integer default 0, rq16 integer default 0, rq17 integer default 0, rq18 integer default 0, rq19 integer default 0, rq20 integer default 0, rq21 integer default 0, rq22 integer default 0, rq23 integer default 0, rq24 integer default 0, rq25 integer default 0, rq26 integer default 0, rq27 integer default 0, rq28 integer default 0, rq29 integer default 0, rq30 integer default 0, rq31 integer default 0, rq32 integer default 0, rq33 integer default 0, bq1 integer default 0, bq2 integer default 0, bq3 integer default 0, bq4 integer default 0, bq5 integer default 0, bq6 integer default 0, bq7 integer default 0, bq8 integer default 0, bq9 integer default 0, bq10 integer default 0, bq11 integer default 0, bq12 integer default 0, bq13 integer default 0, bq14 integer default 0, bq15 integer default 0, bq16 integer default 0, odd_even_ratio integer, red_sum integer, issue text, create_time timestamp default CURRENT_TIMESTAMP, update_time timestamp default CURRENT_TIMESTAMP)";
    
    NSString *top200HottestTable = @"create table t_hottest_200 (id integer primary key autoincrement, rq1 integer default 0, rq2 integer default 0, rq3 integer default 0, rq4 integer default 0, rq5 integer default 0, rq6 integer default 0, rq7 integer default 0, rq8 integer default 0, rq9 integer default 0, rq10 integer default 0, rq11 integer default 0, rq12 integer default 0, rq13 integer default 0, rq14 integer default 0, rq15 integer default 0, rq16 integer default 0, rq17 integer default 0, rq18 integer default 0, rq19 integer default 0, rq20 integer default 0, rq21 integer default 0, rq22 integer default 0, rq23 integer default 0, rq24 integer default 0, rq25 integer default 0, rq26 integer default 0, rq27 integer default 0, rq28 integer default 0, rq29 integer default 0, rq30 integer default 0, rq31 integer default 0, rq32 integer default 0, rq33 integer default 0, bq1 integer default 0, bq2 integer default 0, bq3 integer default 0, bq4 integer default 0, bq5 integer default 0, bq6 integer default 0, bq7 integer default 0, bq8 integer default 0, bq9 integer default 0, bq10 integer default 0, bq11 integer default 0, bq12 integer default 0, bq13 integer default 0, bq14 integer default 0, bq15 integer default 0, bq16 integer default 0, odd_even_ratio integer, red_sum integer, issue text, create_time timestamp default CURRENT_TIMESTAMP, update_time timestamp default CURRENT_TIMESTAMP)";
    
    [_db open];
    BOOL flag = [_db executeUpdate:ballTable];
    BOOL topHottestFlag = [_db executeUpdate:topHottestTable];
    BOOL top30HottestFlag = [_db executeUpdate:top30HottestTable];
    BOOL top50HottestFlag = [_db executeUpdate:top50HottestTable];
    BOOL top100HottestFlag = [_db executeUpdate:top100HottestTable];
    BOOL top200HottestFlag = [_db executeUpdate:top200HottestTable];
    
//    [self insertDefalutValueInTable];
//    [self insertDefalutValueInHottestTable];
    [_db close];
    
}

- (void)updateDatabase:(NSInteger)oldVersion {
    switch (oldVersion) {
        case 0:
            break;
        case 1:
            break;
        default:
            break;
    }
}

/// 保存lottery记录
/// @param model lottery的model
- (BOOL)saveLottery:(TAVHallModel *)model {
    [_db open];
    NSDate *date = [NSDate date];
    
    NSError *saveError;
    BOOL flag =  [_db executeUpdate:@"insert into t_issue (rq1, rq2, rq3, rq4, rq5, rq6, bq, sold_in_all, first_prize_winner, first_prize_money, second_prize_winner, second_prize_money, third_prize_winner, third_prize_money, fourth_prize_winner, fourth_prize_money, fifth_prize_winner, fifth_prize_money, sixth_prize_winner, sixth_prize_money, jackpot, issue, lottery_time, create_time) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?, ?, ?, ?, ?, ?);" values:@[model.rqNumArr[0], model.rqNumArr[1], model.rqNumArr[2], model.rqNumArr[3], model.rqNumArr[4], model.rqNumArr[5], model.bqNum, model.sales, model.prizeNumArr[0], model.prizeMoneyArr[0], model.prizeNumArr[1], model.prizeMoneyArr[1], model.prizeNumArr[2], model.prizeMoneyArr[2], model.prizeNumArr[3], model.prizeMoneyArr[3],model.prizeNumArr[4], model.prizeMoneyArr[4], model.prizeNumArr[5], model.prizeMoneyArr[5], model.jackpot, model.issueNo, model.lotteryTime, @(date.timeIntervalSince1970)] error:&saveError];
    [_db close];
    return flag;
}

- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssueno:(id _Nullable)toIssueno andLimit:(NSNumber * _Nullable)limit {
    NSDictionary *resultDic;
    [_db open];
    NSError *queryError;
    
    NSString *sql = [NSString stringWithFormat:@"select * from t_issue %@", issueno == nil && toIssueno == nil ? [NSString stringWithFormat:@" order by issue desc limit %@ ", limit == nil ? @20 : limit] : (issueno == nil ? [NSString stringWithFormat:@" where issue >= %@ order by issue desc limit %@", toIssueno, limit == nil ? @20 : limit] : (toIssueno == nil ? [NSString stringWithFormat:@" where issue <= %@ order by issue desc limit %@", issueno, limit == nil ? @20 : limit] : [NSString stringWithFormat:@" where issue <= %@ and issue >= %@ limit %@", issueno, toIssueno, limit == nil ? @20 : limit]))];
    
    FMResultSet *resultSet = [_db executeQuery:sql];
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
            id value = [resultSet objectForColumn:key];
            [mutableDic setObject:value forKey:key];
        }
        [resultArr addObject:mutableDic.copy];
    }
    resultDic = [self createMsg:resultArr.copy];

    [_db close];
    return resultDic;
}

- (void)saveTopHottest:(id)param {
    [_db open];
    NSDate *date = [NSDate date];
    NSMutableString *redBallStr = [NSMutableString string];
    NSMutableString *blueBallStr = [NSMutableString string];
    NSMutableString *columnsStr = [NSMutableString string];
    NSDictionary *dic = param;
    [columnsStr appendString:@"insert into t_top_hottest ("];
    for (int i = 0; i < 33; i++) {
        [columnsStr appendFormat:@" rq%d, ", i+1];
        [redBallStr appendFormat:@"%@,", param[[NSString stringWithFormat:@"rq%d", i+1]]];
    }
    for (int j = 0; j < 16; j++) {
        [columnsStr appendFormat:@" bq%d, ", j+1];
        [blueBallStr appendFormat:@"%@,", param[[NSString stringWithFormat:@"bq%d", j+1]]];
    }

    [columnsStr appendFormat:@" odd_even_ratio, red_sum, issue, create_time) values ("];
    [columnsStr appendString:redBallStr.copy];
    [columnsStr appendString:blueBallStr.copy];
    [columnsStr appendFormat:@" %@, %@, %@, %@);", dic[@"odd_even_ratio"], dic[@"red_sum"], dic[@"issue"], @(date.timeIntervalSince1970)];
    BOOL updateFlag = [_db executeUpdate:columnsStr];
    [_db close];
}

- (void)saveHottest:(id _Nullable)param to:(int)count {
    [_db open];
    NSDate *date = [NSDate date];
    NSMutableString *redBallStr = [NSMutableString string];
    NSMutableString *blueBallStr = [NSMutableString string];
    NSMutableString *columnsStr = [NSMutableString string];
    NSDictionary *dic = param;
    [columnsStr appendFormat:@"insert into t_hottest_%d (", count];
    for (int i = 0; i < 33; i++) {
        [columnsStr appendFormat:@" rq%d, ", i+1];
        [redBallStr appendFormat:@"%@,", param[[NSString stringWithFormat:@"rq%d", i+1]]];
    }
    for (int j = 0; j < 16; j++) {
        [columnsStr appendFormat:@" bq%d, ", j+1];
        [blueBallStr appendFormat:@"%@,", param[[NSString stringWithFormat:@"bq%d", j+1]]];
    }
    
//    redBallStr = [redBallStr substringToIndex:redBallStr.length - 1].copy;
//    blueBallStr = [blueBallStr substringToIndex:blueBallStr.length - 1].copy;
    
    [columnsStr appendFormat:@" odd_even_ratio, red_sum, issue, create_time) values ("];
    [columnsStr appendString:redBallStr.copy];
    [columnsStr appendString:blueBallStr.copy];
    [columnsStr appendFormat:@" %@, %@, %@, %@);", dic[@"odd_even_ratio"], dic[@"red_sum"], dic[@"issue"], @(date.timeIntervalSince1970)];
    BOOL updateFlag = [_db executeUpdate:columnsStr];
    [_db close];
}

- (void)updateHottest:(id)param to:(int)count {
    [_db open];
        NSDate *date = [NSDate date];
    
    NSMutableString *columnsStr = [NSMutableString string];
    NSDictionary *dic = param;
    [columnsStr appendFormat:@"update t_hottest_%d  set ", count == Count30 ? 30 : count == Count50 ? 50 : count == Count100 ? 100 : 200];
    for (int i = 0; i < 33; i++) {
        [columnsStr appendFormat:@" rq%d = %@, ", i+1, param[[NSString stringWithFormat:@"rq%d", i+1]]];
    }
    for (int j = 0; j < 16; j++) {
        [columnsStr appendFormat:@" bq%d = %@, ", j+1, param[[NSString stringWithFormat:@"bq%d", j+1]]];
    }
        
    [columnsStr appendFormat:@" odd_even_ratio = %@, red_sum = %@, update_time = %@ where issue = %@;", dic[@"odd_even_ratio"], dic[@"red_sum"], @(date.timeIntervalSince1970), dic[@"issue"]];
    BOOL updateFlag = [_db executeUpdate:columnsStr];
    [_db close];
}
 
- (NSArray *)queryHottestLimit:(id _Nullable)limit andOrder:(nonnull NSString *)order {
    [_db open];
    
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"select * from t_hottest_%@ order by issue %@ limit %@;", limit, order, limit == nil ? @1 : limit]];
    NSMutableArray *resultArr = [NSMutableArray array];
    while (resultSet.next) {
        int columnCount = [resultSet columnCount];
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];

        for (int i = 0; i < columnCount; i++) {
            NSString *columnName = [resultSet columnNameForIndex:i];
            id columnValue = [resultSet objectForColumn:columnName];
            resultDic[columnName] = columnValue;
        }
        [resultArr addObject:resultDic.copy];
    }
    [_db close];
    return resultArr.copy;
}

- (NSArray *)queryHottestLimit30AndOrder:(NSString *)order {
    return [self queryHottestLimit:@30 andOrder:order];
}

- (NSArray *)queryHottestLimit50AndOrder:(NSString *)order {
    return [self queryHottestLimit:@50 andOrder:order];
}

- (NSArray *)queryHottestLimit100AndOrder:(NSString *)order {
    return [self queryHottestLimit:@100 andOrder:order];
}

- (NSArray *)queryHottestLimit200AndOrder:(NSString *)order {
    return [self queryHottestLimit:@200 andOrder:order];
}

- (NSArray *)queryAllHottestLimit:(id _Nullable)limit andOrder:(nonnull NSString *)order {
    NSArray *count30Arr = [self queryHottestLimit30AndOrder:order];
    NSArray *count50Arr = [self queryHottestLimit50AndOrder:order];
    NSArray *count100Arr = [self queryHottestLimit100AndOrder:order];
    NSArray *count200Arr = [self queryHottestLimit200AndOrder:order];
    NSArray *allCountArr = @[count30Arr, count50Arr, count100Arr, count200Arr];
    return allCountArr;
}

- (NSArray *)queryTopHottestTable:(int)top order:(int)orderType {
    [_db open];
    
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"select * from t_top_hottest order by issue %@ limit %d;", orderType == OrderByDesc ? @"desc" : @"asc", top]];
    NSMutableArray *resultArr = [NSMutableArray array];
    while (resultSet.next) {
       int columnCount = [resultSet columnCount];
       NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];

       for (int i = 0; i < columnCount; i++) {
           NSString *columnName = [resultSet columnNameForIndex:i];
           id columnValue = [resultSet objectForColumn:columnName];
           resultDic[columnName] = columnValue;
       }
       [resultArr addObject:resultDic.copy];
    }
    [_db close];
    return resultArr.copy;
}

- (void)insertDefalutValueInTable {
    // 插入t_hottest_30
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
    
    [self saveHottest:saveDic to:30];
    [self saveHottest:saveDic to:50];
    [self saveHottest:saveDic to:100];
    [self saveHottest:saveDic to:200];
    
}

- (void)deleteHottest:(NSDictionary *)param {
    [_db open];
    BOOL deleteFlag = [_db executeUpdate:@"delete t_hottest_200 where issue < ?", param[@"issue"]];
    [_db close];
    
}

// 插入top 20最新统计数据(这里是默认值,无效的)
- (void)insertDefalutValueInHottestTable {
    // 插入t_hottest_30
    NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < 33; i++) {
        saveDic[[NSString stringWithFormat:@"rq%d", i + 1]] = @0;
    }
    for (int j = 0; j < 16; j++) {
        saveDic[[NSString stringWithFormat:@"bq%d", j + 1]] = @0;
    }
    saveDic[@"odd_even_ratio"] = @-1;
    saveDic[@"red_sum"] = @0;
    

    for (int i = 0; i < 20; i++) {
        saveDic[@"issue"] = @(i);
        [self saveTopHottest:saveDic];
    }

}

- (void)updateTopHottest:(id)param {
    [_db open];
    NSMutableString *columnsStr = [NSMutableString string];
    NSDictionary *dic = param;
    [columnsStr appendFormat:@"update t_top_hottest set "];
    for (int i = 0; i < 33; i++) {
        [columnsStr appendFormat:@" rq%d = %@, ", i+1, param[[NSString stringWithFormat:@"rq%d", i+1]]];
    }
    for (int j = 0; j < 16; j++) {
        [columnsStr appendFormat:@" bq%d = %@, ", j+1, param[[NSString stringWithFormat:@"bq%d", j+1]]];
    }
    [columnsStr appendFormat:@" where id = %@;", param[@"fake_id"]];
    BOOL updateFlag = [_db executeUpdate:columnsStr.copy];
    
    [_db close];
}

- (void)deleteTopHottest:(NSDictionary *)param {
    [_db open];
    BOOL deleteFlag = [_db executeUpdate:@"delete t_top_hottest where issue <= ?", param[@"issue"]];
    [_db close];
    
}

- (NSDictionary *)createErrorMsg:(NSString *)msg {
    NSDictionary *errorDic = @{@"status": @(-1), @"msg": msg, @"data": [NSNull null]};
    return errorDic;
}

- (NSDictionary *)createMsg:(id)data {
    NSDictionary *errorDic = @{@"status": @(0), @"msg": @"without error", @"data": data};
    return errorDic;
}
@end
