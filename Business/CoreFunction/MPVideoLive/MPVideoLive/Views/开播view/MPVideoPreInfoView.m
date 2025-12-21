//
//  MPVideoPreInfoView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/7.
//  Copyright © 2020 . All rights reserved.
//

#import "MPVideoPreInfoView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AppLiveChannelModel.h>
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjView/AddWishView.h>
#import <MPCommon/SelectLiveChannel.h>
#import <MPCommon/ChangeRoomTypeView.h>
#import <LibProjModel/OpenAuthDataVOModel.h>

@interface MPVideoPreInfoView ()<UITextViewDelegate>

@property (nonatomic, copy)void(^shoppingBlock)(BOOL);
@property (nonatomic, copy)void(^actionBlock)(int);

@end

@implementation MPVideoPreInfoView

- (void)dealloc
{
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self showData];
    }
    return self;
}

#pragma mark - 视图 -
///显示数据
- (void)showData{
    kWeakSelf(self);
    [AddWishView getMineWishBlock:^(NSArray<ApiUsersLiveWishModel *> * _Nullable wishList) {
        [weakself setWishView:wishList];
    }];
}

///创建视图
- (void)createUI{
    CGFloat viewH = 28;

    CGFloat pointY = 0;
    ///背景封面
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, self.width, 126)];
    [self addSubview:titleBgView];
    [self createTitleView:titleBgView];
    pointY = titleBgView.maxY+12;
    
    ///房间模式和频道
    UIView *liveTypeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, self.width, viewH)];
    [self addSubview:liveTypeBgView];
    [self roomTypeView:liveTypeBgView];
    pointY = liveTypeBgView.maxY+10;
    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
        ///定位
        UIView *locationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, self.width, viewH)];
        [self addSubview:locationBgView];
        [self showLocationView:locationBgView];
        pointY = locationBgView.maxY+10;
    }

    ///心愿单
    UIView *wishBgView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, self.width, viewH)];
    [self addSubview:wishBgView];
    [self showWishView:wishBgView];
    pointY = wishBgView.maxY+10;
    
    if ([ProjConfig isContainShopping]) {
        ///直播购物
        UIView *liveShoppingView = [[UIView alloc]initWithFrame:CGRectMake(0, pointY, self.width, viewH)];
        liveShoppingView.backgroundColor = [UIColor clearColor];
        [self addSubview:liveShoppingView];
        [self liveShoppingViewOn:liveShoppingView];
    }
}


- (void)createTitleView:(UIView *)superView{
    superView.layer.masksToBounds = YES;
    superView.layer.cornerRadius = 4.0;
    superView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    ///添加封面
    UIButton *preThumbBtn = [UIButton buttonWithType:0];
    preThumbBtn.frame =CGRectMake(11, 23, 80, 80);
    [preThumbBtn addTarget:self action:@selector(doUploadPicture) forControlEvents:UIControlEventTouchUpInside];
    preThumbBtn.layer.masksToBounds = YES;
    preThumbBtn.layer.cornerRadius = 5.0;
    [superView addSubview:preThumbBtn];
    _userLiveCover = preThumbBtn;
    
    ///直播标题
    UITextView *liveTitleTextV = [[UITextView alloc] initWithFrame:CGRectMake(preThumbBtn.maxX+12, preThumbBtn.y, superView.width - (preThumbBtn.maxX+12)-20, 50)];
    liveTitleTextV.font = [UIFont systemFontOfSize:16];
    liveTitleTextV.textColor = [UIColor whiteColor];
    liveTitleTextV.backgroundColor = [UIColor clearColor];
    liveTitleTextV.returnKeyType = UIReturnKeyDone;
    liveTitleTextV.delegate = self;
    liveTitleTextV.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
    liveTitleTextV.scrollEnabled = NO;
    liveTitleTextV.selectable = NO;
    liveTitleTextV.editable = YES;
    liveTitleTextV.placeholder = kLocalizationMsg(@"更高的人气来自一个好的标题呦");
    liveTitleTextV.placeholderColor = kRGBA_COLOR(@"#FFFFFF", 0.5);
    [superView addSubview:liveTitleTextV];
    _textV = liveTitleTextV;
}

///显示定位
- (void)showLocationView:(UIView *)superView{
    ///定位
    UIButton *localBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    localBgBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    localBgBtn.layer.masksToBounds = YES;
    [localBgBtn addTarget:self action:@selector(startLocationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:localBgBtn];
    ///定位图标
    UIImageView *LocationImageV = [[UIImageView alloc] init];
    LocationImageV.frame = CGRectMake(8, 0, 12, 12);
    LocationImageV.image = [UIImage imageNamed:@"live_audio_addreee"];
    LocationImageV.userInteractionEnabled = NO;
    [localBgBtn addSubview:LocationImageV];
    ///位置
    UILabel *locationLab = [[UILabel alloc]init];
    locationLab.font = [UIFont systemFontOfSize:12];
    locationLab.textColor = [UIColor whiteColor];
    locationLab.text = @" ";
    [localBgBtn addSubview:locationLab];
    _cityL = locationLab;
    
    [localBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(superView);
    }];
    [LocationImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(localBgBtn).mas_offset(8);
        make.centerY.equalTo(localBgBtn);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LocationImageV.mas_right).mas_offset(4);
        make.centerY.equalTo(localBgBtn);
        make.right.equalTo(localBgBtn).mas_offset(-14);
    }];
    [localBgBtn layoutIfNeeded];
    localBgBtn.layer.cornerRadius = localBgBtn.height/2.0;
}

