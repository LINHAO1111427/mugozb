//
//  SearchAnchorItemCell.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "SearchAnchorItemCell.h"
#import <LibProjModel/LiveBeanModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>

NSString *const SearchAnchorItemCellIdentifier = @"SearchAnchorItemCellIdentifier";

@implementation SearchAnchorItemCell
- (void)layoutSubviews{
    [super layoutSubviews];
    UIImage *sexImage = [[ProjConfig shareInstence].baseConfig imageGender:self.model.sex age:self.model.age role:0];
    if (sexImage) {
        self.sexL.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
        };
    }
}

-(void)setModel:(LiveBeanModel *)model{
    _model = model;
    
    _nameL.text = _model.nickname;
    _signatureL.text = _model.signature;
    
    
    //头像
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    
    _liveImgV.hidden = (model.roomId > 0?NO:YES);
    
    //性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.sex age:model.age role:0];
    if (image) {
        self.sexLwidthConstraint.constant = 28;
        self.sexL.image = image;
    }else{
        self.sexLwidthConstraint.constant = 0;
    }
    
    
    [self.levelBgV removeAllSubViews];
    CGFloat maxX = 0;
    //级别
    if ([[ProjConfig shareInstence].baseConfig showUserLevelImage]) {
        NSString *levelImg = @"";
        if (model.anchorLevel.length > 0) {
            levelImg = model.anchorLevel;
        }else{
            levelImg = model.userLevel;
        }
        if (levelImg.length > 0) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(maxX, 0, 28, 14)];
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            [imgV sd_setImageWithURL:[NSURL URLWithString:levelImg]];
            [self.levelBgV addSubview:imgV];
            maxX = imgV.maxX+4;
        }
    }
    ///财富等级
    if ([[ProjConfig shareInstence].baseConfig showWeathLevelImage]) {
        
    }
    
}


- (IBAction)clickFollowBtn:(id)sender {
    self.followBtnBlock?self.followBtnBlock(self):nil;
}



@end
