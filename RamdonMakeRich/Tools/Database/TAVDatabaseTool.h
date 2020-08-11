//
//  DatabaseTool.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/1.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAVHallModel.h"

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
- (NSDictionary *)queryLotteryHistory:(id _Nullable)issueno toIssueno:(id _Nullable)toIssueno andLimit:(NSNumber * _Nullable)limit ;
@end

NS_ASSUME_NONNULL_END
