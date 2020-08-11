//
//  TAVHistoryView.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHistoryView.h"
#import "TAVHistoryTableViewCell.h"
@interface TAVHistoryView()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TAVHistoryView

- (instancetype)initWithViewModel:(TAVBasicViewModel *)viewModel {
    if (self = [super initWithViewModel:viewModel]) {
        
    }
    return self;
}

- (void)customerView {
    
}

@end
