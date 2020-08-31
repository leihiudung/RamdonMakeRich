//
//  TAVHistoryTableViewCell.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/8.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHistoryTableViewCell.h"
#import "TAVLotteryPO.h"
@interface TAVHistoryTableViewCell()
@property (nonatomic, strong) UILabel *redBallsView;
@property (nonatomic, strong) UILabel *issueView;

@end

@implementation TAVHistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customerView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)customerView {
    self.redBallsView = [[UILabel alloc]initWithFrame:CGRectMake(6, self.frame.size.height * 0.1, self.frame.size.width * 0.6, self.frame.size.height * 0.8)];
    [self addSubview:self.redBallsView];
    
    self.issueView = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.redBallsView.frame), self.frame.size.height * 0.1, self.redBallsView.frame.size.width * 0.56, self.redBallsView.frame.size.height)];
    [self addSubview:self.issueView];
    
}

- (void)customerValue:(TAVLotteryPO *)lotteryPO {
    NSString *ballStr = [NSString stringWithFormat:@"%02d, %02d, %02d, %02d, %02d, %02d %02d", lotteryPO.rq1.intValue, lotteryPO.rq2.intValue, lotteryPO.rq3.intValue, lotteryPO.rq4.intValue, lotteryPO.rq5.intValue, lotteryPO.rq6.intValue, lotteryPO.bq.intValue];
    [self.redBallsView setText:ballStr];
    
    [self.issueView setText:lotteryPO.issue];
    
}

@end
