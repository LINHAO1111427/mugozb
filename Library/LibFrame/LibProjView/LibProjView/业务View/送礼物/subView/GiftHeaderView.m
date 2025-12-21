//
//  GiftHeaderView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "GiftHeaderView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import "GiftUserModel.h"
#import <SDWebImage/SDWebImage.h>

@interface GiftHeaderView ()

@property (nonatomic, weak)UIScrollView *contentBgScrollV;

@end

@implementation GiftHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

///获取所有选择的用户信息
- (NSArray *)getSelectUsers{
    NSMutableArray *selectUses = [[NSMutableArray alloc] init];
    for (UIView *subV in _contentBgScrollV.subviews) {
        if([subV isKindOfClass:[UIButton class]]){
            UIButton *userBtn = (UIButton *)subV;
            if (userBtn.selected) {
                NSInteger index = (subV.tag - 978601);
                [selectUses addObject:_userItems[index]];
            }
        }
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(giftHeader:selectUsers:)]) {
        [self.delegate giftHeader:self selectUsers:selectUses];
    }
    return selectUses;
}

///创建UI
- (void)createUI{
    UIScrollView *bgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 10, self.width-30-50, self.height-10)];
    bgScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:bgScrollV];
    _contentBgScrollV = bgScrollV;
}


- (void)setUserItems:(NSArray<GiftUserModel *> *)userItems{
    _userItems = userItems;
    
    ///大于一个人过滤自己
    if (userItems.count > 1) {
        NSMutableArray *userMuItem = [[NSMutableArray alloc] init];
        for (GiftUserModel *userModel in userItems) {
            if (userModel.userId != [ProjConfig userId]) {
                if (userModel.isAnchor && userMuItem.count > 0) {
                    [userMuItem insertObject:userModel atIndex:0];
                }else{
                    [userMuItem addObject:userModel];
                }
            }
        }
        _userItems = userMuItem;
    }
    _contentBgScrollV.contentSize = CGSizeMake(_userItems.count*50-15, 0);
    for (int i = 0; i<_userItems.count; i++) {
        GiftUserModel *userModel = _userItems[i];
        ///关闭按钮
        UIButton *userItemBtn = [UIButton buttonWithType:0];
        userItemBtn.tag = 978601+i;
        userItemBtn.frame = CGRectMake(i*50, 0, 35, _contentBgScrollV.height);
        [userItemBtn addTarget:self action:@selector(userItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentBgScrollV addSubview:userItemBtn];
        ///头像
        UIImageView *userIcon =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, userItemBtn.width, userItemBtn.width)];
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.cornerRadius = userItemBtn.width/2.0;
        userIcon.layer.borderWidth = 1.0;
        userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        userIcon.tag = userItemBtn.tag+100;
        if (userModel.userImage) {
            userIcon.image = userModel.userImage;
        }else{
            [userIcon sd_setImageWithURL:[NSURL URLWithString:userModel.userIcon] placeholderImage:[ProjConfig getDefaultImage]];
        }
        [userItemBtn addSubview:userIcon];
        ///提示文字
        UILabel *userNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, userItemBtn.height-13, userItemBtn.width, 13)];
        userNameL.text = userModel.showStr?userModel.showStr:userModel.userName;
        userNameL.font = [UIFont systemFontOfSize:8];
        userNameL.textColor = [UIColor whiteColor];
        userNameL.tag = userItemBtn.tag+200;
        userNameL.textAlignment = NSTextAlignmentCenter;
        userNameL.layer.masksToBounds = YES;
        userNameL.layer.cornerRadius = 6.5;
        userNameL.lineBreakMode = NSLineBreakByClipping;
        userNameL.textColor = [UIColor blackColor];
        userNameL.backgroundColor =  [UIColor whiteColor];
        [userItemBtn addSubview:userNameL];
        if (i == 0) {
            [self selectOneUser:userItemBtn];
        }
    }
    
    if (_userItems.count > 1) {
        UIButton *allBtn = [UIButton buttonWithType:0];
        allBtn.frame = CGRectMake(_contentBgScrollV.maxX+15, 0, 33, 20);
        allBtn.centerY = _contentBgScrollV.centerY;
        allBtn.layer.masksToBounds = YES;
        allBtn.layer.cornerRadius = 10;
        allBtn.layer.borderWidth = 1.0;
        allBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [allBtn setTitle:kLocalizationMsg(@"全部") forState:UIControlStateNormal];
        [allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
        allBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:allBtn];
    }
    
}


- (void)allBtnClick{
    for (UIView *subV in _contentBgScrollV.subviews) {
        if([subV isKindOfClass:[UIButton class]]){
            UIButton *clickBtn = (UIButton *)subV;
            clickBtn.selected = NO;
            [self userItemClick:clickBtn];
        }
    }
    [self getSelectUsers];
}


///点击某一个用户的头像
- (void)userItemClick:(UIButton *)btn{
    if (self.userItems.count > 1) {
        [self selectOneUser:btn];
    }
}


- (void)selectOneUser:(UIButton *)btn{
    btn.selected = !btn.selected;
    for (UIView *subV in btn.subviews) {
        if (subV.tag == (btn.tag + 100) && [subV isKindOfClass:[UIImageView class]]) { ///头像
            UIImageView *imgV = (UIImageView *)subV;
            imgV.layer.borderColor = btn.selected?[ProjConfig normalColors].CGColor:[UIColor whiteColor].CGColor;
        }
        if (subV.tag == (btn.tag + 200) && [subV isKindOfClass:[UILabel class]]) { ///文字
            UILabel *lab = (UILabel *)subV;
            lab.textColor = btn.selected?[UIColor whiteColor]:[UIColor blackColor];
            lab.backgroundColor = btn.selected?[ProjConfig normalColors]:[UIColor whiteColor];
        }
    }
    [self getSelectUsers];
}


@end
