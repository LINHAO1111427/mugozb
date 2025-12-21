//
//  userFaceView.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SVUserFaceView.h"

#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/HttpApiAppShortVideo.h>

#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/LiveShareView.h>
#import <LibProjBase/LibProjBase.h>

#import "SVCommentListView.h"

#import <LibProjModel/ApiGiftSenderModel.h>
#import <LibProjView/PLayGiftAnimationObj.h>
#import <LibProjView/GiftGlobalNotice.h>
#import <LibProjModel/ShortVideoAdsVOModel.h>
#import <LibProjView/ShowGiftAnimationView.h>

@interface SVUserFaceView()

@property (nonatomic, strong)ApiShortVideoDtoModel *model;

@property (nonatomic, strong)UIButton *forwardBtn;
@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)UIButton *giftBtn;
@property (nonatomic, strong)UIButton *toVideoBtn;
@property (nonatomic, strong)NSIndexPath *indexP;

@property (nonatomic, weak) ShowGiftAnimationView *showGiftV;  ///显示礼物视图

@end
@implementation SVUserFaceView


- (void)layerLevel:(int)level withModel:(ApiShortVideoDtoModel *)model indexP:(NSIndexPath *)indexPath dataType:(int)dataType {

    [self removeAllSubViews];
    self.backgroundColor = [UIColor clearColor];
    self.model = model;
    self.indexP = indexPath;
    [self.superview insertSubview:self atIndex:level];
    
    
    CGFloat y = self.height;
    
    CGFloat width = 52;
    CGFloat x = self.width-width-14;
    if (dataType == 0) {
        //        y -= kTabBarHeight;
    }
    if (model.adsType > 0) {
        y -= 40;
    }
    ///多减一个底部距离
    if (self.height > (kScreenHeight-5)) {
        y -= kSafeAreaBottom;
    }
    y-=10;
    if (model.userId != [ProjConfig userId]) {//不是自己
        if ([ProjConfig isContain1v1]) {//包含1v1
            width = 60;
            x = self.width-width-14;
            y -= 80;
            UIButton *toVideoBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
            [toVideoBtn setImage:[UIImage imageNamed:@"short_video_tovideo_connect"] forState:UIControlStateNormal];
            [toVideoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            toVideoBtn.titleLabel.font = kFont(13);
            [toVideoBtn setTitle:kLocalizationMsg(@"与TA视频") forState:UIControlStateNormal];
            toVideoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [toVideoBtn setTitleEdgeInsets:UIEdgeInsetsMake(toVideoBtn.imageView.frame.size.height+3 ,-toVideoBtn.imageView.frame.size.width, 0.0,0.0)];
            [toVideoBtn setImageEdgeInsets:UIEdgeInsetsMake(-toVideoBtn.titleLabel.bounds.size.height,(toVideoBtn.frame.size.width-toVideoBtn.imageView.bounds.size.width)/2.0,0.0,(toVideoBtn.frame.size.width-toVideoBtn.imageView.bounds.size.width)/2.0)];
            [toVideoBtn addTarget:self action:@selector(toVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.toVideoBtn = toVideoBtn;
            [self addSubview:toVideoBtn];
        }
        
        if (model.userId > 0) {
            y -= 80;
            UIButton *giftBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
            [giftBtn setImage:[UIImage imageNamed:@"short_video_gift"] forState:UIControlStateNormal];
            [giftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            giftBtn.titleLabel.font = kFont(13);
            [giftBtn setTitle:kLocalizationMsg(@"送礼物") forState:UIControlStateNormal];
            giftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [giftBtn setTitleEdgeInsets:UIEdgeInsetsMake(giftBtn.imageView.frame.size.height+3 ,-giftBtn.imageView.frame.size.width, 0.0,0.0)];
            [giftBtn setImageEdgeInsets:UIEdgeInsetsMake(-giftBtn.titleLabel.bounds.size.height,(giftBtn.frame.size.width-giftBtn.imageView.bounds.size.width)/2.0,0.0,(giftBtn.frame.size.width-giftBtn.bounds.size.width)/2.0)];
            [giftBtn addTarget:self action:@selector(giftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.giftBtn = giftBtn;
            [self addSubview:giftBtn];
        }
    }
    
    y -= 80;
    UIButton *forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
    [forwardBtn setImage:[UIImage imageNamed:@"short_video_forward"] forState:UIControlStateNormal];
    [forwardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forwardBtn.titleLabel.font = kFont(13);
    [forwardBtn setTitle:kLocalizationMsg(@"转发") forState:UIControlStateNormal];
    forwardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [forwardBtn setTitleEdgeInsets:UIEdgeInsetsMake(forwardBtn.imageView.frame.size.height+3 ,-forwardBtn.imageView.frame.size.width, 0.0,0.0)];
    [forwardBtn setImageEdgeInsets:UIEdgeInsetsMake(-forwardBtn.titleLabel.bounds.size.height,(forwardBtn.frame.size.width-forwardBtn.imageView.bounds.size.width)/2.0,0.0,(forwardBtn.frame.size.width-forwardBtn.imageView.bounds.size.width)/2.0)];
    [forwardBtn addTarget:self action:@selector(forwardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.forwardBtn = forwardBtn;
    [self addSubview:forwardBtn];
    
    y -= 80;
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
    [commentBtn setImage:[UIImage imageNamed:@"short_video_comment"] forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commentBtn.titleLabel.font = kFont(13);
    [commentBtn setTitle:[NSString stringForCompressNum:model.comments] forState:UIControlStateNormal];
    commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(commentBtn.imageView.frame.size.height+3 ,-commentBtn.imageView.frame.size.width, 0.0,0.0)];
    [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(-commentBtn.titleLabel.bounds.size.height,(commentBtn.frame.size.width-commentBtn.imageView.bounds.size.width)/2.0,0.0,(commentBtn.frame.size.width-commentBtn.imageView.bounds.size.width)/2.0)];
    [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commentBtn = commentBtn;
    [self addSubview:commentBtn];
    
    y -= 80;
    UIButton *likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
    likeBtn.selected = model.isLike;
    [likeBtn setImage:[UIImage imageNamed:@"short_video_like_normal"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"short_video_like_selected"] forState:UIControlStateSelected];
    [likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    likeBtn.titleLabel.font = kFont(13);
    [likeBtn setTitle:[NSString stringForCompressNum:model.likes] forState:UIControlStateNormal];
    likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(likeBtn.imageView.frame.size.height+3 ,-likeBtn.imageView.frame.size.width, 0.0,0.0)];
    [likeBtn setImageEdgeInsets:UIEdgeInsetsMake(-likeBtn.titleLabel.bounds.size.height,(likeBtn.frame.size.width-likeBtn.imageView.bounds.size.width)/2.0,0.0,(likeBtn.frame.size.width-likeBtn.imageView.bounds.size.width)/2.0)];
    [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.likeBtn = likeBtn;
    [self addSubview:likeBtn];
    
    ///广告
    for (int i = 0; i<model.avatarAdsList.count; i++) {
        ShortVideoAdsVOModel *voModel = model.avatarAdsList[i];
        y -= 80;
        UIButton *adBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, 60)];
        adBtn.tag = 55781+i;
        [adBtn addTarget:self action:@selector(adBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:adBtn];
        UIImageView *adImgV = [[UIImageView alloc] initWithFrame:CGRectMake((width-40)/2.0, 2, 40, 40)];
        adImgV.contentMode = UIViewContentModeScaleAspectFill;
        adImgV.clipsToBounds = YES;
        adImgV.layer.cornerRadius = 5;
        adImgV.layer.masksToBounds = YES;
        [adImgV sd_setImageWithURL:[NSURL URLWithString:voModel.avatarAds]];
        [adBtn addSubview:adImgV];
        UILabel *adTitleL = [[UILabel alloc] init];
        adTitleL.font = kFont(13);
        adTitleL.text = voModel.adsTitle;
        adTitleL.textColor = [UIColor whiteColor];
        adTitleL.textAlignment = NSTextAlignmentCenter;
        [adBtn addSubview:adTitleL];
        [adTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(adImgV.mas_bottom).offset(4);
            make.centerX.equalTo(adBtn);
            make.height.mas_offset(16);
            make.width.mas_lessThanOrEqualTo(adBtn.width*1.5);
        }];
    }

    if (dataType == 4) {//单独的视频
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self commentBtnClick:commentBtn];
        });
    }
}


- (void)toVideoBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    if (self.otoCallClick) {
        self.otoCallClick();
    }
}


- (void)giftBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    kWeakSelf(self);
    GiftUserModel *userModel = [[GiftUserModel alloc]init];
    userModel.userId = self.model.userId;
    userModel.userName = self.model.username;
    userModel.userIcon = self.model.avatar;
    userModel.shortVideoId = self.model.id_field;
    [ChoiceGiftView showGift:9 users:@[userModel] hasContinue:YES sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
        [weakself playGiftAnimation:giftModelList];
    }];
}


- (void)commentBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    kWeakSelf(self);
    SVCommentListView *commentList = [[SVCommentListView alloc]initWithCommentModel:self.model];
    [commentList show];
    commentList.commentSuccess = ^(NSInteger commentNum) {
        NSInteger num = commentNum;
        weakself.model.comments = (int)num;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.commentBtn setTitle:[NSString stringForCompressNum:num] forState:UIControlStateNormal];
        });
    };
    commentList.showUserInfo = ^(int64_t toUserId) {
        if (self.userAvaterClick) {
            self.userAvaterClick(toUserId);
        }
    };
}


