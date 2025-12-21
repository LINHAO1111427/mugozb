//
//  PopCtr.m
//  LibTools
//
//  Created by klc on 2020/7/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import "PopCtr.h"
#import <Masonry.h>

@interface PopCtr ()

@property(nonatomic,strong)UIImageView * imv;
@end


@implementation PopCtr

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_navbar_back"]];
        [self addSubview:_imv];
        [_imv mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
