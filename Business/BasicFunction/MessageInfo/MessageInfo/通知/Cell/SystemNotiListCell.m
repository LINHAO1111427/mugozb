//
//  SystemNotiListCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNotiListCell.h"

#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppHomeSystemNoticeVOModel.h>

@interface SystemNotiListCell ()
@property (nonatomic,strong)UIImageView *headImgView;
@property (nonatomic,strong)UILabel *tittleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *imsgTimeLabel;
@property (nonatomic,strong)UILabel *unreadNumLabel;
@end
@implementation SystemNotiListCell

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
        self.backgroundColor = [ProjConfig projBgColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        longPressGesture.minimumPressDuration = 0.5f;
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

-(void)creatSubView{
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 44, 44)];
    self.headImgView.layer.cornerRadius = 22;
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImgView.clipsToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    
    self.tittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, 12, 120, 22)];
    self.tittleLabel.font = [UIFont systemFontOfSize:15];
    self.tittleLabel.textColor = kRGB_COLOR(@"#333333");
    self.tittleLabel.text = @"";
    [self.contentView addSubview:self.tittleLabel];
    
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, CGRectGetMaxY(self.tittleLabel.frame) + 1, kScreenWidth - 42 - CGRectGetMaxX(self.headImgView.frame) - 12, 22)];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = kRGB_COLOR(@"#888888");
    self.contentLabel.text = @"";
    [self.contentView addSubview:self.contentLabel];
    
    
    self.imsgTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - 100, CGRectGetMinY(self.tittleLabel.frame), 80, 22)];
    self.imsgTimeLabel.font = [UIFont systemFontOfSize:12];
    self.imsgTimeLabel.textAlignment = NSTextAlignmentRight;
    self.imsgTimeLabel.textColor = kRGB_COLOR(@"#CCCCCC");
    self.imsgTimeLabel.text = @"";
    [self.contentView addSubview:self.imsgTimeLabel];
    
    
    self.unreadNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 12 - 18, CGRectGetMaxY(self.tittleLabel.frame)+2, 18, 18)];
    self.unreadNumLabel.layer.cornerRadius = 9;
    self.unreadNumLabel.layer.masksToBounds = YES;
    self.unreadNumLabel.backgroundColor = [UIColor redColor];
    self.unreadNumLabel.textAlignment = NSTextAlignmentCenter;
    self.unreadNumLabel.font = [UIFont systemFontOfSize:12];
    self.unreadNumLabel.textColor = [UIColor whiteColor];
    self.unreadNumLabel.text = @"0";
    [self.contentView addSubview:self.unreadNumLabel];
    
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 70 - 0.3, kScreenWidth, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:linkView];
    
    
}


-(void)setModel:(AppHomeSystemNoticeVOModel *)model{
    _model = model;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[ProjConfig getDefaultImage]];
    
    self.tittleLabel.text = model.showTitle;
    
    //未读
    if (model.noReadNumber != 0) {
        self.unreadNumLabel.hidden = NO;
        self.unreadNumLabel.text = [NSString stringWithFormat:@"%d",model.noReadNumber];
    }else if (model.noReadNumber > 99){
        self.unreadNumLabel.hidden = NO;
        self.unreadNumLabel.text = @"99⁺";
    }else{
        self.unreadNumLabel.hidden = YES;
    }
    
    self.contentLabel.text = model.firstMsg;
    
    self.imsgTimeLabel.text = model.addtimeStr;
    
    CGFloat timeW = [self.imsgTimeLabel.text widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22];
    self.imsgTimeLabel.frame =  CGRectMake(kScreenWidth - 12 - timeW, CGRectGetMinY(self.tittleLabel.frame), timeW, 22);
    self.tittleLabel.frame = CGRectMake(CGRectGetMaxX(self.headImgView.frame)+12, 11, kScreenWidth - timeW - 12 - CGRectGetMaxX(self.headImgView.frame) - 12, 22);
    
}


-(void)cellLongPress:(UILongPressGestureRecognizer *)longRecognizer{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        if (self.cellLongTapBlock) {
            self.cellLongTapBlock(self.model.noticeId);
        }
    }
    
}


@end
