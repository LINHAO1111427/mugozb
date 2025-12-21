//
//  DynamicInterFaceView.m
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicInterfaceView.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjBase/MobManager.h>
#import <LibProjView/DYCommentListView.h>
#import <LibProjView/LiveShareView.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjView/ForceAlertController.h>
#import <Masonry/Masonry.h>
#import <LibProjView/KlcAvatarView.h>

@interface DynamicInterfaceView()
@property (nonatomic, strong)UIButton *forwardBtn;//转发
@property (nonatomic, strong)UIButton *likeBtn;//喜欢
@property (nonatomic, strong)UIButton *commentBtn;//评论

@property (nonatomic, strong)UILabel *userNameLabel;//名称
@property (nonatomic, strong)UILabel *locationTimeL;//定位与时间
@property (nonatomic, strong)UILabel *contentLabel;//标题
@property (nonatomic, strong)KlcAvatarView *avterBtn;//头像
@property (nonatomic, strong)UIButton *attentBtn;//关注
@property (nonatomic, strong)NSArray *tags;//标签分类

@end

@implementation DynamicInterfaceView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat bottomH = (kSafeAreaBottom+60);
    UIView *baseLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-bottomH, self.width, 0.1)];
    baseLine.hidden = YES;
    [self addSubview:baseLine];

    {
        CGFloat leftBottomY = 0;
        {
            [self addSubview:self.forwardBtn];
            [self.forwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(self.forwardBtn.size);
                make.bottom.equalTo(baseLine).inset(leftBottomY);
                make.right.equalTo(self).inset(14);
            }];
            leftBottomY += self.forwardBtn.height+20;
        }
        
        if ([[ProjConfig shareInstence].baseConfig hasDynamicComment]) {
            [self addSubview:self.commentBtn];
            [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(self.commentBtn.size);
                make.bottom.equalTo(baseLine).inset(leftBottomY);
                make.right.equalTo(self).inset(14);
            }];
            leftBottomY += self.commentBtn.height+20;
        }
        
        {
            [self addSubview:self.likeBtn];
            [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(self.likeBtn.size);
                make.bottom.equalTo(baseLine).inset(leftBottomY);
                make.right.equalTo(self).inset(14);
            }];
            leftBottomY += self.likeBtn.height+20;
        }
        
    }
    
    {
        [self addSubview:self.contentLabel];
        [self addSubview:self.avterBtn];
        [self addSubview:self.attentBtn];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.locationTimeL];

        ///文字
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(12);
            make.width.mas_equalTo(kScreenWidth-80);
            make.bottom.equalTo(baseLine);
        }];
        ///头像
        [self.avterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.size.mas_equalTo(CGSizeMake(54, 54));
            make.bottom.equalTo(self.contentLabel.mas_top).mas_offset(-20);
        }];
        ///关注
        [self.attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.avterBtn);
            make.size.mas_equalTo(CGSizeMake(36, 18));
            make.bottom.equalTo(self.avterBtn);
        }];
        [self.attentBtn layoutIfNeeded];
        self.attentBtn.layer.cornerRadius = 9;
        
        ///用户名称
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avterBtn).mas_offset(-12);
            make.size.mas_equalTo(kScreenWidth-24-60-60);
            make.left.equalTo(self.avterBtn.mas_right).mas_offset(10);
            make.height.mas_equalTo(20);
        }];
        

        [self.locationTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.userNameLabel);
            make.top.equalTo(self.userNameLabel.mas_bottom).mas_offset(4);
            make.height.mas_equalTo(20);
        }];
    }

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    CGFloat scale = (kSafeAreaBottom+60+74)/kScreenHeight;
    gradient.startPoint = CGPointMake(1, 1);
    gradient.endPoint = CGPointMake(1,scale);
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) kRGBA_COLOR(@"#696969", 0.5).CGColor,(id) kRGBA_COLOR(@"#696969", 0.0).CGColor,nil];
    [self.layer insertSublayer:gradient atIndex:0];

}

