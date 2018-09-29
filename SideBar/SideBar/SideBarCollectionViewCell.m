//
//  SideBarCollectionViewCell.m
//  SideBar
//
//  Created by dbc61 on 2018/9/29.
//  Copyright © 2018年 ZZZ. All rights reserved.
//

#import "SideBarCollectionViewCell.h"

#define RGB(r,g,b) [UIColor colorWithRed:((r)/255.0) green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation SideBarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];

        self.titleLabel.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    if (isSelected) {
        self.titleLabel.layer.borderColor = RGB(240, 131, 0).CGColor;
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.textColor = RGB(240, 131, 0);
        self.titleLabel.backgroundColor = RGB(255, 241, 233);
    }else {
        self.titleLabel.layer.borderColor = RGB(246, 246, 246).CGColor;
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.textColor = RGB(102, 102, 120);
        self.titleLabel.backgroundColor = RGB(246, 246, 246);
    }
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textColor = RGB(102, 102, 120);
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = RGB(246, 246, 246);
        
    }
    return _titleLabel;
}

@end
