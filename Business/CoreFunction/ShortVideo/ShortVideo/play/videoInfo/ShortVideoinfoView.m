//
//  ShortVideoinfoView.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoinfoView.h"

#import <LibProjView/ShortVideoShopPlayView.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjView/KlcAvatarView.h>

@interface ShortVideoinfoView()

@property (nonatomic, strong)ApiShortVideoDtoModel *model;
@property (nonatomic, strong)UILabel *userNameLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)KlcAvatarView *avterBtn;
@property (nonatomic, strong)UIButton *attentBtn;//关注
@property (nonatomic, strong)NSArray *tags;
@property (nonatomic, strong)NSIndexPath *indexP;
@property (nonatomic, strong)UIView *backGuideV;
@property (nonatomic, assign)int level;
@end

@implementation ShortVideoinfoView

- (void)layerLevel:(int)level withModel:(ApiShortVideoDtoModel *)model indexP:(NSIndexPath *)indexPath dataType:(int)dataType{
    
    [self removeAllSubViews];

    self.backgroundColor = [UIColor clearColor];
    self.model = model;
    self.level = level;
    self.indexP = indexPath;
    [self.superview insertSubview:self atIndex:level];
    
    CGFloat y = self.height-10;
    if (dataType == 0) {
//         y -= kTabBarHeight;
    }
    
    if (self.height > (kScreenHeight-5)) {
        y -= kSafeAreaBottom;
    }
    y-=10;
    
    if (model.adsType> 0) {//广告
        UIView *adView = [[UIView alloc]initWithFrame:CGRectMake(0, y-40, self.width, 40)];
        adView.backgroundColor = [UIColor clearColor];
        [self addSubview:adView];
        y -= 40;
        
        UILabel *adNameL = [[UILabel alloc]initWithFrame:CGRectMake(14, 10, self.width-120, 20)];
        adNameL.textColor = [UIColor whiteColor];
        adNameL.textAlignment = NSTextAlignmentLeft;
        adNameL.font = [UIFont boldSystemFontOfSize:15];
        adNameL.text = model.adsTitle;
        [adView addSubview:adNameL];
        
        UIButton *adBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-104, 5, 90, 30)];
        adBtn.layer.cornerRadius = 15;
        adBtn.clipsToBounds = YES;
        adBtn.backgroundColor = kRGB_COLOR(@"#FFB10D");
        NSString *title = model.adsText;
        if (title.length == 0) {
            title = kLocalizationMsg(@"立即开始");
        }
        [adBtn setTitle:title forState:UIControlStateNormal];
        [adBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        adBtn.titleLabel.font = kFont(14);
        [adBtn addTarget:self action:@selector(adBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [adView addSubview:adBtn];
    }
    
    
    if (model.content.length > 0) {
        NSString *str = model.content;
        if (model.adsType > 0) {
            str = [NSString stringWithFormat:kLocalizationMsg(@"%@ 广告"),str];
        }
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.width-100, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:kFont(14)} context:nil].size;
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, y-size.height-5, self.width-100, size.height+5)];
        contentLabel.textColor = kRGB_COLOR(@"#FFFFFF");
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.numberOfLines = 0;
        contentLabel.font = kFont(14);
        if (model.adsType > 0) {
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:model.content];
            NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
            attchImage.image = [UIImage imageNamed:@"shortVideo_ads"];
            attchImage.bounds = CGRectMake(0, -2, 25, 12);
            NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
            [attri insertAttributedString:stringImage atIndex:model.content.length];
            contentLabel.attributedText = attri;
        }else{
            contentLabel.text = str;
        }
        self.contentLabel = contentLabel;
        [self addSubview:contentLabel];
        y -= size.height+5+10;
    }
    if (model.userId > 0) {
           KlcAvatarView *avaterBtn = [[KlcAvatarView alloc]initWithFrame:CGRectMake(14, y-50, 50, 50)];
           avaterBtn.userIcon.layer.borderWidth = 2;
           avaterBtn.userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
           [avaterBtn addTarget:self action:@selector(avaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           [avaterBtn showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
           y -= 60;
           self.avterBtn = avaterBtn;
           [self addSubview:avaterBtn];
           
           CGSize nameSize = [model.username boundingRectWithSize:CGSizeMake(self.width-100-60, 20) options:1 attributes:@{NSFontAttributeName:kFont(16)} context:nil].size;
           UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(avaterBtn.maxX+10, 0, nameSize.width+5, 20)];
           nameL.textColor = [UIColor whiteColor];
           nameL.font = kFont(16);
           nameL.centerY = avaterBtn.centerY;
           nameL.textAlignment = NSTextAlignmentLeft;
           nameL.text = model.username;
        self.userNameLabel = nameL;
           [self addSubview:nameL];
           
           if (model.userId != [ProjConfig userId]) {
               UIButton *attentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, avaterBtn.maxY-18, 36, 18)];
               attentBtn.layer.cornerRadius = 9;
               attentBtn.clipsToBounds = YES;
               attentBtn.centerX = avaterBtn.centerX;
               if (model.isAttention) {
                   attentBtn.selected = YES;
                   attentBtn.hidden = YES;
               }else{
                   attentBtn.hidden = NO;
               }
               attentBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
               [attentBtn addTarget:self action:@selector(attentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
               [attentBtn setBackgroundImage:[UIImage createImageSize:avaterBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FE73E1"),kRGB_COLOR(@"#9A58FF")] percentage:@[@0.3,@1.0] gradientType:GradientFromLeftToRight] forState:UIControlStateNormal];
               [attentBtn setBackgroundImage:[UIImage imageWithColor:kRGBA_COLOR(@"#000000", 0.4)] forState:UIControlStateSelected];
               [attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
               [attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
               attentBtn.titleLabel.font = kFont(11);
               [attentBtn setTitle:kLocalizationMsg(@"关注") forState:UIControlStateNormal];
               [attentBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateSelected];
               attentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
               self.attentBtn = attentBtn;
               [self addSubview:attentBtn];
           }
    }
     
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *tagStr = [model.classifyName stringByTrimmingCharactersInSet:set];
    if (tagStr.length > 0) {
        NSArray *arr = [tagStr componentsSeparatedByString:@","];
        self.tags = [NSArray arrayWithArray:arr];
        if (arr.count > 0) {
            CGFloat x = 14;
            for (int i = 0; i < arr.count; i++) {
                NSString *tag = arr[i];
                NSString *tagName = [NSString stringWithFormat:@"#%@#",tag];
                CGSize tagSize = [tagName boundingRectWithSize:CGSizeMake(self.width-100, 26) options:1 attributes:@{NSFontAttributeName:kFont(12)} context:nil].size;
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y-26, tagSize.width+10, 26)];
                btn.backgroundColor = kRGBA_COLOR(@"#000000", 0.4);
                btn.titleLabel.font = kFont(12);
                btn.layer.cornerRadius = 13;
                x += tagSize.width+15;
                btn.clipsToBounds = YES;
                btn.tag = i;
                [btn setTitle:tagName forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
            }
            
        }
        y -= 36;
    }
    
    if (model.productId > 0) {//购物
//        y -= 28;
        NSString *name = [NSString stringWithFormat:kLocalizationMsg(@"%@同款-%@  "),model.type==1?kLocalizationMsg(@"视频"):kLocalizationMsg(@"图片"),model.productName];
        CGSize textStr = [name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        CGFloat minW = MIN(textStr.width+20+4+8, kScreenWidth/2.0+30);
        CGFloat minH = 28;
        
        UIButton *goodBtn = [UIButton buttonWithType:0];
        goodBtn.backgroundColor = kRGBA_COLOR(@"#000000", 0.4);
        goodBtn.layer.cornerRadius = 14;
        goodBtn.clipsToBounds = YES;
        [goodBtn addTarget:self action:@selector(goodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goodBtn];
        [goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-(self.height-y));
            make.left.equalTo(self).offset(14);
            make.size.mas_equalTo(CGSizeMake(minW, minH));
        }];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textColor = [UIColor whiteColor];
        titleL.attributedText = [name attachmentForImage:[UIImage imageNamed:@"short_video_commodity"] bounds:CGRectMake(0, -5, 20, 20) before:YES];
        [goodBtn addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(goodBtn).inset(4);
            make.top.bottom.equalTo(goodBtn);
        }];
        
        BOOL hasGuide = [[NSUserDefaults standardUserDefaults] boolForKey:@"shortVideo_commodity_guide"];
        if (!hasGuide) {
            UIView *backGuideV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            backGuideV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            self.backGuideV = backGuideV;
            [[UIApplication sharedApplication].keyWindow addSubview:backGuideV];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(guideTap)];
            [backGuideV addGestureRecognizer:tap];
            
            UIImageView *borderImgV = [[UIImageView alloc] initWithFrame:CGRectMake(13, y-1-minH, minW+2, minH+2)];
            [backGuideV addSubview:borderImgV];

            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(70, y-80, 133, 64)];
            imageV.image = [UIImage imageNamed:@"short_video_commodity_guide"];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            [backGuideV addSubview:imageV];

            //虚线
            UIView *xxView = [[UIView alloc]initWithFrame:borderImgV.bounds];
            CAShapeLayer *border = [CAShapeLayer layer];
            border.strokeColor = [UIColor whiteColor].CGColor;
            border.fillColor = [UIColor clearColor].CGColor;
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:xxView.bounds cornerRadius:5];
            border.path = path.CGPath;
            border.frame = xxView.bounds;
            border.lineWidth = 1.5f;
            //虚线的间隔
            border.lineDashPattern = @[@4, @2];
            border.cornerRadius = 13.f;
            [xxView.layer addSublayer:border];
            borderImgV.image = [UIImage imageConvertFromView:xxView];
            
            kWeakSelf(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakself.backGuideV) {
                    [weakself.backGuideV removeAllSubViews];
                    [weakself.backGuideV removeFromSuperview];
                    weakself.backGuideV = nil;
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shortVideo_commodity_guide"];
                }
            });
        }
    }
}
 
