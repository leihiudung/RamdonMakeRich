//
//  TAVArithmeticTool.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/13.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVArithmeticTool.h"


@interface TAVArithmeticTool()

@end

@implementation TAVArithmeticTool

+ (id)hottestRedBallOf:(int)topNum {
    
    return @"";
}

+ (id)caculatorBlueBallInGroupOf4Issueno:(NSArray *)issuenoArr {
    if (issuenoArr.count < 4) {
        return @NO;
    }
    for (int i = 0; i < issuenoArr.count / 4; i++) {
        NSArray *ballsArr = issuenoArr[i];
        
    }
    return @YES;
}
@end
