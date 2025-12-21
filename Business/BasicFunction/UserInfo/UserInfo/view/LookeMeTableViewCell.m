//
//  LookeMeTableViewCell.m
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LookeMeTableViewCell.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiUserAttenModel.h>
#import <LibProjView/KlcAvatarView.h>

@interface LookeMeTableViewCell()

@property(nonatomic,strong)NSIndexPath *indexpath;
@property(nonatomic,strong)KlcAvatarView *headImageV;
@property(nonatomic,strong)UITextView *userNameL;
@property (nonatomic, strong)UILabel *timeL;
@property(nonatomic,strong)UIButton *dealBtn;

@end
@implementation LookeMeTableViewCell

- (instancetype)initWithFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath{
     if (self = [super initWithFrame:frame]) {
         self.indexpath = indexPath;
         [self creatUI];
     }
     return self;
 }
- (void)layoutSubviews{
    [super layoutSubviews];
     
}
- (void)creatUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 50)];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    
    //头像
    KlcAvatarView *headerImageV = [[KlcAvatarView alloc]initWithFrame:CGRectMake(12, 0, 50, 50)];
    self.headImageV = headerImageV;
    [backView addSubview:self.headImageV];
    
    //昵称
    UITextView *userNameL = [[UITextView alloc]initWithFrame:CGRectMake(headerImageV.maxX+10, 5, kScreenWidth-24-50-80-20, 20)];
    userNameL.textAlignment = NSTextAlignmentLeft;
    userNameL.textColor =kRGB_COLOR(@"#333333");
    userNameL.font = [UIFont boldSystemFontOfSize:14];
    userNameL.editable = NO;
    userNameL.contentMode = UIViewContentModeLeft;
    userNameL.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    userNameL.scrollEnabled = NO;
    self.userNameL = userNameL;
    [backView addSubview:self.userNameL];
     
    //时间
    UILabel *timeL = [[UILabel alloc]initWithFrame:CGRectMake(headerImageV.maxX+10,userNameL.maxY, userNameL.width, 20)];
    timeL.textAlignment = NSTextAlignmentLeft;
    timeL.textColor =kRGB_COLOR(@"#999999");
    timeL.font = [UIFont systemFontOfSize:12];
    self.timeL = timeL;
    [backView addSubview:self.timeL];
 
    //按钮
    UIButton *dealBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-12-80, 10, 80, 30)];
    dealBtn.layer.cornerRadius = 15;
    dealBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dealBtn.clipsToBounds = YES;
    [dealBtn setBackgroundImage:[UIImage imageWithColor: kRGB_COLOR(@"#FFF1F8")] forState:UIControlStateNormal];
    [dealBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    dealBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [dealBtn setImage:[UIImage imageNamed:@"icon_fans_message"] forState:UIControlStateNormal];
    [dealBtn setTitle:kLocalizationMsg(@" 撩Ta") forState:UIControlStateNormal];
     
    [dealBtn addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.dealBtn = dealBtn;
    [backView addSubview:self.dealBtn];
    
}
- (void)setModel:(ApiUserAttenModel *)model{
    _model = model;
    self.dealBtn.selected = YES;
    
    [self.headImageV showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
    
    //昵称年龄
    NSString *nameStr = [NSString stringWithFormat:@"%@%d",self.model.username,self.model.age];
    NSMutableAttributedString *nameAttr = [[NSMutableAttributedString alloc]initWithString:nameStr];
    NSTextAttachment *genderAttach = [[NSTextAttachment alloc] init];
    genderAttach.image = [ProjConfig getAPPGenderImage:self.model.sex hasAge:NO];
    genderAttach.bounds = CGRectMake(0, -2, 12,12);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:genderAttach];
    [nameAttr insertAttributedString:attachString atIndex:self.model.username.length];
    [nameAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:kRGB_COLOR(@"#999999")} range:NSMakeRange(self.model.username.length+1, nameStr.length-self.model.username.length)];
    
    //等级
    NSString *rankUrl ;
    if (self.model.role > 0) {
        rankUrl = self.model.anchorGradeImg;
    }else{
        rankUrl = self.model.userGradeImg;
    }
    if (rankUrl.length > 0) {
        [nameAttr appendAttributedString:[self parserImgContext:rankUrl]];
    }
    ///设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    NSDictionary *attributes = @{
        NSParagraphStyleAttributeName:paragraphStyle
    };
    [nameAttr addAttributes:attributes range:NSMakeRange(0, nameAttr.length)];
    self.userNameL.attributedText = nameAttr;
    
    //时间
    self.timeL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ 看过你"),[model.addTime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm"]];
}

- (void)dealBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(LookeMeTableViewCellDealBtnClick:indexPath:)]) {
        [self.delegate LookeMeTableViewCellDealBtnClick:btn.selected indexPath:self.indexpath ];
    }
}
 
- (NSMutableAttributedString *)parserImgContext:(NSString *)url{
    NSMutableAttributedString *itemAttrM = [[NSMutableAttributedString alloc] initWithString:@" "];
    __block NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    kWeakSelf(self);
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            attach.image = image;
            NSRange range = [weakself rangeOfAttachment:attach];
            if (range.location < weakself.userNameL.attributedText.length) {
                [weakself.userNameL.layoutManager invalidateLayoutForCharacterRange:range actualCharacterRange:NULL];
            }
        });
    }];
    attach.bounds = CGRectMake(3, -3, 28,14);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
           
    //将图片插入到合适的位置
    [itemAttrM insertAttributedString:attachString atIndex:1];
    return itemAttrM;
}
- (NSRange)rangeOfAttachment:(NSTextAttachment *)attachment {
    __block NSRange ret;
    kWeakSelf(self);
    [self.userNameL.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                      inRange:NSMakeRange(0, weakself.userNameL.attributedText.length)
                                                      options:0
                                                   usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (attachment == value) {
            ret = range;
            *stop = YES;
        }
    }];
    return ret;
}
@end
