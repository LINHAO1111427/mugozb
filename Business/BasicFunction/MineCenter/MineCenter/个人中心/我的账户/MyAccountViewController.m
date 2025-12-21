//
//  MyAccountViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import "MyAccountViewController.h"
#import "paySelectedBtn.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/GiftPackVOModel.h>
#import <LibProjModel/RechargeRulesVOModel.h>
#import <LibProjModel/RechargeCenterVOModel.h>
#import <LibProjModel/HttpApiApiRechargeRules.h>
#import <LibProjModel/RechargeCenterGiftPackVOModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/PayResultView.h>
#import <LibProjView/PaymentManager.h>

@interface MyAccountViewController ()

@property (nonatomic, weak)UIView *selectBgView;
@property (nonatomic, weak)UIView *rewardView;


@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, strong)RechargeCenterVOModel *chargeModel;

@property (nonatomic, strong)UIView *chargeView;//充值选择页面
@property (nonatomic, strong)UILabel *myCoinLabel;
@property (nonatomic, strong)UIButton *sureBtn;

@property (nonatomic, strong)UIImageView *nobleImageV;
@property (nonatomic, strong)UILabel *noblePriceL;

@end

@implementation MyAccountViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadUserAccountData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    
    NSString *title = kLocalizationMsg(@"充值中心");
    NSArray *itemArr = [[ProjConfig shareInstence].businessConfig getMineCenterFuncOneArray];
    for (NSDictionary *subDic in itemArr) {
        if ([subDic[@"item_id"] intValue] == 1004) {
            title = subDic[@"title"];
        }
    }
    self.navigationItem.title = title;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    [self.navigationController.navigationBar addSubview:line];
    
    UIButton *consumptionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 32)];
    [consumptionBtn setTitleColor: kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [consumptionBtn setTitle:kLocalizationMsg(@"消费记录") forState:UIControlStateNormal];
    consumptionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [consumptionBtn addTarget:self action:@selector(consumptionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:consumptionBtn];;
    self.navigationItem.rightBarButtonItem = item;
    
    [self createBaseUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self getChargeRules];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}


- (void)applicationWillEnterForeground{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadUserAccountData];
    });
}

#pragma mark - 加载数据
- (void)loadUserAccountData{
    kWeakSelf(self);
    [HttpApiUserController getMyAccount:^(int code, NSString *strMsg, MyAccountVOModel *model) {
        if (code == 1) {
            NSString *showStr = [NSString stringWithFormat:@"%.0f",model.coin];
            weakself.myCoinLabel.attributedText = [showStr attachmentForImage:[ProjConfig getCoinImage] bounds: CGRectMake(0, 0, 20, 20) before:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)getChargeRules{
    kWeakSelf(self);
    [HttpApiApiRechargeRules rulesList:^(int code, NSString *strMsg, RechargeCenterVOModel *model) {
        if (code == 1) {
            weakself.chargeModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself createUI];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

#pragma mark - UI与支付
- (void)createBaseUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 13.0, *)) {
        scrollView.automaticallyAdjustsScrollIndicatorInsets = YES;
    }
    [self.view addSubview:scrollView];
    //    _scrollView = scrollView;
    
    UIView *contentBgView = [[UIView alloc] init];
    [scrollView addSubview:contentBgView];
//    _contentBgView = contentBgView;
    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    ///头部
    CGFloat scale = 350.0/750;
    CGFloat heightHeader = kScreenWidth*scale;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, heightHeader)];
    headerView.backgroundColor = [UIColor clearColor];
    [contentBgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentBgView);
        make.height.mas_equalTo(heightHeader);
    }];
    
    UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:headerView.bounds];
    bgImgV.image = [UIImage imageNamed:[[ProjConfig shareInstence].baseConfig getRechangeCenterBgImgName]];
    [headerView addSubview:bgImgV];
    
    ///圆角
    UIView *cornerV = [[UIView alloc]initWithFrame:CGRectMake(0, heightHeader-10, kScreenWidth, 11)];
    cornerV.backgroundColor = [UIColor whiteColor];
    [bgImgV addSubview:cornerV];
    [cornerV cornerRadii:CGSizeMake(14, 14) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)];
    
    //金币
    UILabel *coinTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 40, kScreenWidth-90, 20)];
    coinTitleLabel.font = [UIFont systemFontOfSize:14];
    coinTitleLabel.textColor = [UIColor whiteColor];
    coinTitleLabel.textAlignment = NSTextAlignmentLeft;
    coinTitleLabel.text = kStringFormat(kLocalizationMsg(@"我的%@"),kUnitStr);
    [headerView addSubview:coinTitleLabel];
    
    UILabel *myCoinLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, coinTitleLabel.maxY+20, kScreenWidth-90, 40)];
    myCoinLabel.textColor = [UIColor whiteColor];
    myCoinLabel.textAlignment = NSTextAlignmentLeft;
    NSString *showStr = [NSString stringWithFormat:@"%.0lf",self.chargeModel.userCoin];
    myCoinLabel.attributedText = [showStr attachmentForImage:[ProjConfig getCoinImage] bounds: CGRectMake(0, 0, 20, 20) before:YES];
    myCoinLabel.font = [UIFont boldSystemFontOfSize:30];
    self.myCoinLabel = myCoinLabel;
    [headerView addSubview:self.myCoinLabel];
    
    ///充值
    UILabel *titleL = [[UILabel alloc]init];
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.text = kLocalizationMsg(@"我要充值");
    [contentBgView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentBgView).offset(12);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(headerView.mas_bottom).offset(10);
    }];
    
    UIView *selectBgView = [[UIView alloc] init];
    selectBgView.backgroundColor = [UIColor clearColor];
    [contentBgView addSubview:selectBgView];
    self.selectBgView = selectBgView;
    
    [selectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentBgView);
        make.top.equalTo(titleL.mas_bottom).offset(20);
        make.height.mas_equalTo(700);
        make.bottom.equalTo(contentBgView);
    }];
    
