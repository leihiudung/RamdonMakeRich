//
//  TAVArithmeticTool.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/13.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAVArithmeticTool : NSObject

/// 最热的topNum个球
/// @param topNum 返回个数
+ (id)hottestRedBallOf:(int)topNum;
@end

NS_ASSUME_NONNULL_END