///设置房间类型和频道类型
- (void)roomTypeView:(UIView *)superView{
    ///选择频道
    UIButton *channelBgView = [UIButton buttonWithType:0];
    channelBgView.layer.masksToBounds = YES;
    channelBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [channelBgView addTarget:self action:@selector(selectChannelView) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:channelBgView];
    ///选择频道-文字
    UILabel *channelL = [[UILabel alloc] init];
    channelL.text = kLocalizationMsg(@"直播频道");
    channelL.textColor = [UIColor whiteColor];
    channelL.font = [UIFont systemFontOfSize:12];
    [channelBgView addSubview:channelL];
    _selectChannel = channelL;
    ///选择频道-箭头
    UIImageView *channelArrowImg = [[UIImageView alloc] init];
    channelArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    channelArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [channelBgView addSubview:channelArrowImg];
    ///房间模式
    UIButton *liveTypeBgView = [UIButton buttonWithType:0];
    liveTypeBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    liveTypeBgView.layer.masksToBounds = YES;
    [liveTypeBgView addTarget:self action:@selector(dochangelivetype) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:liveTypeBgView];
    ///房间模式-文字
    UILabel *typeL = [[UILabel alloc] init];
    typeL.text = kLocalizationMsg(@"房间模式");
    typeL.textColor = [UIColor whiteColor];
    typeL.font = [UIFont systemFontOfSize:12];
    [liveTypeBgView addSubview:typeL];
    _roomType = typeL;
    ///房间模式-箭头
    UIImageView *typeArrowImg = [[UIImageView alloc] init];
    typeArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    typeArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [liveTypeBgView addSubview:typeArrowImg];
    
    ///频道
    [channelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(superView);
        make.right.equalTo(liveTypeBgView.mas_left).mas_offset(-12);
    }];
    [channelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(channelBgView);
        make.left.equalTo(channelBgView).mas_offset(9);
        make.right.equalTo(channelArrowImg.mas_left).mas_offset(-5);
    }];
    [channelArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(channelBgView).mas_offset(-9);
        make.centerY.equalTo(channelL);
    }];
    ///房间模式
    [liveTypeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(channelBgView.mas_height);
        make.centerY.equalTo(channelBgView);
    }];
    [typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(liveTypeBgView);
        make.left.equalTo(liveTypeBgView).mas_offset(9);
        make.right.equalTo(typeArrowImg.mas_left).mas_offset(-5);
    }];
    [typeArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(liveTypeBgView).mas_offset(-9);
        make.centerY.equalTo(typeL);
    }];
    [channelBgView layoutIfNeeded];
    channelBgView.layer.cornerRadius = channelBgView.height/2.0;
    [liveTypeBgView layoutIfNeeded];
    liveTypeBgView.layer.cornerRadius = liveTypeBgView.height/2.0;
}

- (void)showWishView:(UIView *)superView{
    ///心愿单
    UIButton *wishBgView = [UIButton buttonWithType:0];
    wishBgView.layer.masksToBounds = YES;
    [wishBgView addTarget:self action:@selector(showWishListViewTOcurren) forControlEvents:UIControlEventTouchUpInside];
    wishBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [superView addSubview:wishBgView];
    ///icon-文字
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"add_wish_xinyuandan"];
    [wishBgView addSubview:iconImg];
    ///心愿单-文字
    UILabel *wishL = [[UILabel alloc] init];
    wishL.text =kLocalizationMsg(@"添加心愿单");
    wishL.textColor = [UIColor whiteColor];
    wishL.font = [UIFont systemFontOfSize:12];
    [wishBgView addSubview:wishL];
    _wishL = wishL;
    ///房间模式-箭头
    UIImageView *wishArrowImg = [[UIImageView alloc] init];
    wishArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    wishArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [wishBgView addSubview:wishArrowImg];
    
    [wishBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(superView);
    }];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.equalTo(wishBgView);
        make.right.equalTo(wishL.mas_left).mas_offset(-6);
        make.left.equalTo(wishBgView).mas_offset(10);
    }];
    [wishL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImg);
        make.right.equalTo(wishArrowImg.mas_left).mas_offset(-5);
    }];
    [wishArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(wishBgView).mas_offset(-9);
        make.centerY.equalTo(iconImg);
    }];
    [wishBgView layoutIfNeeded];
    wishBgView.layer.cornerRadius = wishBgView.height/2.0;
}

