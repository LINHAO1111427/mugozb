//
//  SystemNotiContentCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNotiContentCell.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppSystemNoticeUserModel.h>
#import <Masonry.h>

@interface SystemNotiContentCell ()
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *desLabel;
@property(nonatomic,strong)UIView *bgView;
@end
@implementation SystemNotiContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ProjConfig projBgColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    return self;
}

-(void)creatSubView{
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = kRGB_COLOR(@"#999999");
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).inset(10);
        make.height.mas_equalTo(40);
    }];
    
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth - 30, 85)];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(15);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.bottom.equalTo(self.contentView).inset(10);
    }];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, self.bgView.width - 28, 20)];
    self.titleLabel.textColor = kRGB_COLOR(@"#333333");
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.bgView).inset(14);
        make.height.mas_equalTo(20);
    }];
    
    self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 40, self.bgView.width - 28, 20)];
    self.desLabel.textColor = kRGB_COLOR(@"#666666");
    self.desLabel.numberOfLines = 0;
    self.desLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView).inset(14);
        make.top.equalTo(self.titleLabel.mas_bottom).inset(10);
        make.bottom.equalTo(self.bgView).inset(20);
    }];
}


-(void)setModel:(AppSystemNoticeUserModel *)model{
    _model  = model;
    
    self.timeLabel.text = [model.addtime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm"];
    self.titleLabel.text = model.title;
    self.desLabel.text = model.content;
    CGFloat desLabelH = [self.desLabel.text heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:self.bgView.width - 28];
    self.desLabel.frame = CGRectMake(14, 50, self.bgView.width - 28, desLabelH);
    self.bgView.frame = CGRectMake(15, 40, kScreenWidth - 30,  desLabelH + 50 + 25 + 5);
    
    self.desLabel.attributedText = [model.content lineSpace:3];
    

}


+(CGFloat)getSystemNotiContentCellHeight:(AppSystemNoticeUserModel *)model{
     CGFloat desLabelH = [model.content heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:kScreenWidth - 30 - 28];
    return desLabelH + 50 + 25 +40 + 10 + 5;
}
@end