- (void)likeBtnClick:(UIButton *)btn{
    [self btnClick:0];
    [self doLikeNow];
}
- (void)commentBtnClick:(UIButton *)btn{
    [self btnClick:1];
    [self commentNow];
}
- (void)forwardBtnClick:(UIButton *)btn{
    [self btnClick:2];
    [self forwardNow];
}
- (void)avaterBtnClick:(UIButton *)btn{
    [self btnClick:3];
}
- (void)attentBtnClick:(UIButton *)btn{
    [self btnClick:4];
    [self doAttentNow];
}
- (void)btnClick:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicInterfaceViewBtnClick:dynamicModel:index:)]) {
        [self.delegate dynamicInterfaceViewBtnClick:self dynamicModel:self.model index:index];
    }
}
- (void)doLikeNow{
    kWeakSelf(self);
    [HttpApiDynamicController dynamicZan:self.model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.model.isLike = !weakself.model.isLike;
            weakself.model.likes = weakself.model.likes + (weakself.model.isLike?1:-1);
            weakself.model.likes = weakself.model.likes>=0?weakself.model.likes:0;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.likeBtn.selected = weakself.model.isLike;
                [weakself.likeBtn setTitle:[NSString stringForCompressNum:weakself.model.likes] forState:UIControlStateNormal];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)doAttentNow{
    kWeakSelf(self);
    [HttpApiUserController setAtten:self.model.isAtt?0:1 touid:self.model.uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.model.isAtt = !weakself.model.isAtt;
                weakself.attentBtn.selected = weakself.model.isAtt;
                weakself.attentBtn.hidden = weakself.model.isAtt;
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)commentNow{
    DYCommentListView *commentList = [[DYCommentListView alloc]initWithCommentModel:self.model];
    [commentList show];
    kWeakSelf(self);
    commentList.commentSuccess = ^(int commentNum) {
        weakself.model.comments = commentNum;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.commentBtn setTitle:[NSString stringForCompressNum:commentNum] forState:UIControlStateNormal];
        });
    };
    commentList.showUserInfo = ^(int64_t toUserId) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicInterfaceViewBtnClick:userInfoJump:)]) {
            [self.delegate dynamicInterfaceViewBtnClick:self userInfoJump:toUserId];
        }
    };
}

- (void)forwardNow{
    if (_model.uid == [KLCUserInfo getUserId]) {
        ShareFunctionItem *shareFuncId = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_delete"] name:kLocalizationMsg(@"删除") clickBlock:^{
            ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定删除这条动态？")];
            [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
            [alertVC addOptions:kLocalizationMsg(@"删除") textColor:ForceAlert_NormalColor clickHandle:^{
                [HttpApiDynamicController delDynamic:self.model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                    if (code == 1) {
                        [[ProjConfig currentVC].navigationController popViewControllerAnimated:YES];
                    } else {
                        [SVProgressHUD showInfoWithStatus:strMsg];
                    }
                }];
            }];
            [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
        }];
        [LiveShareView showShareViewForType:1 shareId:self.model.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction], shareFuncId]];
    } else {
        kWeakSelf(self);
        ShareFunctionItem *reportFunctionItem = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_report"] name:kLocalizationMsg(@"举报") clickBlock:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicInterfaceViewBtnClick:reportDyanamic:)]) {
                [self.delegate dynamicInterfaceViewBtnClick:self reportDyanamic:weakself.model];
            }
        }];
        [LiveShareView showShareViewForType:1 shareId:self.model.id_field moreFunction:@[[ShareFunctionItem getCopyLinkFunction],reportFunctionItem]];
        
    }
}


- (void)setModel:(ApiUserVideoModel *)model{
    _model = model;
    [self.commentBtn setTitle:[NSString stringForCompressNum:model.comments] forState:UIControlStateNormal];
    self.likeBtn.selected = model.isLike;
    [self.likeBtn setTitle:[NSString stringForCompressNum:model.likes] forState:UIControlStateNormal];
    [self.avterBtn showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
    self.userNameLabel.text = model.userName;
    NSString *tagStr  = @"";
    if (model.topicName.length > 0) {
        tagStr = [NSString stringWithFormat:@"#%@#",model.topicName];
    }
    NSString *title = [NSString stringWithFormat:@"%@",model.title];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",tagStr,title]];
    if (attri.length == 0) {
        [self setNeedsLayout];
    }else{
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:NSMakeRange(0, tagStr.length)];
        self.contentLabel.attributedText = attri;
    }

    
    NSString *timestr = @"";
    if (model.addtimeStr.length > 0) {
        timestr = model.addtimeStr;
    }
    NSAttributedString *attrTimeStr = [[NSAttributedString alloc] initWithString:timestr];
    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance] && model.hidePublishingAddress == 0){ ///有定位显示
        NSString *location;
        if (model.city.length > 0 || model.address.length>0) {
            location = [NSString stringWithFormat:@"%@·%@",model.city,model.address];
        }else{
            location = @"";
        }
        timestr = [NSString stringWithFormat:@"%@·%@",location,timestr];
        attrTimeStr = [timestr attachmentForImage:[UIImage imageNamed:@"dynamic_location"] bounds:CGRectMake(0, -3, 10, 14) before:YES];
    }
    
    self.locationTimeL.attributedText = attrTimeStr;
     
    
    self.attentBtn.selected = model.isAtt;
    self.attentBtn.hidden = self.model.isAtt;
    if (model.uid == [ProjConfig userId]) {
        self.attentBtn.hidden = YES;
    }
    [self setNeedsLayout];

}

