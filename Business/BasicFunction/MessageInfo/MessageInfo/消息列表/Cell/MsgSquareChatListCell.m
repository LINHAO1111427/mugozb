//
//  MsgSquareChatListCell.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/10.
//

#import "MsgSquareChatListCell.h"
#import "TimeTool.h"
#import "MessageChatModel.h"

#import <LibTools/LibTools.h>
#import  <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppHomeChatPlazaVOModel.h>


@interface MsgSquareChatListCell ()

@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *numL;

@end


@implementation MsgSquareChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)creatSubView{
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 44, 44)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = 22;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, 12, 120, 22)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = kRGB_COLOR(@"#333333");
    self.titleLabel.text = @"";
    [self.contentView addSubview:self.titleLabel];
    
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, CGRectGetMaxY(self.titleLabel.frame) + 1, kScreenWidth - 42 - CGRectGetMaxX(self.headImgView.frame) - 12, 22)];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = kRGB_COLOR(@"#888888");
    self.contentLabel.text = @"";
    [self.contentView addSubview:self.contentLabel];
    
    self.numL = [[UILabel alloc] init];
    self.numL.font = [UIFont systemFontOfSize:12];
    self.numL.textAlignment = NSTextAlignmentRight;
    self.numL.textColor = kRGB_COLOR(@"#CCCCCC");
    self.numL.text = @"";
    [self.contentView addSubview:self.numL];
    [self.numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.titleLabel);
    }];
    
    
    UIView *linkView = [[UIView alloc] init];
    linkView.backgroundColor = kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
}


- (void)showSquareInfo:(AppHomeChatPlazaVOModel *)mModel{
    
    self.titleLabel.text = mModel.familyName;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:mModel.familyIcon] placeholderImage:[ProjConfig getAppIcon]];
    self.numL.attributedText = [[NSString stringWithFormat:kLocalizationMsg(@"%lld人"),mModel.realTimeNumber] attachmentForImage:[UIImage imageNamed:@"family_user_list"] bounds:CGRectMake(0, -1, 12, 12) before:YES];
    self.contentLabel.text = mModel.familyDescription;
    
    
    NSDictionary *lastInfo = [NSString dictionaryWithJsonString:mModel.lastMsgJson];
    
    ///最后一条消息
//    mModel
    int msgType = [lastInfo[@"msgType"] intValue];
    NSDictionary *infoDict = lastInfo[@"msgContent"];
    
    switch (msgType) {
        case 1: ///礼物
        {
            self.contentLabel.text = kLocalizationMsg(@"[图片]");
            NSString *sendName = infoDict[@"userName"];
            NSString *str = [NSString stringWithFormat:kLocalizationMsg(@"%@送出[%@x%d]"),sendName,infoDict[@"giftName"],[infoDict[@"giftNumber"] intValue]];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attrStr setAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"#6EB3D0", 1.0)} range:NSMakeRange(sendName.length+2, str.length-(sendName.length+2))];
            self.contentLabel.attributedText = attrStr;
        }
            break;
        case 2: ///红包
        {
            self.contentLabel.text = kLocalizationMsg(@"[礼物]");
        }
            break;
        default:
            self.contentLabel.text = @" ";
            break;
    }
    
}


@end