- (void)liveShoppingViewOn:(UIView *)shoppingView{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, shoppingView.height)];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    backgroundView.layer.cornerRadius = 14;
    backgroundView.clipsToBounds = YES;
    [shoppingView addSubview:backgroundView];
    
    
    
    UIButton *openShoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, shoppingView.height)];
    openShoppingBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [openShoppingBtn setImage:[UIImage imageNamed:@"live_shopping_check_normal"] forState:UIControlStateNormal];
    [openShoppingBtn setImage:[UIImage imageNamed:@"live_shopping_check_selected"] forState:UIControlStateSelected];
    [openShoppingBtn setTitle:kLocalizationMsg(@" 开启直播带货，") forState:UIControlStateNormal];
    openShoppingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [openShoppingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openShoppingBtn addTarget:self action:@selector(openShoppingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:openShoppingBtn];
    
    UILabel *addCommodityL = [[UILabel alloc]initWithFrame:CGRectMake(openShoppingBtn.maxX, 0,80, shoppingView.height)];
    addCommodityL.textColor = [UIColor whiteColor];
    addCommodityL.font = [UIFont systemFontOfSize:12];
    addCommodityL.text = kLocalizationMsg(@"添加直播商品");
    addCommodityL.textAlignment = NSTextAlignmentLeft;
    [backgroundView addSubview:addCommodityL];
    
    UIImageView *moreImgeV = [[UIImageView alloc]initWithFrame:CGRectMake(addCommodityL.maxX, 8, 12, 12)];
    moreImgeV.image = [UIImage imageNamed:@"right_jiantou_white"];
    [backgroundView addSubview:moreImgeV];
    
    UIButton *addLiveCommodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(openShoppingBtn.maxX, 0, 100, shoppingView.height)];
    addLiveCommodityBtn.backgroundColor = [UIColor clearColor];
    [addLiveCommodityBtn addTarget:self action:@selector(addLiveCommodityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:addLiveCommodityBtn];
}

#pragma mark - action -
- (void)openShoppingBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _shoppingBlock(btn.selected);
}
- (void)addLiveCommodityBtnClick:(UIButton *)btn{
    [LiveComponentMsgMgr sendMsg:LM_SetLiveGoods msgDic:nil];
}
- (void)clickActionBlock:(void (^)(int))actionBlock{
    _actionBlock = actionBlock;
}
- (void)shoppingBtnSelectedBlock:(void(^)(BOOL selected))actionBlock{
    _shoppingBlock = actionBlock;
}

- (void)startLocationBtnClick{
    if (_actionBlock) {
        _actionBlock(1);
    }
}

- (void)doUploadPicture{
    if (_actionBlock) {
        _actionBlock(2);
    }
}

///选择模式 （普通/计时/付费/密码）
- (void)dochangelivetype{
    [self endEditing:YES];
    kWeakSelf(self);
    [ChangeRoomTypeView selectRoomTypeIsModify:NO roomTypeSelect:^(RoomTypeModel * _Nonnull selectRoomType) {
        weakself.roomType.text = selectRoomType.roomTypeStr;
        weakself.roomTypeID = selectRoomType.roomType;
        weakself.roomTypeVal = selectRoomType.roomTypeValue;
    }];
}

///选择频道
- (void)selectChannelView{
    [self endEditing:YES];
    kWeakSelf(self);
    [SelectLiveChannel showType:1 selectId:_roomChannelID selectBlock:^(AppLiveChannelModel * _Nonnull channelModel) {
        weakself.roomChannelID = channelModel.id_field;
        weakself.selectChannel.text = channelModel.title;
    }];
}

///设置心愿单
- (void)showWishListViewTOcurren {                                                      
    [self endEditing:YES];
    kWeakSelf(self);
    [AddWishView addMineWishAndRoomId:-1 touid:-1 hasCover:NO Block:^(NSArray<ApiUsersLiveWishModel *> * _Nonnull wishList) {
        [weakself setWishView:wishList];
    }];
}

///设置心愿单
- (void)setWishView:(NSArray<ApiUsersLiveWishModel *> *)items{
    self.wishL.text = items.count>0?@"":kLocalizationMsg(@"设置心愿单");
    if (items.count>0) {
        NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] init];
        for (int i = 0; i<items.count; i++) {
            if (i < 2) {
                ApiUsersLiveWishModel *model = items[i];
                NSString *title = [NSString stringWithFormat:@"%@*%d",model.giftname,model.num];
                UIImage *imgG = [model.gifticon getImageFromURLStr];
                NSAttributedString *subStr = [title attachmentForImage:imgG bounds:CGRectMake(0, -4, 20, 20) before:YES];
                [muStr appendAttributedString:subStr];
                [muStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            }
        }
        self.wishL.attributedText = muStr;
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 8) {
        NSMutableString *muStr = [[NSMutableString alloc] initWithString:textView.text];
        textView.text = [muStr substringToIndex:8];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
    }
    return YES;
}

@end
