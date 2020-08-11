//
//  TAVBasicView.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAVBasicViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVBasicView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewModel:(TAVBasicViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
