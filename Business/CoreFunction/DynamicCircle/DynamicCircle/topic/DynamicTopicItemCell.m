//
//  DynamicTopicItemCell.m
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicTopicItemCell.h"
 

@interface DynamicTopicItemCell()
@property (nonatomic, strong)UIImageView *dyBackgroundView;
@property (nonatomic, strong)UIView *dyBackWhiteView;
@property (nonatomic, strong)UIImageView *thumbImageV;//封面
@property (nonatomic, strong)UIImageView *avaterImageV;//头像
@property (nonatomic, strong)UILabel *titleL;//话题标题
@property (nonatomic, strong)UILabel *userNameL;//昵称
@property (nonatomic, strong)UILabel *likeL;//点赞
@end
@implementation DynamicTopicItemCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.model.title.length == 0 && self.model.topicName.length == 0) {
        self.titleL.hidden = YES;
        self.avaterImageV.y = self.thumbImageV.maxY+5;
        self.userNameL.centerY = self.avaterImageV.centerY;
        self.likeL.centerY = self.avaterImageV.centerY;
    }else{
        self.titleL.hidden = NO;
        self.avaterImageV.y = self.titleL.maxY+2;
        self.userNameL.centerY = self.avaterImageV.centerY;
        self.likeL.centerY = self.avaterImageV.centerY;
    }
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    [self.contentView addSubview:self.dyBackgroundView];
    [self.dyBackgroundView addSubview:self.dyBackWhiteView];
    [self.dyBackWhiteView addSubview:self.thumbImageV];
    [self.dyBackWhiteView addSubview:self.titleL];
    [self.dyBackWhiteView addSubview:self.avaterImageV];
    [self.dyBackWhiteView addSubview:self.userNameL];
    [self.dyBackWhiteView addSubview:self.likeL];
}
- (void)setModel:(ApiUserVideoModel *)model{
    _model = model;
    if (model.type == 2 || model.type == 0) {//图片文字
        NSString *url = [model.images componentsSeparatedByString:@","].firstObject;
        [self.thumbImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    }else{//视频
        [self.thumbImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    }
    self.titleL.text = model.title;
    NSString * text= model.topicName.length?kStringFormat(@"#%@#  %@",model.topicName,model.title):model.title;
    self.titleL.text = text;
    
    if (!model.isVip) {
        self.dyBackgroundView.image =  [UIImage imageNamed:@"bf_dynamic_frame"];
    }else{
        self.dyBackgroundView.image = [UIImage imageWithColor:kRGBA_COLOR(@"#CCCCCC", 0.3)];
    }
    self.userNameL.text = model.userName;
    [self.avaterImageV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getAppIcon]];
    
    NSString *likeStr = [NSString stringWithFormat:@" %d",model.likes];
    NSMutableAttributedString *likeAttriStr = [[NSMutableAttributedString alloc]initWithString:likeStr];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"videoLive_like"];
    attach.bounds = CGRectMake(0, -3, 15, 15);
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attach];
    [likeAttriStr insertAttributedString:att atIndex:0];
    self.likeL.attributedText = likeAttriStr;
     
    [self setNeedsLayout];
}
 
#pragma mark - lazy load
- (UIImageView *)thumbImageV{
    if (!_thumbImageV) {
        CGFloat scale = 164/360.0;
        CGFloat width = kScreenWidth*scale;
        _thumbImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , width-6, width-6)];
        _thumbImageV.backgroundColor = [UIColor lightGrayColor];
        _thumbImageV.clipsToBounds = YES;
        _thumbImageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _thumbImageV;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(5, _thumbImageV.maxY+2, _thumbImageV.width-10, 40)];
        _titleL.textColor = kRGB_COLOR(@"#888888");
        _titleL.font = [UIFont systemFontOfSize:12];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UIImageView *)avaterImageV{
    if (!_avaterImageV) {
        _avaterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, _thumbImageV.maxY+_titleL.height+8, 26, 26)];
        _avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
        _avaterImageV.layer.cornerRadius  = 13;
        _avaterImageV.image = [ProjConfig getAppIcon];
        _avaterImageV.clipsToBounds = YES;
    }
    return _avaterImageV;;
}
- (UILabel *)userNameL{
    if (!_userNameL) {
        _userNameL = [[UILabel alloc]initWithFrame:CGRectMake(_avaterImageV.maxX+10, 0, _thumbImageV.width-80-26, 20)];
        _userNameL.centerY = _avaterImageV.centerY;
        _userNameL.textColor = kRGB_COLOR(@"#888888");
        _userNameL.font = [UIFont systemFontOfSize:14];
        _userNameL.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameL;
}
- (UILabel *)likeL{
    if (!_likeL) {
        _likeL = [[UILabel alloc]initWithFrame:CGRectMake(_userNameL.maxX, 0, 60, 20)];
        _likeL.centerY = _avaterImageV.centerY;
        _likeL.textAlignment = NSTextAlignmentRight;
        _likeL.textColor = kRGB_COLOR(@"#888888");
        _likeL.font = [UIFont systemFontOfSize:13];
    }
    return _likeL;
}
- (UIImageView *)dyBackgroundView{
    if (!_dyBackgroundView) {
        _dyBackgroundView = [[UIImageView alloc]initWithFrame:self.bounds];
        _dyBackgroundView.contentMode = UIViewContentModeScaleToFill;
        _dyBackgroundView.userInteractionEnabled = YES;
        _dyBackgroundView.layer.cornerRadius = 10;
        _dyBackgroundView.clipsToBounds = YES;
    }
    return _dyBackgroundView;
}
- (UIView *)dyBackWhiteView{
    if (!_dyBackWhiteView) {
        CGFloat scale = 164/360.0;
        CGFloat width = kScreenWidth*scale;
        _dyBackWhiteView = [[UIView alloc]initWithFrame:CGRectMake(3, 3, width-6, self.height-6)];
        _dyBackWhiteView.layer.cornerRadius = 10;
        _dyBackWhiteView.clipsToBounds = YES;
        _dyBackWhiteView.backgroundColor = [UIColor whiteColor];
    }
    return _dyBackWhiteView;
}
 
@end
