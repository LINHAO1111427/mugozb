//
//  ChatSetUpCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatSetUpCell.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface ChatSetUpCell ()

@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UISwitch *mySwitch;
@property (nonatomic,strong)UIImageView *arrowImageV;

@end

@implementation ChatSetUpCell

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
        }
    return self;
}

-(void)creatSubView{
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 100, 50)];
    self.nameLable.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLable];
    
    self.mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 10, 100, 40)];
    [self.mySwitch setOnTintColor:[ProjConfig normalColors]];
    self.mySwitch.hidden = YES;
    [self.contentView addSubview:self.mySwitch];
    [self.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 - 0.3, kScreenWidth, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:linkView];

    self.arrowImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth- 15-8, 17.5, 8, 15)];
    self.arrowImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    self.arrowImageV.hidden = YES;
    [self.contentView addSubview:self.arrowImageV];
}


-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if ([self.delegate respondsToSelector:@selector(clickPullBlack:andType:)]) {
        [self.delegate clickPullBlack:isButtonOn andType:self.infoModel.typeId];
    }
}

- (void)setInfoModel:(ChatSetInfoModel *)infoModel{
    _infoModel = infoModel;
    self.nameLable.text = infoModel.title;
    self.mySwitch.on = infoModel.isBlack;
    
    self.mySwitch.hidden = !infoModel.showType;
    self.arrowImageV.hidden = infoModel.showType;
}

@end