- (void)tagBtnClick:(UIButton *)btn{
    NSString *tagStr = [self.model.classifyId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (tagStr.length > 0) {
        NSArray *arr = [tagStr componentsSeparatedByString:@","];
        NSInteger tagId = [arr[btn.tag] integerValue];
        if (arr.count > 0) {
            if (self.userTagClick) {
                self.userTagClick(tagId, self.tags[btn.tag]);
            }
        }
    }
}

- (void)guideTap{
    [self.backGuideV removeAllSubViews];
    [self.backGuideV removeFromSuperview];
    self.backGuideV = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shortVideo_commodity_guide"];
}
- (void)avaterBtnClick:(UIButton *)btn{
    if (self.userAvaterClick) {
        self.userAvaterClick();
    }
}
- (void)goodBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    [ShortVideoShopPlayView showInSuperV:self level:self.level modelWith:self.model pointY:btn.maxY+2 callBack:^(BOOL isCommoditySelected, ShortVideoShopPlayView * _Nonnull shopView) {
        if (isCommoditySelected) {
            if (self.goodsClick) {
                self.goodsClick();
            }
        }else{
            shopView = nil;
        }
    }];
}
- (void)attentBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    kWeakSelf(self);
    [HttpApiUserController setAtten:(self.model.isAttention?0:1) touid:self.model.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 weakself.model.isAttention = !weakself.model.isAttention;
                 weakself.attentBtn.selected = weakself.model.isAttention;
                weakself.attentBtn.hidden = weakself.model.isAttention;
            });
        }
    }];
}

- (void)adBtnClick:(UIButton *)btn{
    if (self.adsClick) {
        self.adsClick();
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}
 
@end
