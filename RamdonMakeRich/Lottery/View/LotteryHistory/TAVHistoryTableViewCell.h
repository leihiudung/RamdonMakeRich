//
//  TAVHistoryTableViewCell.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TAVLotteryPO;
NS_ASSUME_NONNULL_BEGIN

@interface TAVHistoryTableViewCell : UITableViewCell

- (void)customerValue:(TAVLotteryPO *)lotteryPO;

@end

NS_ASSUME_NONNULL_END
