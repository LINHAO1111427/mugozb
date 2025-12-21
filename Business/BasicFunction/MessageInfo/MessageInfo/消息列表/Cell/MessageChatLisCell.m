//
//  MessageChatLisCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "MessageChatLisCell.h"

#import "TimeTool.h"
#import "MessageChatModel.h"

#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppUserAvatarModel.h>

#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
 
@interface FamilyMsgLevelInfoView : UIView

@property (nonatomic , weak)UIImageView *familyImgV;

@property (nonatomic , weak)UIImageView *levelImgV;

@property (nonatomic,  assign)int groupType;

@end

@implementation FamilyMsgLevelInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView *familyImgV = [[UIImageView alloc] init];
    familyImgV.layer.masksToBounds = YES;
    familyImgV.layer.cornerRadius = 3;
    [self addSubview:familyImgV];
    self.familyImgV = familyImgV;
    [familyImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(familyImgV.mas_height);
        make.left.equalTo(self);
    }];
    
    UIImageView *levelImgV = [[UIImageView alloc] init];
    levelImgV.layer.masksToBounds = YES;
    levelImgV.layer.cornerRadius = 3;
    [self addSubview:levelImgV];
    self.levelImgV = levelImgV;
    [levelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(familyImgV.mas_height);
        make.left.equalTo(familyImgV.mas_right).offset(5);
    }];
    
    UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textL.font = [UIFont systemFontOfSize:14];
    textL.textColor = [UIColor whiteColor];
    textL.textAlignment = NSTextAlignmentCenter;
    textL.text = kLocalizationMsg(@"族");
    textL.backgroundColor = [UIColor orangeColor];
    familyImgV.image = [UIImage imageConvertFromView:textL];
}

- (void)setGroupType:(int)groupType{
    _groupType = groupType;
    switch (groupType) {
        case 1: ///粉丝团
        {
            UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            textL.font = [UIFont systemFontOfSize:14];
            textL.textColor = [UIColor whiteColor];
            textL.textAlignment = NSTextAlignmentCenter;
            textL.text = kLocalizationMsg(@"团");
            textL.backgroundColor = kRGBA_COLOR(@"#ee41bf", 1.0);
            self.familyImgV.image = [UIImage imageConvertFromView:textL];
        }
            break;
        default:
        {
            UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            textL.font = [UIFont systemFontOfSize:14];
            textL.textColor = [UIColor whiteColor];
            textL.textAlignment = NSTextAlignmentCenter;
            textL.text = kLocalizationMsg(@"族");
            textL.backgroundColor = [UIColor orangeColor];
            self.familyImgV.image = [UIImage imageConvertFromView:textL];
        }
            break;
    }
}

@end



@interface MessageChatLisCell ()

@property (nonatomic, strong)KlcAvatarView *headImgView;
@property (nonatomic, strong)UILabel *tittleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *imsgTimeLabel;
@property (nonatomic, strong)UILabel *unreadNumLabel;
@property (nonatomic, strong)UIImageView *statusImageV;
@property (nonatomic, strong)UIImageView *topImageV;
@property (nonatomic, weak)FamilyMsgLevelInfoView *familyIconV;

@property(nonatomic,strong)SWHTapImageView *roleImageV;
@property (nonatomic, strong)UIImageView *vipImgV;
@property(nonatomic,strong)UIImageView *svipImageV;

@end

@implementation MessageChatLisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        longPressGesture.minimumPressDuration = 0.5f;
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

