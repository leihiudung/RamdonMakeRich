//
//  TAVBasicViewModel.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import <objc/runtime.h>
#import "TAVViewModelProtocol.h"
#import "TAVDatabaseTool.h"
#import "TAVNetworkTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVBasicViewModel : NSObject <TAVViewModelProtocol>

@property (nonatomic, strong) id<TAVViewModelProtocol> viewModelPro;
@property (nonatomic, strong) RACCommand *requestCommand;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWitnViewModelProtocol:(id<TAVViewModelProtocol>)viewModelPro;
- (id)executeRequestDataSignal:(id)input;
- (void)initCommand;
@end

NS_ASSUME_NONNULL_END