//    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(selectBgView.mas_bottom).offset(20);// 这里放最后一个view的底部
//    }];
}


- (void)createUI{
    
    [self.selectBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //充值列表
    CGFloat scales = 104/60.0;
    CGFloat width = kScreenWidth *104/360.0;
    CGFloat height = width /scales;
    CGFloat magin = (kScreenWidth-30-width *3)/2.0;
    NSInteger num = self.chargeModel.rechargeRulesVOList.count;
    if (num == 0) {
        num = 1;
    }
    NSInteger rowAll = (num-1)/3+1;
    UIView *chargeView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-30,(height+10)*rowAll)];
    chargeView.backgroundColor = [UIColor clearColor];
    self.chargeView = chargeView;
    
    [self.selectBgView addSubview:self.chargeView];
    for (int i = 0; i < self.chargeModel.rechargeRulesVOList.count; i++) {
        RechargeRulesVOModel *model = self.chargeModel.rechargeRulesVOList[i];
        NSInteger row = i/3;
        NSInteger col = i%3;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(col *(width+magin), 1+row*(height +10), width, height+10)];
        backView.backgroundColor = [UIColor clearColor];
        [chargeView addSubview:backView];
        
        paySelectedBtn *btn = [[paySelectedBtn alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        btn.ruleModel = model;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        if (i == 0) {
            btn.isSelected = YES;
        }
        [btn addTarget:self action:@selector(chargeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    
    ///贵族UI
    UIView *nobleV = [[UIView alloc]initWithFrame:CGRectMake(12, chargeView.maxY, kScreenWidth-24, 0)];
    nobleV.backgroundColor = [UIColor clearColor];
    [self.selectBgView addSubview:nobleV];
    if (!self.chargeModel.isVip) {
        nobleV.y = self.chargeView.maxY+20;
        nobleV.height = 30;
        UIImageView *nobleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 24, 24)];
        nobleImageV.contentMode = UIViewContentModeScaleAspectFit;
        [nobleV addSubview:nobleImageV];
        self.nobleImageV = nobleImageV;
        UILabel *noblePriceL = [[UILabel alloc]initWithFrame:CGRectMake(nobleImageV.maxX+5, 5, kScreenWidth-24-24, 20)];
        noblePriceL.font = [UIFont systemFontOfSize:13];
        noblePriceL.textColor = kRGB_COLOR(@"#333333");
        self.noblePriceL = noblePriceL;
        [nobleV addSubview:noblePriceL];
    }
    
    ///说明
    UIView *ruleBgView = [[UIView alloc] initWithFrame:CGRectMake(nobleV.x, nobleV.maxY+30, nobleV.width, 1)];
    [self.selectBgView addSubview:ruleBgView];
    if (self.chargeModel.promptContent.length > 0) {
        UILabel *ruleTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ruleBgView.width, 17)];
        ruleTitleL.textColor = kRGBA_COLOR(@"#333333", 1.0);
        ruleTitleL.text = kLocalizationMsg(@"说明");
        ruleTitleL.font = [UIFont systemFontOfSize:14];
        [ruleBgView addSubview:ruleTitleL];
        
        UILabel *ruleTextL = [[UILabel alloc]init];
        ruleTextL.textColor = kRGBA_COLOR(@"#666666", 1.0);
        ruleTextL.font = [UIFont systemFontOfSize:14];
        ruleTextL.numberOfLines = 0;
        //        ruleTextL.text = self.chargeModel.promptContent;
        ruleTextL.attributedText = [self.chargeModel.promptContent lineSpace:5];
        [ruleBgView addSubview:ruleTextL];
        [ruleTextL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ruleTitleL.mas_bottom).offset(15);
            make.left.right.equalTo(ruleTitleL);
            make.bottom.equalTo(ruleBgView);
        }];
        [ruleTextL layoutIfNeeded];
        [ruleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nobleV.mas_bottom).offset(30);
            make.left.equalTo(nobleV);
            make.width.mas_equalTo(nobleV.width);
        }];
    }else{
        [ruleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nobleV.mas_bottom).offset(30);
            make.left.equalTo(nobleV);
            make.width.mas_equalTo(nobleV.width);
            make.height.mas_equalTo(1);
        }];
    }
    [ruleBgView layoutIfNeeded];
    
    //确认按钮
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, ruleBgView.maxY+70, 150, 40)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.layer.cornerRadius = 20;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:kLocalizationMsg(@"确认充值") forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage createImageSize:sureBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = sureBtn;
    [self.selectBgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.top.equalTo(ruleBgView.mas_bottom).offset(70);
        make.centerX.equalTo(ruleBgView);
    }];
    [sureBtn layoutIfNeeded];
    
    [self showRewardView:self.selectedIndex];
}