- (void)adBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 55781;
    if (self.adItemClick && self.model.avatarAdsList.count > index) {
        ShortVideoAdsVOModel *voModel = self.model.avatarAdsList[index];
        self.adItemClick(voModel.adsUrl);
    }
}


- (void)forwardBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (self.model.userId == [ProjConfig userId]) {
        ShareFunctionItem *shareFuncId = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_delete"] name:kLocalizationMsg(@"删除") clickBlock:^{
            weakself.removeBtnClick?weakself.removeBtnClick():nil;
        }];
        [LiveShareView showShareViewForType:4 shareId:self.model.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction],shareFuncId]];
    }else{
        ShareFunctionItem *report = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_report"] name:kLocalizationMsg(@"举报") clickBlock:^{
            [RouteManager routeForName:RN_shortVideo_report currentC:[ProjConfig currentVC] parameters:@{@"id":@(weakself.model.id_field),@"isShortVideo":@(1)}];
        }];
        [LiveShareView showShareViewForType:4 shareId:self.model.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction],report]];
    }
}
- (void)likeBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    kWeakSelf(self);
    [HttpApiAppShortVideo shortVideoZan:self.model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.model.isLike = !btn.selected;
                weakself.likeBtn.selected = !btn.selected;
                if (btn.selected) {
                    weakself.model.likes ++;
                }else{
                    weakself.model.likes --;
                }
                [btn setTitle:[NSString stringForCompressNum:weakself.model.likes] forState:UIControlStateNormal];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}


- (void)playGiftAnimation:(NSArray<ApiGiftSenderModel *> *)giftModelList{
    for (ApiGiftSenderModel *giftModel in giftModelList) {
        [self.showGiftV showGiftBanner:giftModel];
        [self.showGiftV playAnimationEffect:giftModel];
    }
}

- (ShowGiftAnimationView *)showGiftV{
    if (!_showGiftV) {
        ShowGiftAnimationView *showGiftV = [[ShowGiftAnimationView alloc] initWithFrame:self.bounds];
        [self addSubview:showGiftV];
        _showGiftV = showGiftV;
    }
    return _showGiftV;
}


- (void)dealloc
{
    [_showGiftV removeFromSuperview];
    _showGiftV = nil;
}

@end
