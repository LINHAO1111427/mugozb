//
//  MessageChatFuncCell.m
//  Message
//
//  Created by klc_sl on 2021/8/7.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageChatFuncCell.h"
#import <LibTools/LibTools.h>

@implementation MessageChatFuncCell

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
    }
    return self;
}


-(void)creatSubView{
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 44, 44)];
    [self.contentView addSubview:headImgView];
    self.headImgView = headImgView;
    
    
    UILabel *tittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, 12, 120, 22)];
    tittleLabel.font = [UIFont systemFontOfSize:15];
    tittleLabel.textColor = kRGB_COLOR(@"#333333");
    tittleLabel.text = @"";
    [self.contentView addSubview:tittleLabel];
    self.titleLabel = tittleLabel;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, CGRectGetMaxY(tittleLabel.frame) + 1, kScreenWidth - 42 - CGRectGetMaxX(self.headImgView.frame) - 12, 22)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = kRGB_COLOR(@"#888888");
    contentLabel.text = @"";
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *moreImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - 11, (70-16.5)/2.0, 11, 16.5)];
    moreImgView.contentMode =UIViewContentModeScaleAspectFit;
    moreImgView.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    [self.contentView addSubview:moreImgView];

    
    UIView *linkView = [[UIView alloc] init];
    linkView.backgroundColor = kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
}


///1家族。2广场
- (void)showFuncType:(int)funcType userNumber:(int)userNumber{
    
    if (funcType == 2) {
        self.headImgView.image = [UIImage imageNamed:@"message_chat_square"];
        self.titleLabel.text = kLocalizationMsg(@"聊天广场");
        if (userNumber > 0) {
            self.contentLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"已有%d人在这里嗨"),userNumber];
        }else{
            self.contentLabel.text = kLocalizationMsg(@"已有人在这里嗨");
        }
        
    }
    
    if (funcType == 1) {
        self.headImgView.image = [UIImage imageNamed:@"mine_icon_family"];
        self.titleLabel.text = kLocalizationMsg(@"家族");
        self.contentLabel.text = kLocalizationMsg(@"有家族不孤单，我们是相信相爱的一家人");
    }
}

@end
