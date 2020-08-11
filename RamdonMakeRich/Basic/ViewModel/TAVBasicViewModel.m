//
//  TAVBasicViewModel.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/6.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallViewModel.h"

@implementation TAVBasicViewModel

- (instancetype)initWitnViewModelProtocol:(id<TAVViewModelProtocol>)viewModePro {
    self = [super init];
    if (self) {
        self.viewModelPro = viewModePro;
        self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                id command = [[self executeRequestDataSignal:input] takeUntil:self.rac_willDeallocSignal];
                return nil;
            }];
            return requestSignal;
        }];
        
        [self initCommand];
    }
    return self;
}

- (void)initCommand {
    
}

- (id)executeRequestDataSignal:(id)input {
    return [RACSignal empty];
}

@end
