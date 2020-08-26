//
//  TAVHistoryView.h
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAVBasicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAVHistoryView : TAVBasicView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
