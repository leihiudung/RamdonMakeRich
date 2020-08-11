//
//  TAVViewModelProtocolImp.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAVViewModelProtocol.h"
@class TAVHallModel;
NS_ASSUME_NONNULL_BEGIN

@interface TAVViewModelProtocolImp: NSObject <TAVViewModelProtocol>

- (instancetype)initViewModelWithModel;

- (TAVHallModel *)getHallModel;

@end

NS_ASSUME_NONNULL_END
