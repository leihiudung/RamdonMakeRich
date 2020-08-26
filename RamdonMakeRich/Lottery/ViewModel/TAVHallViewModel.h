//
//  TAVBasicViewModel.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

#import "TAVBasicViewModel.h"

@class TAVNetworkTool;
NS_ASSUME_NONNULL_BEGIN

@interface TAVHallViewModel : TAVBasicViewModel

@property (nonatomic, strong) NSArray *lotteryHistoryArr;

@property (nonatomic, strong) RACCommand *requestLotteryHistoryCommand;
@property (nonatomic, strong) RACCommand *queryLotteryHistoryCommand;

/// 加载lottery的历史信息
/// @param issueno 开始期数
/// @param toIssueno 结束期数
//- (void)requestLotteryHistoryFrom:(NSString * _Nullable)issueno toIssue:(NSString * _Nullable)toIssueno;

@end

NS_ASSUME_NONNULL_END
