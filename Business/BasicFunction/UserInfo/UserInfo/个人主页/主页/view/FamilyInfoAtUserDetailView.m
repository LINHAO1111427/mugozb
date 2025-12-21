//
//  FamilyInfoAtUserDetailView.m
//  UserInfo
//
//  Created by klc_sl on 2021/8/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "FamilyInfoAtUserDetailView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/HttpApiChatFamilyController.h>

@implementation FamilyInfoAtUserDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)create:(NSArray<AppMyChatFamilyBasisInfoVOModel *> *)list{
    
    [self removeAllSubViews];
    
    CGFloat skillBgViewHeight = 0;
    
    if (list.count > 0) {
        
        UIView *contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        [self addSubview:contentBgView];
        self.contentBgView = contentBgView;
        
        for (AppMyChatFamilyBasisInfoVOModel *voModel in list) {
            
            UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, skillBgViewHeight, self.width, 50)];
            [contentBgView addSubview:bgV];
            
            UIButton *btn = [UIButton buttonWithType:0];
            [btn addTarget:self action:@selector(familyInfoClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgV addSubview:btn];
            btn.tag = voModel.familyId;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(bgV);
            }];
            
            UIImageView *familyIconV = [[UIImageView alloc] initWithFrame:CGRectMake(20, (bgV.height-40)/2.0, 40, 40)];
            familyIconV.layer.masksToBounds = YES;
            familyIconV.layer.cornerRadius = 4.0;
            familyIconV.contentMode = UIViewContentModeScaleAspectFill;
            [familyIconV sd_setImageWithURL:[NSURL URLWithString:voModel.familyIcon] placeholderImage:[ProjConfig getAppIcon]];
            [bgV addSubview:familyIconV];
            self.familyIconV = familyIconV;
            
            UILabel *familyNameL = [[UILabel alloc]init];
            familyNameL.textColor = kRGB_COLOR(@"#999999");
            familyNameL.font = [UIFont systemFontOfSize:14];
            familyNameL.text = voModel.familyName;
            [bgV addSubview:familyNameL];
            self.familyNameL = familyNameL;
            [familyNameL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(familyIconV.mas_right).offset(15);
                make.centerY.equalTo(familyIconV);
            }];
            
            UIImageView *familyLevelV = [[UIImageView alloc] init];
            familyLevelV.centerY = familyIconV.centerY;
            [familyLevelV sd_setImageWithURL:[NSURL URLWithString:voModel.familyGradeIcon]];
            familyLevelV.contentMode = UIViewContentModeScaleAspectFit;
            [bgV addSubview:familyLevelV];
            self.familyLevelV = familyLevelV;
            [familyLevelV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(familyNameL);
                make.left.equalTo(familyNameL.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
            
            UIImageView *moreImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-7-20, 0, 7, 13)];
            moreImgV.contentMode = UIViewContentModeScaleAspectFill;
            moreImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
            [bgV addSubview:moreImgV];
            [moreImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-20);
                make.centerY.equalTo(familyIconV);
                make.size.mas_equalTo(CGSizeMake(7, 13));
            }];
            
            skillBgViewHeight = bgV.maxY;
        }
        
        self.contentBgView.height = skillBgViewHeight;
    }
    
    self.height = skillBgViewHeight;
    
    if (self.viewHeightBlock) {
        self.viewHeightBlock(list.count>0?YES:NO);
    }
    
}

- (void)changeViewLayout:(CGFloat)headerH{
    self.height += headerH;
    self.contentBgView.y = headerH;
}

///获取家族基本信息
- (void)reloadShowData:(int64_t)userId{
    kWeakSelf(self);
    if ([[ProjConfig shareInstence].baseConfig hasFamilyGroup]) {
        [HttpApiChatFamilyController getAppMyChatFamilyBasisInfoVO:-1 userId:userId callback:^(int code, NSString *strMsg, NSArray<AppMyChatFamilyBasisInfoVOModel *> *arr) {
            if (code == 1) {
                [weakself create:arr];
            }else{
                [weakself create:@[]];
            }
        }];
    }
}

///家族信息
- (void)familyInfoClick:(UIButton *)btn{
    if (btn.tag > 0) {
        [RouteManager routeForName:RN_Family_FamilyInfoVC currentC:[ProjConfig currentVC] parameters:@{@"familyId":@(btn.tag)}];
    }
}

@end
