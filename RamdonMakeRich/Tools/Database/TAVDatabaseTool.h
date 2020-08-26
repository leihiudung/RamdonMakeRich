//
//  DatabaseTool.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/1.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAVHallModel.h"

const int Count30 = 30;
const int Count50 = 50;
const int Count100 = 100;
const int Count200 = 200;

#define OrderByDesc @"desc"
#define OrderByAsc @"asc"

NS_ASSUME_NONNULL_BEGIN

@interface TAVDatabaseTool : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)share;

/// 保存lottery记录
/// @param model lottery的model
- (BOOL)saveLottery:(TAVHallModel *)model;

/// 查询lottery记录
/// @param issueno 开始的issueno
/// @param toIssueno 结束的issueno
- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssueno:(id _Nullable)toIssueno andLimit:(NSNumber * _Nullable)limit;

/// 保存一般统计表
/// @param param lottery的统计数据
/// @param count 总共统计条数
- (void)saveHottest:(id _Nullable)param to:(int)count;

/// 更新头count条记录
/// @param param 更新的字典
/// @param count 更新的条数
- (void)updateHottest:(id)param to:(int)count;

/// 查询hottest记录
/// @param limit 需要的结果条数,默认为1
- (NSArray *)queryHottestLimit:(id _Nullable)limit andOrder:(NSString *)order;

/// 查询头30条记录
- (NSArray *)queryHottestLimit30AndOrder:(NSString *)order;

/// 查询头50条记录
- (NSArray *)queryHottestLimit50AndOrder:(NSString *)order;

/// 查询头100条记录
- (NSArray *)queryHottestLimit100AndOrder:(NSString *)order;

/// 查询头200条记录
- (NSArray *)queryHottestLimit200AndOrder:(NSString *)order;

/// 查询所有查询条件记录
- (NSArray *)queryAllHottestLimit:(id _Nullable)limit andOrder:(NSString *)order;

/// 删除头N条记录
/// @param param 删除条件
- (void)deleteHottest:(NSDictionary *)param;

/// 查询top 20详细记录
- (NSArray *)queryTopHottestTable:(int)top order:(int)orderType;

/// 更新top 20记录
/// @param param nsdictionary记录
- (void)updateTopHottest:(id)param;

/// 删除top 20中期数小与或等于条件的部分记录
/// @param issueno 判断条件期数
- (void)deleteTopHottest:(NSDictionary *)issueno;
@end

NS_ASSUME_NONNULL_END
