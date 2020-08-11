//
//  TAVViewModelProtocolImp.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVViewModelProtocolImp.h"
#import "TAVHallModel.h"

@interface TAVViewModelProtocolImp()
@property (nonatomic, strong) TAVHallModel *hallModel;
@end

@implementation TAVViewModelProtocolImp

- (instancetype)initViewModelWithModel {
    self = [super init];
    if (self) {
        self.hallModel = [[TAVHallModel alloc]init];
        
    }
    return self;
}

- (TAVHallModel *)getHallModel {
    return _hallModel;
}
@end
