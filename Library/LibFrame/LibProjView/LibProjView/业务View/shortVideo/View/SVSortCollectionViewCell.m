//
//  FocusCollectionViewCell.m
//  ShortVideo
//
//  Created by KLC on 2020/6/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SVSortCollectionViewCell.h"
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/KlcAvatarView.h>

@interface SVSortCollectionViewCell()
@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UIImageView *pic;
@property (nonatomic, strong)KlcAvatarView *avterImgeV;
@property (nonatomic, strong)UILabel *userNameLabel;
@property (nonatomic, strong)UITextField *commentTextfield;
@property (nonatomic, strong)UITextField *likeTextfield;
@property (nonatomic, strong)UIView *blurView;//模糊
@property (nonatomic, strong)UIVisualEffectView* effectView;//模糊
@end

@implementation SVSortCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize commentSize = [self.commentTextfield.text boundingRectWithSize:CGSizeMake(self.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(12)} context:nil].size;
    CGSize likeSize = [self.likeTextfield.text boundingRectWithSize:CGSizeMake(self.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(12)} context:nil].size;
    self.commentTextfield.width = commentSize.width+20;
    self.likeTextfield.width = likeSize.width+20;
    self.commentTextfield.x = self.width-self.commentTextfield.width-2;
    self.likeTextfield.x = self.width-self.commentTextfield.width-2-5-self.likeTextfield.width;;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-40)];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    bgImageV.clipsToBounds = YES;
    self.bgImageV = bgImageV;
    [self.contentView addSubview:self.bgImageV];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(1, 1);
    gradient.endPoint = CGPointMake(1, 0.3);
    gradient.frame = self.bgImageV.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) kRGBA_COLOR(@"#696969", 0.5).CGColor,(id) kRGBA_COLOR(@"#696969", 0.0).CGColor,nil];
    [self.bgImageV.layer insertSublayer:gradient atIndex:0];
    
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-35, 5, 30, 30)];
    pic.image = [UIImage imageNamed:@"shortVideo_pic"];
    pic.hidden = YES;
    self.pic = pic;
    [self.bgImageV addSubview:self.pic];
    
    UIView *blurView = [[UIView alloc]initWithFrame:self.bgImageV.bounds];
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = blurView.bounds;
    self.effectView = effectView;
    [blurView addSubview:self.effectView];
    [self.bgImageV addSubview:blurView];
    
    KlcAvatarView *avterImgeV = [[KlcAvatarView alloc]initWithFrame:CGRectMake(5, self.height-60, 40, 40)];
    self.avterImgeV = avterImgeV;
    [self.contentView addSubview:self.avterImgeV];
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(avterImgeV.maxX+5, 0, self.width-50, 20)];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.textColor = kRGB_COLOR(@"#333333");
    userNameLabel.font = kFont(13);
    self.userNameLabel = userNameLabel;
//    [self.contentView addSubview:self.userNameLabel];
    
    UITextField *likeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(self.width-125, self.height-40+10, 60, 20)];
    likeTextfield.enabled = NO;
    likeTextfield.textColor = kRGB_COLOR(@"#999999");
    likeTextfield.font = kFont(12);
    likeTextfield.textAlignment = NSTextAlignmentCenter;
    likeTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *leftImageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, -2, 20, 20)];
    leftImageV2.image = [UIImage imageNamed:@"shortVideo_sort_icon_like"];
    likeTextfield.leftView = leftImageV2;
    likeTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.likeTextfield = likeTextfield;
    [self.contentView addSubview:self.likeTextfield];
    
    UITextField *commentTextfield = [[UITextField alloc]initWithFrame:CGRectMake(self.width-62, 20, 60, 20)];
    commentTextfield.enabled = NO;
    commentTextfield.centerY = likeTextfield.centerY;
    commentTextfield.textColor = kRGB_COLOR(@"#999999");
    commentTextfield.font = kFont(12);
    commentTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    commentTextfield.textAlignment = NSTextAlignmentCenter;
    UIImageView *leftImageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, -2, 20, 20)];
    leftImageV1.image = [UIImage imageNamed:@"shortVideo_sort_icon_comment"];
    commentTextfield.leftView = leftImageV1;
    commentTextfield.leftViewMode = UITextFieldViewModeAlways;
    self.commentTextfield = commentTextfield;
    [self.contentView addSubview:self.commentTextfield];
    
    
     
}
- (void)setModel:(ApiShortVideoDtoModel *)model{
    if (![model isKindOfClass:[ApiShortVideoDtoModel class]]) {
        return;
    }
    _model = model;
    [self.bgImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    [self.avterImgeV showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
    self.likeTextfield.text = [NSString stringForCompressNum: model.likes];
    self.commentTextfield.text = [NSString stringForCompressNum:model.comments];
    self.pic.hidden = !(model.type -1);
    if (model.type == 2 && !model.isPay && model.isPrivate && model.userId != [ProjConfig userId]) {
        self.blurView.hidden = NO;
        self.effectView.hidden = NO;
    }else{
        self.effectView.hidden = YES;
        self.blurView.hidden = YES;
    }
    [self setNeedsLayout];
    
}
- (void)setHomeModel:(AppHomeHallDTOModel *)homeModel{
    if (![homeModel isKindOfClass:[AppHomeHallDTOModel class]]) {
        return;
    }
    _homeModel = homeModel;
    [self.bgImageV sd_setImageWithURL:[NSURL URLWithString:homeModel.sourceCover] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    [self.avterImgeV showUserIconUrl:homeModel.headImg vipBorderUrl:nil];
    self.likeTextfield.text = [NSString stringForCompressNum: homeModel.likeNum];
    self.commentTextfield.text = [NSString stringForCompressNum: homeModel.commentNum];
    self.pic.hidden = homeModel.sourceType != 13?YES:NO;
    
    ///图片 + 没付费 + 私密 + 不是自己的
    if (homeModel.sourceType == 13 && !homeModel.dspPay && homeModel.isPrivate && homeModel.userId != [ProjConfig userId]) {
        self.effectView.hidden = NO;
        self.blurView.hidden = NO;
    }else{
        self.effectView.hidden = YES;
        self.blurView.hidden = YES;
    }
    [self setNeedsLayout];
}


@end
 
