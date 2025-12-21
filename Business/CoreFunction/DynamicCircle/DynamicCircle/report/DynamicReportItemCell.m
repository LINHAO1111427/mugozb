//
//  DynamicReportItemCell.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "DynamicReportItemCell.h"
#import <LibTools/LibTools.h>

NSString *const DynamicReportItemCellIdentifier = @"ReportItemCellIdentifier";
@implementation DynamicReportItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createTableViewCellSubview];
    }
    return self;
}
-(void)createTableViewCellSubview{
    
    if (_leftLabel == nil) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, kScreenWidth-80, 20)];
        leftLabel.textColor =kRGB_COLOR(@"#333333");
        leftLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self.contentView addSubview:leftLabel];
        _leftLabel = leftLabel;
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 15, 15)];
        rightImage.centerY = leftLabel.centerY;
        rightImage.layer.masksToBounds = YES;
        rightImage.layer.cornerRadius = 2;
        rightImage.layer.borderWidth = 0.8;
        rightImage.contentMode = UIViewContentModeScaleAspectFit;
        rightImage.layer.borderColor = kRGBA_COLOR(@"#CCCCCC", 1.0).CGColor;
        [self.contentView addSubview:rightImage];
        _rightImage = rightImage;
    }
}

- (void)setSelectItem:(BOOL)selectItem{
    if (selectItem) {
        _rightImage.image = [UIImage imageNamed:@"report_user_select"];
        _rightImage.backgroundColor = [ProjConfig normalColors];
    }else{
        _rightImage.image = nil;
        _rightImage.backgroundColor = [UIColor clearColor];
    }
}

@end
