//
//  ChatGuardView.m
//  Message
//
//  Created by klc_tqd on 2020/5/19.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatGuardView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface ChatGuardView ()
@property (nonatomic, weak)UIButton *guardBtn;
@end
@implementation ChatGuardView

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
        [self createView];
    }
    return self;
}


- (void)createView{
    
    UIButton *guardBgView = [UIButton buttonWithType:0];
    guardBgView.layer.masksToBounds = YES;
    [self addSubview:guardBgView];
    [guardBgView addTarget:self action:@selector(guardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _guardBtn = guardBgView;
    
    UIView *coverV = [[UIView alloc] init];
    coverV.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    coverV.userInteractionEnabled = NO;
    [guardBgView addSubview:coverV];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_shouhu_pink"]];
    [guardBgView addSubview:imgV];
    
    UILabel *textL = [[UILabel alloc] init];
    textL.text = kLocalizationMsg(@"守护主播");
    textL.font = [UIFont systemFontOfSize:12];
    textL.textAlignment = NSTextAlignmentCenter;
    textL.userInteractionEnabled = NO;
    textL.textColor = [UIColor whiteColor];
    [guardBgView addSubview:textL];
    
    [guardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.centerY.equalTo(self);
        make.right.equalTo(self);
    }];
    [coverV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(guardBgView);
    }];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(guardBgView);
        make.left.equalTo(guardBgView);
        make.right.equalTo(textL.mas_left).mas_offset(4);
    }];
    [textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(guardBgView);
        make.right.equalTo(guardBgView);
    }];
    
    [guardBgView layoutIfNeeded];
    guardBgView.layer.cornerRadius = guardBgView.height/2.0;
    
}


- (void)guardBtnClick{
    if (self.clickChatGuardViewBlock) {
        self.clickChatGuardViewBlock();
    }
}


@end