- (void)showRewardView:(NSInteger)index{
    if (self.chargeModel.rechargeRulesVOList.count == 0) {
        return;
    }
    
    [_rewardView removeFromSuperview];
    
    RechargeRulesVOModel *model = self.chargeModel.rechargeRulesVOList[index];
    //贵族优惠
    if (!self.chargeModel.isVip) {
        [_nobleImageV sd_setImageWithURL:[NSURL URLWithString:self.chargeModel.nobleIcon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        if (model.nobleDiscountMoney > 0) {
            NSString *nobleS = [NSString stringWithFormat:kLocalizationMsg(@"%@充值折扣价"),self.chargeModel.nobleName];
            NSString *noblePrice = [NSString stringWithFormat:@"¥%.2f",model.nobleDiscountMoney];
            NSString *nobleAtt = [NSString stringWithFormat:@"%@ %@",nobleS,noblePrice];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:nobleAtt];
            NSRange range = [nobleAtt rangeOfString:noblePrice];
            [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor redColor]} range:range];
            _noblePriceL.attributedText = attr;
        }else{
            NSString *nobleS = [NSString stringWithFormat:kLocalizationMsg(@"%@充值无折扣"),self.chargeModel.nobleName];
            _noblePriceL.text = nobleS;
        }
    }
    
    //首充奖励
    CGFloat sizeH = self.sureBtn.maxY+40;
    if (!self.chargeModel.isFirstRecharge && model.gifList.count > 0) {
        UIView *rewardView = [[UIView alloc]initWithFrame:CGRectMake(0, self.sureBtn.maxY+20, kScreenWidth, 10)];
        rewardView.backgroundColor = [UIColor clearColor];
        [self.selectBgView addSubview:rewardView];
        _rewardView = rewardView;
        [self addRewardViewNow:model superView:rewardView];
        [rewardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sureBtn.mas_bottom).offset(30);
            make.height.mas_equalTo(rewardView.height);
            make.left.right.equalTo(rewardView.superview);
        }];
        [rewardView layoutIfNeeded];
        sizeH += (rewardView.height + 30);
    }
    
    [self.selectBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sizeH+20);
    }];
}


