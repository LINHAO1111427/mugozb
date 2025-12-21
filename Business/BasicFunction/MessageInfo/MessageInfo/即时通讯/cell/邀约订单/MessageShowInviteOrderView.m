//
//  MessageShowInviteOrderView.m
//  Message
//
//  Created by klc_sl on 2021/7/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageShowInviteOrderView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@implementation MessageShowInviteOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [ProjConfig normalColors];
    titleL.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [self addSubview:titleL];
    self.titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textColor =  [UIColor lightGrayColor];
    contentL.numberOfLines = 0;
    contentL.font = [UIFont systemFontOfSize:14];
    [self addSubview:contentL];
    self.contentL = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(titleL.mas_bottom).offset(10);
        make.right.equalTo(self).offset(-15);
    }];
    
}


@end
