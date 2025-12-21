//
//  ChatHeaderView.m
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ChatHeaderView.h"

#import <LibProjModel/HttpApiUserController.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/OOOLiveTextChatDataModel.h>
#import <LibProjModel/OOOLiveRoomTextChatDataModel.h>

@interface ChatHeaderView ()

@property (nonatomic, assign)ConversationChatForType chatType;

@property (nonatomic, weak)UIButton *intimateBtn; ///亲密度
@property(nonatomic, weak)UILabel *storyL; ///两人故事
@property(nonatomic, weak)UILabel *addressL; ///地址

//@property (nonatomic, weak)ChatGuardView *guardView;   ///守护视图
@property (nonatomic, weak)WishShowFlowView *wishView;     ///心愿单视图

@end

@implementation ChatHeaderView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setRadiusAndShadow];
        [self createUI:chatType];
    }
    return self;
}

- (void)createUI:(ConversationChatForType)chatType{

    ///本view的高度
    
    switch (chatType) {
        case ConversationChatForSignle: ///单聊
        {
            self.height = 60;

            [self createBaseView];
            self.wishView.hidden = YES;
//            self.guardView.hidden = YES;
        }
            break;
        default: ///群聊
        {
            self.height = 0;
            
        }
            break;
    }
}

- (void)createBaseView{
    UIButton *intimateBtn = [UIButton buttonWithType:0];
    intimateBtn.frame = CGRectMake(10, 10, 40, 40);
    intimateBtn.layer.masksToBounds = YES;
    [self addSubview:intimateBtn];
    [intimateBtn addTarget:self action:@selector(intimateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [intimateBtn setImage:[UIImage imageNamed:[self getHotNumberImageStr:0]] forState:UIControlStateNormal];
    _intimateBtn = intimateBtn;
    
    UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(intimateBtn.maxX+10, 10, kScreenWidth-(intimateBtn.maxX+10)-20, 20)];
    detailL.font = [UIFont systemFontOfSize:14];
    detailL.centerY = intimateBtn.centerY;
    [self addSubview:detailL];
    self.storyL = detailL;
    
    UILabel *addressL = [[UILabel alloc] init];
    addressL.font = [UIFont systemFontOfSize:14];
    addressL.centerY = intimateBtn.centerY;
    [self addSubview:addressL];
    self.addressL = addressL;
    [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(intimateBtn);
    }];
    
}


-(void)upDataUIForWishView{
//    CGFloat topH = 10;
//    if (!self.wishView.hidden) {
//        self.wishView.y = topH;
//        topH = self.wishView.maxY + 10;
//    }
//    if (!self.guardView.hidden) {
//        self.guardView.y = topH;
//        topH = self.guardView.maxY + 10;
//    }
    
    self.wishView.centerY = self.intimateBtn.centerY;
    [self.addressL mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.wishView.hidden) {
            make.right.equalTo(self).offset(-10);
        }else{
            make.right.equalTo(self).offset(-10-10-self.wishView.width);
        }
    }];

}


- (void)setUserInfo:(ApiUserInfoModel *)userInfo{
    _userInfo = userInfo;
 
    kWeakSelf(self);
    
    if (KLCUserInfo.getRole == 1 && userInfo.role == 0) {
        
        [weakself.wishView loadWishList:KLCUserInfo.getUserId block:^(BOOL success) {
            if (success) {
                [weakself upDataUIForWishView];
            }
        }];
        
    }else if(KLCUserInfo.getRole == 0 && userInfo.role == 1){
        
        [weakself.wishView loadWishList:userInfo.userId block:^(BOOL success) {
            if (success) {
                [weakself upDataUIForWishView];
            }
        }];
        
    }else if (KLCUserInfo.getRole == 0 && userInfo.role == 0) {
        
        weakself.wishView.hidden = YES;
//        weakself.guardView.hidden = YES;
        [weakself upDataUIForWishView];
        
    }else if (KLCUserInfo.getRole == 1 && userInfo.role == 1){
        
        weakself.wishView.hidden = YES;
//        weakself.guardView.hidden = NO;
        [weakself upDataUIForWishView];
        
    }
}


- (void)setChatDataInfo:(OOOLiveTextChatDataModel *)chatDataInfo{
    _chatDataInfo = chatDataInfo;
    
    self.storyL.text = [NSString stringWithFormat:kLocalizationMsg(@"认识%d天  聊天%d次"),chatDataInfo.chatData.knowDay,chatDataInfo.chatData.chatNumber];
    [self.intimateBtn setImage:[UIImage imageNamed:[self getHotNumberImageStr:chatDataInfo.chatData.hotNumber]] forState:UIControlStateNormal];
    if (chatDataInfo.hideDistance) {
        self.addressL.text = kLocalizationMsg(@"隐藏位置");
    }else{
        self.addressL.text = chatDataInfo.distance.length?[NSString stringWithFormat:@"%@km",chatDataInfo.distance]:kLocalizationMsg(@"隐藏位置");
    }
     
    [self upDataUIForWishView];
    
}

- (void)setWishList:(NSArray *)wishList{
    _wishList = wishList;
    self.wishView.wishList = wishList;
    [self upDataUIForWishView];
}


#pragma mark - 懒加载 -
//- (ChatGuardView *)guardView{
//    if (!_guardView) {
//        ChatGuardView *guardView = [[ChatGuardView alloc]initWithFrame:CGRectMake(kScreenWidth - 160, 40, 150, 20)];
//        guardView.hidden = YES;
//        guardView.clickChatGuardViewBlock = ^{
//            [RouteManager routeForName:RN_center_userGuard currentC:[ProjConfig currentVC] parameters:@{@"userId":@([ProjConfig userId])}];
//        };
//        [self addSubview:guardView];
//        _guardView = guardView;
//    }
//    return _guardView;
//}


- (WishShowFlowView *)wishView{
    if (!_wishView) {
        WishShowFlowView *wishView = [[WishShowFlowView alloc]initWithFrame:CGRectMake(kScreenWidth - 110, 10, 100, 20)];
        wishView.hidden = YES;
        [self addSubview:wishView];
        self.wishView = wishView;
    }
    return _wishView;
}


#pragma mark - handle -
-(void)intimateBtnClick{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"亲密值:%d"),self.chatDataInfo.chatData.hotNumber]];
}

- (NSString *)getHotNumberImageStr:(int)hotNumber{
    NSString *imageStr = @"message_haogandu1";
    if (hotNumber <= 20) {
        imageStr = @"message_haogandu1";
    }else if (hotNumber > 20 && hotNumber <= 40){
        imageStr = @"message_haogandu2";
    }else if (hotNumber > 40 && hotNumber <= 60){
        imageStr = @"message_haogandu3";
    }else if (hotNumber > 60 && hotNumber <= 80){
        imageStr = @"message_haogandu4";
    }else if (hotNumber > 80 && hotNumber <= 100){
        imageStr = @"message_haogandu5";
    }else if (hotNumber > 100 && hotNumber <= 120){
        imageStr = @"message_haogandu6";
    }else if (hotNumber > 120 && hotNumber <= 140){
        imageStr = @"message_haogandu7";
    }else{
        imageStr = @"message_haogandu7";
    }
    return imageStr;
}

-(void)setRadiusAndShadow{
    
    UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = 15;
        self.layer.maskedCorners = (CACornerMask)corner;
    } else {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }

    self.layer.shadowColor = kRGB_COLOR(@"#CDCDCD").CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    
}

@end
