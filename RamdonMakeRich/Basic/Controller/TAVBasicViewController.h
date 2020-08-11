//
//  TAVBasicViewController.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/4.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

#import "TAVBasicViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TAVBasicViewController : UIViewController

@property (nonatomic, strong) TAVBasicViewModel *viewModel;

- (instancetype)initWithViewModel:(TAVBasicViewModel *)viewModel;
- (void)bindViewModel;

@end

NS_ASSUME_NONNULL_END
