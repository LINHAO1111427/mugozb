//
//  LiveBarrageView.m
//  TCDemo
//
//  Created by CH on 2019/11/21.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveBarrageView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>

@implementation LiveBarrageView

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.frame = CGRectMake(0, superView.height - superView.height*0.8 - kSafeAreaBottom, superView.width, superView.height*0.2);
        [superView addSubview:self];
    }
    return self;
}

- (void)addMsg:(ApiSimpleMsgRoomModel *)model{
    
    NSAssert(model.type == 14, kLocalizationMsg(@"不是弹幕消息？？？或者type有更换"));
    
    CGFloat height = self.frame.size.height;
    CGFloat originY = arc4random_uniform(floor(height));

    UIView *oneBarrage = [self createBarrageWithModel:model];
    
    CGRect tempFrame = oneBarrage.frame;
    tempFrame.origin.x = self.frame.size.width;
    tempFrame.origin.y = originY;
    oneBarrage.frame = tempFrame;
    
    [self addSubview:oneBarrage];
    
    double time = tempFrame.size.width/kScreenWidth*1.5;
    [UIView animateWithDuration:(6+time) animations:^{
        CGRect tempFrame2 = oneBarrage.frame;
        tempFrame2.origin.x = - tempFrame2.size.width;
        oneBarrage.frame = tempFrame2;
    } completion:^(BOOL finished) {
        [oneBarrage removeFromSuperview];
    }];
    
}

- (UIView *)createBarrageWithModel:(ApiSimpleMsgRoomModel *)model{
    
    UIView *oneBarrage = [[UIView alloc] init];
    [oneBarrage setFrame:CGRectMake(0, 0, self.width, 34)];
        
    // 弹幕对应的背景色
    UIView *contentBgView = [[UIView alloc] init];
    [contentBgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    contentBgView.layer.masksToBounds = YES;
    [oneBarrage addSubview:contentBgView];
    
    ///动态头像
    UIImageView *barrageIcon = [[UIImageView alloc] init];
    barrageIcon.contentMode = UIViewContentModeScaleAspectFit;
    [oneBarrage addSubview:barrageIcon];
    
    // 弹幕对应的用户名
//    UILabel *userNameLb = [[UILabel alloc] init];
//    [userNameLb setFont:[UIFont systemFontOfSize:10]];
//    [userNameLb setTextColor:[UIColor whiteColor]];
//    [userNameLb setText:model.uname];
//    [oneBarrage addSubview:userNameLb];
    
    // 弹幕对应的消息文字
    UILabel *contentLb = [[UILabel alloc] init];
    [contentLb setTextColor:[UIColor whiteColor]];
    [contentLb setFont:[UIFont systemFontOfSize:12]];
    
    NSString *showContent = [NSString stringWithFormat:@"%@ %@",model.userName,model.content];
    NSMutableAttributedString *muAttr = [[NSMutableAttributedString alloc] initWithString:showContent];
    [muAttr addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FFD176")} range:NSMakeRange(0, model.userName.length)];
    [contentLb setAttributedText:muAttr];
    [oneBarrage addSubview:contentLb];
    
    // 用户头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    [userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    [userIcon.layer setMasksToBounds:YES];
    [userIcon.layer setCornerRadius:13];
    [oneBarrage addSubview:userIcon];

    // 添加自动布局
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.centerY.equalTo(contentBgView);
        make.left.equalTo(oneBarrage).mas_offset(22);
        make.right.equalTo(contentLb.mas_left).mas_offset(-10);
    }];
    
    ///弹幕图标
    [barrageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.equalTo(userIcon).mas_offset(-10);
        make.centerY.equalTo(oneBarrage);
    }];
    
    [contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userIcon);
        make.right.equalTo(contentBgView).mas_offset(-20);
    }];
    
    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(oneBarrage);
        make.left.equalTo(barrageIcon).mas_offset(22);
    }];
    
    [contentBgView layoutIfNeeded];
    contentBgView.layer.cornerRadius = contentBgView.height/2.0;
    [oneBarrage setFrame:CGRectMake(0, 0, contentBgView.width+22+22+100, 34)];
    
    return oneBarrage;
}

@end
