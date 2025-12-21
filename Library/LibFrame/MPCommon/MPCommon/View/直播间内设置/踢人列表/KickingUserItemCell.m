//
//  KickingUserItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import "KickingUserItemCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>

@implementation KickingUserItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        ///用户头像
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.layer.masksToBounds = YES;
        [bgView addSubview:imgV];
        _userIcon = imgV;
        
        ///
        UIView *centerV = [[UIView alloc] init];
        [bgView addSubview:centerV];
        
        ///用户名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        [centerV addSubview:titleL];
        _titleL = titleL;
        
        ///说明
        UILabel *detailL = [[UILabel alloc] init];
        detailL.font = [UIFont systemFontOfSize:12];
        detailL.textColor = [UIColor darkGrayColor];
        [centerV addSubview:detailL];
        _detailL = detailL;
        
        ///删除
        UIButton *deleteBtn = [UIButton buttonWithType:0];
        [deleteBtn setTitle:kLocalizationMsg(@"恢复") forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [deleteBtn setBackgroundColor:kRGB_COLOR(@"#eeeeee")];
        deleteBtn.layer.masksToBounds = YES;
        [bgView addSubview:deleteBtn];
        _functionBtn = deleteBtn;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
            
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(12);
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.right.equalTo(centerV.mas_left).mas_offset(-12);
        }];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.right.equalTo(deleteBtn.mas_left).mas_offset(-12);
        }];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 28));
            make.centerY.equalTo(bgView);
            make.right.equalTo(bgView).mas_offset(-12);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(centerV);
            make.bottom.equalTo(detailL.mas_top).mas_offset(-5);
        }];
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(centerV);
        }];
        
        [bgView layoutIfNeeded];
        
        [imgV layoutIfNeeded];
        imgV.layer.cornerRadius = imgV.frame.size.height/2.0;
        
        [deleteBtn layoutIfNeeded];
        deleteBtn.layer.cornerRadius = 4.0;
    }
    return _bgView;
    
}


@end
