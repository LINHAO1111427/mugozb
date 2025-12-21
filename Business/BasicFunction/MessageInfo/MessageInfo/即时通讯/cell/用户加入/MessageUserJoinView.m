//
//  MessageUserJoinView.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/11.
//

#import "MessageUserJoinView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

@implementation MessageUserJoinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIView *bgV = [[UIView alloc] init];
    bgV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    bgV.layer.masksToBounds = YES;
    bgV.layer.cornerRadius = 4;
    [self addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.textColor = [UIColor whiteColor];
    [bgV addSubview:titleL];
    self.titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgV).offset(10);
        make.right.equalTo(bgV).offset(-10);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *userNameBtn = [UIButton buttonWithType:0];
    userNameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgV addSubview:userNameBtn];
    self.nameBtn = userNameBtn;
    [userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleL).offset(110);
        make.right.equalTo(titleL).offset(-60);
        make.top.equalTo(titleL).offset(-5);
        make.bottom.equalTo(titleL).offset(5);
    }];
    
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setTitle:kLocalizationMsg(@"点击欢迎") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgV addSubview:btn];
    self.welcomeBtn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleL);
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_equalTo(25);
    }];
}

- (void)welconUserNameJoinRoom:(NSString *)name{
    NSString *str = [NSString stringWithFormat:kLocalizationMsg(@"欢迎我们的家族新成员%@, 有你更精彩"),name];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(10, name.length)];
    self.titleL.attributedText = muStr;
}

@end
