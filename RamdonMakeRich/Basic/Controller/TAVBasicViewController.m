//
//  TAVBasicViewController.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVBasicViewController.h"

@interface TAVBasicViewController ()

@end

@implementation TAVBasicViewController

- (instancetype)initWithViewModel:(TAVBasicViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self bindViewModel];
    }
    return self;
}

- (void)bindViewModel {
    
}

@end
