//
//  UserListItemCell.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "UserListItemCell.h"
#import <LibProjModel/ApiUserBlackInfoVOModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>

NSString *const UserListItemCellIdentifier = @"UserListItemCellIdentifier";

@implementation UserListItemCell

- (void)layoutSubviews{
    [super layoutSubviews];
    UIImage *sexImage = [[ProjConfig shareInstence].baseConfig imageGender:self.model.userSex age:self.model.userAge role:self.model.userRole];
    if (sexImage) {
        self.sexL.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:self.model.userRole];
        };
    }
}
-(void)setModel:(ApiUserBlackInfoVOModel *)model{

    _model = model;
    
    _nameL.text = _model.userName;
    
    _signatureL.text = _model.signature;
    //级别
    [self.levelL sd_setImageWithURL:[NSURL URLWithString:model.userRole?model.anchorGradeImg:model.userGradeImg]];
    
    [self.hostlevel sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
    //头像
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    
    
    //性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.userSex age:model.userAge role:model.userRole];
    if (image) {
        self.sexL.image = image;
        self.sexLwidthConstraint.constant = 28;
    }else{
        self.sexLwidthConstraint.constant = 0;
    }
    self.cancelBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
}


- (IBAction)cancelBtnClick:(UIButton *)sender {
    self.clickCancelBtn?self.clickCancelBtn(self):nil;
}

@end
