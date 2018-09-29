//
//  SideBarCollectionReusableView.m
//  SideBar
//
//  Created by dbc61 on 2018/9/29.
//  Copyright © 2018年 ZZZ. All rights reserved.
//

#import "SideBarCollectionReusableView.h"

@implementation SideBarCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        
        CGRect r = self.titleLabel.frame;
        r.origin.x = 20;
        r.origin.y = 30;
        r.size.width = 200;
        r.size.height = 35;
        self.titleLabel.frame = r;
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}

@end
