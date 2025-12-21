//
//  PrivilegeSettingTableViewCell.m
//  MineCenter
//
//  Created by ssssssss on 2020/8/26.
//

#import "PrivilegeSettingTableViewCell.h"
@implementation PrivilegeSettingModel

@end

@implementation PrivilegeSettingSectionModel

@end

@interface PrivilegeSettingTableViewCell()
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UISwitch *switchBar;
@property (nonatomic, strong)UIView *line;

@end
@implementation PrivilegeSettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self viewCreate];
    }
    return self;
}

- (void)viewCreate{
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, kScreenWidth-24-70, 20)];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = kRGB_COLOR(@"#444444");
    titleL.textAlignment = NSTextAlignmentLeft;
    self.titleL = titleL;
    [self.contentView addSubview:self.titleL];
    
    UISwitch *switchBar = [[UISwitch alloc]initWithFrame:CGRectMake(titleL.maxX+10, 12, 60, 26)];
    [switchBar setOnTintColor:[ProjConfig normalColors]];
    switchBar.centerY = titleL.centerY;
    
    [switchBar addTarget:self action:@selector(switchBarChange:) forControlEvents:UIControlEventValueChanged];
    
    self.switchBar = switchBar;
    [self.contentView addSubview:self.switchBar];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 49, kScreenWidth-24, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    self.line = line;
    [self.contentView addSubview:self.line];
    
}
- (void)setModel:(PrivilegeSettingModel *)model{
    _model = model;
    self.switchBar.on = model.openStatus;
    self.titleL.text = model.title;
    self.line.hidden = self.lastOne;
}


- (void)switchBarChange:(UISwitch *)switchBar{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PrivilegeSettingTableViewCell:swithBarValueChange:)]) {
        [self.delegate PrivilegeSettingTableViewCell:self swithBarValueChange:switchBar.on];
    }
    
}
 
@end
