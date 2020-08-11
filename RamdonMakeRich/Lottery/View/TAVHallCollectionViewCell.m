//
//  TAVHallCollectionViewCell.m
//  RamdonMakeRich
//
//  Created by Tom-Li on 2020/8/7.
//  Copyright © 2020 Dong&Ling. All rights reserved.
//

#import "TAVHallCollectionViewCell.h"

@interface TAVHallCollectionViewCell ()

@end

@implementation TAVHallCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = self.contentView.frame;
}
@end
