//
//  TAVBasicView.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVBasicView.h"
@interface TAVBasicView()
@property (nonatomic, strong) TAVBasicViewModel *viewModel;
@end

@implementation TAVBasicView

- (instancetype)initWithViewModel:(TAVBasicViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}



@end