-(void)creatSubView{
    
    self.headImgView = [[KlcAvatarView alloc] initWithFrame:CGRectMake(12, 13, 44, 44)];
    [self.contentView addSubview:self.headImgView];
    
    self.statusImageV = [[UIImageView alloc] initWithFrame:CGRectMake(46, 49, 8, 8)];
    self.statusImageV.layer.cornerRadius = 4;
    self.statusImageV.layer.masksToBounds = YES;
    self.statusImageV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.statusImageV];
    self.statusImageV.hidden = YES;
    
    self.tittleLabel = [[UILabel alloc] init];
    self.tittleLabel.font = [UIFont systemFontOfSize:15];
    self.tittleLabel.textColor = kRGB_COLOR(@"#333333");
    self.tittleLabel.text = @"";
    [self.contentView addSubview:self.tittleLabel];
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(12);
        make.top.equalTo(self.headImgView);
    }];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, CGRectGetMaxY(self.tittleLabel.frame) + 1, kScreenWidth - 42 - CGRectGetMaxX(self.headImgView.frame) - 12, 22)];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = kRGB_COLOR(@"#888888");
    self.contentLabel.text = @"";
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tittleLabel);
        make.bottom.equalTo(self.headImgView);
        make.right.equalTo(self.contentView).offset(-40);
    }];
    
    
    self.imsgTimeLabel = [[UILabel alloc] init];
    self.imsgTimeLabel.font = [UIFont systemFontOfSize:12];
    self.imsgTimeLabel.textAlignment = NSTextAlignmentRight;
    self.imsgTimeLabel.textColor = kRGB_COLOR(@"#CCCCCC");
    self.imsgTimeLabel.text = @"";
    [self.contentView addSubview:self.imsgTimeLabel];
    [self.imsgTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tittleLabel);
        make.right.equalTo(self.contentView).offset(-12);
    }];
    
    self.topImageV = [[UIImageView alloc] initWithFrame:CGRectMake(46, 49, 8, 8)];
    self.topImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.topImageV];
    self.topImageV.hidden = YES;
    self.topImageV.image = [UIImage imageNamed:@"icon_relation_top"];
    [self.topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imsgTimeLabel.mas_left).inset(5);
        make.centerY.equalTo(self.imsgTimeLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    self.unreadNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - 18, CGRectGetMaxY(self.tittleLabel.frame)+2, 18, 18)];
    self.unreadNumLabel.layer.cornerRadius = 9;
    self.unreadNumLabel.layer.masksToBounds = YES;
    self.unreadNumLabel.backgroundColor = [UIColor redColor];
    self.unreadNumLabel.textAlignment = NSTextAlignmentCenter;
    self.unreadNumLabel.font = [UIFont systemFontOfSize:12];
    self.unreadNumLabel.textColor = [UIColor whiteColor];
    self.unreadNumLabel.text = @"0";
    [self.contentView addSubview:self.unreadNumLabel];
    [self.unreadNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(self.imsgTimeLabel);
        make.bottom.equalTo(self.contentLabel);
    }];
    
    
    UIView *linkView = [[UIView alloc] init];
    linkView.backgroundColor = kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    FamilyMsgLevelInfoView *familyIconV = [[FamilyMsgLevelInfoView alloc] init];
    familyIconV.hidden = YES;
    [self.contentView addSubview:familyIconV];
    self.familyIconV = familyIconV;
    [familyIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(self.tittleLabel);
        make.left.equalTo(self.tittleLabel.mas_right).offset(10);
    }];
    
    //角色
    SWHTapImageView *roleImageV = [[SWHTapImageView alloc]init];
    roleImageV.contentMode = UIViewContentModeScaleAspectFit;
    self.roleImageV = roleImageV;
    [self addSubview:roleImageV];
    //这里一般情况隐藏了
    [roleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tittleLabel.mas_right).offset(2);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.tittleLabel);
    }];
    
    //vip
    UIImageView *vipImgV = [[UIImageView alloc] init];
    vipImgV.hidden = YES;
    vipImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:vipImgV];
    self.vipImgV = vipImgV;
    [vipImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roleImageV.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.centerY.equalTo(self.tittleLabel);
    }];
    
    UIImageView *svipImageV = [[UIImageView alloc]init];
    svipImageV.contentMode = UIViewContentModeScaleAspectFit;
    svipImageV.hidden = YES;
    self.svipImageV = svipImageV;
    [self addSubview:svipImageV];
    [svipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vipImgV.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.centerY.equalTo(self.tittleLabel);
    }];

}


- (void)showUserInfo:(MessageChatModel *)mModel  {
    if (mModel.isGroupMsg) { ///群消息
        self.vipImgV.hidden = YES;
        self.familyIconV.hidden = NO;
        self.familyIconV.groupType = mModel.groupMsg.groupType;
        [self.familyIconV.levelImgV sd_setImageWithURL:[NSURL URLWithString:mModel.groupMsg.groupLevel]];
    }else{ ///个人消息
        self.vipImgV.hidden = NO;
        self.familyIconV.hidden = YES;
        [self.vipImgV sd_setImageWithURL:[NSURL URLWithString:mModel.singleMsg.otherNobleMedalStr]];
    }

    if (mModel.isGroupMsg) {
        self.tittleLabel.text = mModel.groupMsg.groupName;
        [self.headImgView showUserIconUrl:mModel.groupMsg.groupPic vipBorderUrl:@""];
    }else{
        self.tittleLabel.text = mModel.singleMsg.otherUserName;
        [self.headImgView showUserIconUrl:mModel.singleMsg.otherUserAvater vipBorderUrl:@""];
    }

    //未读
    if (mModel.unReadNum != 0) {
        self.unreadNumLabel.hidden = NO;
        self.unreadNumLabel.text = [NSString stringWithFormat:@"%ld",(long)mModel.unReadNum];
    }else if (mModel.unReadNum > 99){
        self.unreadNumLabel.hidden = NO;
        self.unreadNumLabel.text = @"99⁺";
    }else{
        self.unreadNumLabel.hidden = YES;
    }
    
    self.topImageV.hidden = !mModel.isTop;
    
    //最后一条时间
    NSString *time = [TimeTool getTimeStringAutoShort2:mModel.imMessage.tx_message.timestamp mustIncludeTime:NO];
    self.imsgTimeLabel.text = time;

    CGFloat timeW = [self.imsgTimeLabel.text widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22];

    self.imsgTimeLabel.frame =  CGRectMake(kScreenWidth - 12 - timeW, CGRectGetMinY(self.tittleLabel.frame), timeW, 22);
    self.tittleLabel.frame = CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, 11, kScreenWidth - timeW - 12 - CGRectGetMaxX(self.headImgView.frame) - 12, 22);

    ///最后一条消息
    self.contentLabel.text = mModel.msgTitle;
    NSMutableAttributedString *attstr = [[mModel.msgTitle changeTextForCostomEmojiAndBounds:CGRectMake(0, -5, 21, 21)] mutableCopy];
    self.contentLabel.attributedText = attstr;
     
}

 
-(void)cellLongPress:(UILongPressGestureRecognizer *)longRecognizer{

    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        if (self.cellLongTapBlock) {
            self.cellLongTapBlock();
        }
    }
    
}


@end