#pragma mark - lazy load
- (UIButton *)forwardBtn{
    if (!_forwardBtn) {
        CGFloat width = 52;
        _forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-width-14, kScreenHeight-kTabBarHeight-80, width, 60)];
        [_forwardBtn setImage:[UIImage imageNamed:@"short_video_forward"] forState:UIControlStateNormal];
        [_forwardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forwardBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_forwardBtn setTitle:kLocalizationMsg(@"转发") forState:UIControlStateNormal];
        _forwardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_forwardBtn setTitleEdgeInsets:UIEdgeInsetsMake(_forwardBtn.imageView.frame.size.height+3 ,-_forwardBtn.imageView.frame.size.width, 0.0,0.0)];
        [_forwardBtn setImageEdgeInsets:UIEdgeInsetsMake(-_forwardBtn.titleLabel.bounds.size.height,(_forwardBtn.frame.size.width-_forwardBtn.imageView.bounds.size.width)/2.0,0.0,(_forwardBtn.frame.size.width-_forwardBtn.imageView.bounds.size.width)/2.0)];
        [_forwardBtn addTarget:self action:@selector(forwardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forwardBtn;
}
- (UIButton *)commentBtn{
    if (!_commentBtn) {
        UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(_forwardBtn.x,_forwardBtn.y-80, 52, 60)];
        [commentBtn setImage:[UIImage imageNamed:@"short_video_comment"] forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [commentBtn setTitle:[NSString stringForCompressNum:self.model.comments] forState:UIControlStateNormal];
        commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(commentBtn.imageView.frame.size.height+3 ,-commentBtn.imageView.frame.size.width, 0.0,0.0)];
        [commentBtn setImageEdgeInsets:UIEdgeInsetsMake(-commentBtn.titleLabel.bounds.size.height,(commentBtn.frame.size.width-commentBtn.imageView.bounds.size.width)/2.0,0.0,(commentBtn.frame.size.width-commentBtn.imageView.bounds.size.width)/2.0)];
        [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _commentBtn = commentBtn;
    }
    return _commentBtn;
}
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        UIButton *likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_forwardBtn.x, _commentBtn.y-80, 52, 60)];
        likeBtn.selected = NO;
        [likeBtn setImage:[UIImage imageNamed:@"short_video_like_normal"] forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"short_video_like_selected"] forState:UIControlStateSelected];
        [likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        likeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [likeBtn setTitle:[NSString stringForCompressNum:self.model.likes] forState:UIControlStateNormal];
        likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(likeBtn.imageView.frame.size.height+3 ,-likeBtn.imageView.frame.size.width, 0.0,0.0)];
        [likeBtn setImageEdgeInsets:UIEdgeInsetsMake(-likeBtn.titleLabel.bounds.size.height,(likeBtn.frame.size.width-likeBtn.imageView.bounds.size.width)/2.0,0.0,(likeBtn.frame.size.width-likeBtn.imageView.bounds.size.width)/2.0)];
        [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn = likeBtn;
    }
    return _likeBtn;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = kRGB_COLOR(@"#FFFFFF");
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (KlcAvatarView *)avterBtn{
    if (!_avterBtn) {
        KlcAvatarView *avaterBtn = [[KlcAvatarView alloc]init];
        avaterBtn.userIcon.layer.borderWidth = 2;
        avaterBtn.userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        [avaterBtn addTarget:self action:@selector(avaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _avterBtn = avaterBtn;
    }
    return _avterBtn;
}
- (UIButton *)attentBtn{
    if (!_attentBtn) {
        UIButton *attentBtn = [[UIButton alloc]init];
        attentBtn.clipsToBounds = YES;
        attentBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [attentBtn addTarget:self action:@selector(attentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [attentBtn setBackgroundImage:[UIImage imageNamed:@"live_btn_purple"] forState:UIControlStateNormal];
        [attentBtn setBackgroundImage:[UIImage imageWithColor:kRGBA_COLOR(@"#000000", 0.4)] forState:UIControlStateSelected];
        [attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        attentBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [attentBtn setTitle:kLocalizationMsg(@"关注") forState:UIControlStateNormal];
        [attentBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateSelected];
        attentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _attentBtn = attentBtn;
    }
    return _attentBtn;
}
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        UILabel *nameL = [[UILabel alloc]init];
        nameL.textColor = [UIColor whiteColor];
        nameL.font = [UIFont systemFontOfSize:16];
        nameL.textAlignment = NSTextAlignmentLeft;
        _userNameLabel = nameL;
    }
    return _userNameLabel;
}
- (UILabel *)locationTimeL{
    if (!_locationTimeL) {
        _locationTimeL = [[UILabel alloc]initWithFrame:CGRectMake(_avterBtn.maxX+10, _userNameLabel.maxY+4, kScreenWidth-24-60-54, 20)];
        _locationTimeL.textColor = kRGBA_COLOR(@"#FFFFFF", 0.8);
        _locationTimeL.font = [UIFont systemFontOfSize:12];
        _locationTimeL.textAlignment = NSTextAlignmentLeft;
    }
    return _locationTimeL;
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

@end
