//
//  NetworkTool.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/3.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAVNetworkTool : NSObject

@property (nonatomic, strong) NSDictionary *lotteryDic;

+ (instancetype)share;
- (void)requestLotteryHistory:(id _Nullable)issueno andLimit:(int)limit  withResultBlock:(void(^)(id))resultBlock;
@end

NS_ASSUME_NONNULL_END