///显示首充奖励信息
- (void)addRewardViewNow:(RechargeRulesVOModel *)model superView:(UIView *)superV{
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(15, 20, kScreenWidth-30, superV.height)];
    bgV.backgroundColor = kRGB_COLOR(@"#FFFAF4");
    bgV.layer.cornerRadius = 10;
    bgV.clipsToBounds = YES;
    [superV addSubview:bgV];
    UIImageView *headerImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*110/375.0, kScreenWidth*110/375.0)];
    headerImageV.image = [UIImage imageNamed:@"icon_account_reward_header"];
    [superV addSubview:headerImageV];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-30, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:15];
    titleL.textColor = kRGB_COLOR(@"#FC8F3A");
    titleL.text = kLocalizationMsg(@"首充奖励");
    [bgV addSubview:titleL];
    
    CGFloat y = titleL.maxY+10;
    CGFloat giftW = kScreenWidth-30-15-80;
    for (RechargeCenterGiftPackVOModel *reward  in model.gifList) {
        if (reward.giftList.count > 0) {
            UILabel *leftL = [[UILabel alloc]initWithFrame:CGRectMake(14, y, 80, 30)];
            leftL.layer.cornerRadius = 10;
            leftL.backgroundColor = kRGB_COLOR(@"#FC8F3A");
            leftL.clipsToBounds = YES;
            leftL.font = [UIFont systemFontOfSize:14];
            leftL.textAlignment = NSTextAlignmentCenter;
            leftL.textColor = [UIColor whiteColor];
            [bgV addSubview:leftL];
            
            
            if ([reward.name isEqualToString:@"gift"]) { ///礼物
                leftL.text = kLocalizationMsg(@"礼物");
                CGFloat h = 10+(reward.giftList.count/4+1)*50;
                UIView *giftView = [[UIView alloc]initWithFrame:CGRectMake(80, y, giftW, h)];
                giftView.backgroundColor = [UIColor whiteColor];
                giftView.layer.cornerRadius = 10;
                giftView.layer.borderWidth = 1.0;
                giftView.layer.borderColor = kRGB_COLOR(@"#FE8F3A").CGColor;
                giftView.clipsToBounds = YES;
                [bgV addSubview:giftView];
                CGFloat width = giftW/4.0;
                CGFloat margin = (width-30)/2.0;
                for (int i = 0 ; i < reward.giftList.count; i++) {
                    int row = i/4;
                    int col = i%4;
                    GiftPackVOModel *gift = reward.giftList[i];
                    UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(col*width+margin, 5+row*50, 30, 30)];
                    giftImageV.contentMode = UIViewContentModeScaleAspectFit;
                    [giftImageV sd_setImageWithURL:[NSURL URLWithString:gift.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
                    [giftView addSubview:giftImageV];
                    UILabel *giftNameL = [[UILabel alloc]initWithFrame:CGRectMake(col*width, giftImageV.maxY, width, 20)];
                    giftNameL.textAlignment = NSTextAlignmentCenter;
                    giftNameL.textColor = kRGB_COLOR(@"#333333");
                    giftNameL.font = [UIFont systemFontOfSize:10];
                    giftNameL.text = [NSString stringWithFormat:@"%@x%d",gift.name,gift.typeVal];
                    [giftView addSubview:giftNameL];
                }
                y += h;
                y += 10;
            }
            if ([reward.name isEqualToString:@"noble"]) { ///贵族
                leftL.text = kLocalizationMsg(@"贵族");
                CGFloat h = 60;
                UIView *nobleBgV = [[UIView alloc]initWithFrame:CGRectMake(80, y, giftW, h)];
                nobleBgV.backgroundColor = [UIColor whiteColor];
                nobleBgV.layer.cornerRadius = 10;
                nobleBgV.layer.borderWidth = 1.0;
                nobleBgV.layer.borderColor = kRGB_COLOR(@"#FE8F3A").CGColor;
                nobleBgV.clipsToBounds = YES;
                [bgV addSubview:nobleBgV];
                
                GiftPackVOModel *gift = reward.giftList.firstObject;
                UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20,15, 30, 30)];
                giftImageV.contentMode = UIViewContentModeScaleAspectFit;
                [giftImageV sd_setImageWithURL:[NSURL URLWithString:gift.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
                [nobleBgV addSubview:giftImageV];
                UILabel *giftNameL = [[UILabel alloc]initWithFrame:CGRectMake(giftImageV.maxX+10, 0, giftW-95, 40)];
                giftNameL.centerY = giftImageV.centerY;
                giftNameL.numberOfLines = 0;
                giftNameL.textAlignment = NSTextAlignmentLeft;
                giftNameL.textColor = kRGB_COLOR(@"#333333");
                giftNameL.font = [UIFont systemFontOfSize:10];
                giftNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ x%d月"),gift.name,gift.typeVal];
                [nobleBgV addSubview:giftNameL];
                
                y += h;
                y += 10;
                
            }else if([reward.name isEqualToString:@"car"]){ ///坐骑
                leftL.text = kLocalizationMsg(@"坐骑");
                CGFloat itemH = 60;
                CGFloat h = reward.giftList.count*itemH;
                UIView *mountView = [[UIView alloc]initWithFrame:CGRectMake(80, y, giftW, h)];
                mountView.backgroundColor = [UIColor whiteColor];
                mountView.layer.cornerRadius = 10;
                mountView.layer.borderWidth = 1.0;
                mountView.layer.borderColor = kRGB_COLOR(@"#FE8F3A").CGColor;
                mountView.clipsToBounds = YES;
                [bgV addSubview:mountView];
                for (int i = 0 ; i < reward.giftList.count; i++) {
                    UIView *itemBgV = [[UIView alloc] initWithFrame:CGRectMake(0, i*itemH, mountView.width, itemH)];
                    [mountView addSubview:itemBgV];

                    GiftPackVOModel *gift = reward.giftList[i];
                    UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
                    giftImageV.contentMode = UIViewContentModeScaleAspectFill;
                    [giftImageV sd_setImageWithURL:[NSURL URLWithString:gift.gifticon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
                    [itemBgV addSubview:giftImageV];
                    UILabel *giftNameL = [[UILabel alloc]initWithFrame:CGRectMake(giftImageV.maxX+5, 0, giftW-95, 20)];
                    giftNameL.centerY = giftImageV.centerY;
                    giftNameL.textAlignment = NSTextAlignmentLeft;
                    giftNameL.textColor = kRGB_COLOR(@"#333333");
                    giftNameL.font = [UIFont systemFontOfSize:10];
                    giftNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@x%d天"),gift.name,gift.typeVal];
                    [itemBgV addSubview:giftNameL];
                }
                
                y += h;
                y += 10;
                
            }else if([reward.name isEqualToString:@"video"]){ ///短视频
                leftL.text = kLocalizationMsg(@"短视频");
                CGFloat h = 60;
                UIView *shortvView = [[UIView alloc]initWithFrame:CGRectMake(80, y, giftW, h)];
                shortvView.backgroundColor = [UIColor whiteColor];
                shortvView.layer.cornerRadius = 10;
                shortvView.layer.borderWidth = 1.0;
                shortvView.layer.borderColor = kRGB_COLOR(@"#FE8F3A").CGColor;
                shortvView.clipsToBounds = YES;
                [bgV addSubview:shortvView];
                
                GiftPackVOModel *gift = reward.giftList.firstObject;
                UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20,15, 30, 30)];
                giftImageV.contentMode = UIViewContentModeScaleAspectFit;
                giftImageV.image = [UIImage imageNamed:@"icon_account_reward_shortV"];
                [shortvView addSubview:giftImageV];
                UILabel *giftNameL = [[UILabel alloc]initWithFrame:CGRectMake(giftImageV.maxX+10, 0, giftW-95, 40)];
                giftNameL.centerY = giftImageV.centerY;
                giftNameL.numberOfLines = 0;
                giftNameL.textAlignment = NSTextAlignmentLeft;
                giftNameL.textColor = kRGB_COLOR(@"#333333");
                giftNameL.font = [UIFont systemFontOfSize:10];
                giftNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"付费短视频免费观看次数 x%d次"),gift.typeVal];
                [shortvView addSubview:giftNameL];
                
                y += h;
                y += 10;
                
            }else if([reward.name isEqualToString:@"coin"]){ ///金币
                leftL.text = kUnitStr;
                CGFloat h = 60;
                UIView *coinView = [[UIView alloc]initWithFrame:CGRectMake(80, y, giftW, h)];
                coinView.backgroundColor = [UIColor whiteColor];
                coinView.layer.cornerRadius = 10;
                coinView.layer.borderWidth = 1.0;
                coinView.layer.borderColor = kRGB_COLOR(@"#FE8F3A").CGColor;
                coinView.clipsToBounds = YES;
                [bgV addSubview:coinView];
                
                GiftPackVOModel *gift = reward.giftList.firstObject;
                UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20,15, 30, 30)];
                giftImageV.contentMode = UIViewContentModeScaleAspectFit;
                giftImageV.image = [ProjConfig getCoinImage];
                [coinView addSubview:giftImageV];
                UILabel *giftNameL = [[UILabel alloc]initWithFrame:CGRectMake(giftImageV.maxX+10, 0, giftW-95, 40)];
                giftNameL.centerY = giftImageV.centerY;
                giftNameL.numberOfLines = 0;
                giftNameL.textAlignment = NSTextAlignmentLeft;
                giftNameL.textColor = kRGB_COLOR(@"#333333");
                giftNameL.font = [UIFont systemFontOfSize:10];
                giftNameL.text = [NSString stringWithFormat:@"%@x%d",[KLCAppConfig unitStr],gift.typeVal];
                [coinView addSubview:giftNameL];
                
                y += h;
                y += 10;
            }
        }
    }
    
    bgV.height = y;
    superV.height = (y+20);
}


