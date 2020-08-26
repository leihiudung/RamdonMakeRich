//
//  TAVHistoryView.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHistoryView.h"
#import "TAVHallViewModel.h"
#import "TAVHistoryTableViewCell.h"

@interface TAVHistoryView() //<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, assign) BOOL loadMoreFlag;

@property (nonatomic, strong) TAVHallViewModel *viewModel;

@property (nonatomic, strong) NSArray *historyArr;
@end

@implementation TAVHistoryView

- (instancetype)initWithFrame:(CGRect)frame andViewModel:(TAVBasicViewModel *)viewModel {
    if (self = [super initWithFrame:frame andViewModel:viewModel]) {
        self.viewModel = (TAVHallViewModel *)viewModel;
        [self customerView];
    }
    return self;
}

- (void)customerView {
    [[RACObserve(self.viewModel, lotteryHistoryArr) filter:^BOOL(id  _Nullable value) {
        if (value == nil) {
            return NO;
        }
        return YES;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@" done x%@", x);
        self.historyArr = x;
        [self.tableView reloadData];
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
    [_tableView setDataSource:self];
//    [_tableView setDelegate:self];
    [_tableView registerClass:[TAVHistoryTableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    [self addSubview:_tableView];
    self.loadMoreFlag = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TAVHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [cell customerValue:self.historyArr[indexPath.row]];
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat currentOffsetY = scrollView.contentOffset.y;
//    if (currentOffsetY + scrollView.frame.size.height > scrollView.contentSize.height + 45 && !self.loadMoreFlag) {
//
//
//    }
//
//}

@end
