//
//  MessageSystemRedPtView.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/11.
//

#import "MessageSystemRedPtView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import "MessageContentObj.h"


@implementation MessageSystemRedPtView

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
        make.width.mas_lessThanOrEqualTo(kScreenWidth-40);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.numberOfLines = 0;
    titleL.textColor = [UIColor whiteColor];
    [bgV addSubview:titleL];
    self.titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgV).offset(10);
        make.right.bottom.equalTo(bgV).offset(-10);
    }];
    
    UIButton *userNameBtn = [UIButton buttonWithType:0];
    userNameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [userNameBtn addTarget:self action:@selector(userNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:userNameBtn];
    self.nameBtn = userNameBtn;
    [userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleL).offset(4*15);
        make.width.mas_equalTo(0.1);
        make.top.equalTo(titleL).offset(-5);
        make.height.mas_equalTo(25);
    }];
}


- (void)showSystemRedPt:(GroupOpenRedPacketMsgObj *)redInfo {
    self.sendUserId = redInfo.sendUserId;
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:redInfo.showContent];
    [muStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:redInfo.sendNameRg];
    self.titleL.attributedText = muStr;
    [self.nameBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(redInfo.sendNameRg.length*15);
        make.left.equalTo(self.titleL).offset(redInfo.sendNameRg.location*12);
    }];
}

- (void)userNameBtnClick{
    if (self.clickUserInfo) {
        self.clickUserInfo(self.sendUserId);
    }
}


@end