//支付
- (void)gotoChange{
    kWeakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        RechargeRulesVOModel *chargeModel = self.chargeModel.rechargeRulesVOList[self.selectedIndex];
        
        PaymentParamModel *param = [[PaymentParamModel alloc] init];
        param.channelId = 0;
        param.pageType = 0;
        param.payId = chargeModel.id_field;
        param.price = chargeModel.discountMoney;
        param.nobleDiscountMoney = chargeModel.nobleDiscountMoney;
        param.discount = chargeModel.discountMoney;
        param.rechargeCoin = chargeModel.coin;
        [PaymentManager startPay:param businType:BusinessTypeCharge result:^(BOOL success, NSString * _Nullable msg) {
            if (success) {
                [weakself loadUserAccountData];
            }
        } cancel:nil];
    });
    
}
#pragma mark - 按钮
- (void)consumptionBtnClick:(UIButton *)btn{
    NSString *strUrl =@"/api/h5/consumRecord?pageSize=10&pageIndex=0&type=1";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}

- (void)chargeBtnClick:(paySelectedBtn *)btn{
    if (self.selectedIndex == btn.tag) {
        return;
    }
    btn.isSelected = !btn.isSelected;
    self.selectedIndex = btn.tag;
    for (UIView *view in self.chargeView.subviews) {
        if ([view.subviews.firstObject isKindOfClass:[paySelectedBtn class]]) {
            paySelectedBtn *payBtn = (paySelectedBtn *)view.subviews.firstObject;
            if (btn.tag != payBtn.tag ) {
                payBtn.isSelected = NO;
            }
        }
    }
    
    //首充奖励的展示
    [self showRewardView:btn.tag];
}
- (void)sureBtnClick:(UIButton *)btn{
    if (self.selectedIndex < 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择充值金额")];
        return;
    }
    
    [self gotoChange];
}



@end
