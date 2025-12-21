//
//  anchorTaskCenterVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "anchorTaskCenterVc.h"
#import "userTaskRewardToastView.h"

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/TaskDtoModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/ApiGradeReWarReModel.h>
#import <LibProjModel/MyAnchorVOModel.h>
#import <LibProjModel/HttpApiGradeController.h>
#import <LibProjView/CustomPopUpAlert.h>
 
 
@interface anchorTaskCenterVc ()

@property (nonatomic, strong)UIScrollView *anchorScroll;
@property (nonatomic, strong)UIImageView *taskListView;
@property (nonatomic, strong)UIImageView *levelImageV;
@property (nonatomic, strong)NSArray *taskListArray;
@property (nonatomic, assign)int completeNum;//完成情况
@property (nonatomic, strong)ApiGradeReWarReModel *rewardModel;

@property (nonatomic, strong)UIView *authroityView;
@property (nonatomic, strong)MyAnchorVOModel *authModel;
@end

@implementation anchorTaskCenterVc
- (UIScrollView *)anchorScroll{
    if (!_anchorScroll) {
        _anchorScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _anchorScroll.showsVerticalScrollIndicator = NO;
        _anchorScroll.backgroundColor = [UIColor whiteColor];
        _anchorScroll.hidden = YES;
    }
    return _anchorScroll;
}
- (NSArray *)taskListArray{
    if (!_taskListArray) {
        _taskListArray = [NSArray array];
    }
    return _taskListArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    {
        //scroll
        [self.view addSubview:self.anchorScroll];
        //auth
        UIView *authShowView = [[UIView alloc]initWithFrame:self.view.bounds];
        authShowView.backgroundColor = [UIColor whiteColor];
        authShowView.hidden = YES;
        [self.view addSubview:authShowView];
        self.authroityView = authShowView;
    }
    
    [self getAnchorInfo];
}
//UI
- (void)updateScrollUI{
    [self.anchorScroll removeAllSubViews];
    
    CGFloat pt = kScreenWidth/375.0;
    
    
    {//等级
        CGFloat scale = 260.0/750.0;
        CGFloat gradeH = kScreenWidth*scale;
        UIImageView *levelImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, gradeH)];
        levelImageV.image = [UIImage imageNamed:@"mine_anchortask_gift_back"];
        levelImageV.userInteractionEnabled = YES;
        self.levelImageV = levelImageV;
        [self.anchorScroll addSubview:levelImageV];
        
        UILabel *giftL = [[UILabel alloc]initWithFrame:CGRectMake(55*pt, 30, kScreenWidth-gradeH+36-20-55*pt, 20)];
        giftL.textAlignment = NSTextAlignmentLeft;
        giftL.font = [UIFont systemFontOfSize:14];
        giftL.textColor = [UIColor whiteColor];
        giftL.text = [NSString stringWithFormat:kLocalizationMsg(@"解锁更高等级，获得更多收益")];
        [levelImageV addSubview:giftL];
        
        UIView *gradBackV = [[UIView alloc]initWithFrame:CGRectMake(55, giftL.maxY+15, 180*pt, 10)];
        gradBackV.backgroundColor = kRGBA_COLOR(@"#FFF1F8", 0.32);
        gradBackV.layer.cornerRadius = 5;
        gradBackV.clipsToBounds = YES;
        [levelImageV addSubview:gradBackV];
        CGFloat currentW = 0;
        if (self.rewardModel.nextLevelTotalEmpirical) {
            currentW = 180*(1-(1.0*self.rewardModel.nextLevelEmpirical/self.rewardModel.nextLevelTotalEmpirical));
        }
        UIView *currentLevelV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, currentW , 10)];
        currentLevelV.backgroundColor = kRGB_COLOR(@"#FCE274");
        currentLevelV.layer.cornerRadius = 5;
        currentLevelV.clipsToBounds = YES;
        [gradBackV addSubview:currentLevelV];
        
        UILabel *levelL = [[UILabel alloc]initWithFrame:CGRectMake(55, gradBackV.maxY, 60, 20)];
        levelL.textColor = [UIColor whiteColor];
        levelL.font = [UIFont systemFontOfSize:10];
        levelL.textAlignment = NSTextAlignmentLeft;
        levelL.text = [NSString stringWithFormat:@"Lv%d",self.rewardModel.currLevel];
        [levelImageV addSubview:levelL];
        
        UILabel *nextLevelL = [[UILabel alloc]initWithFrame:CGRectMake(levelL.maxX+10, gradBackV.maxY, 180*pt-levelL.width-10, 20)];
        nextLevelL.textColor = [UIColor whiteColor];
        nextLevelL.font = [UIFont systemFontOfSize:10];
        nextLevelL.textAlignment = NSTextAlignmentRight;
        
        [levelImageV addSubview:nextLevelL];
        if (self.rewardModel.currLevel == self.rewardModel.nextLevel) {
            nextLevelL.text = @"";
        }else{
            nextLevelL.text = [NSString stringWithFormat:kLocalizationMsg(@"升级LV%d还差%d"),self.rewardModel.nextLevel,self.rewardModel.nextLevelEmpirical];
        }
        UIButton *gradeRewardBtn = [[UIButton alloc]initWithFrame:levelImageV.bounds];
        gradeRewardBtn.backgroundColor = [UIColor clearColor];
        [gradeRewardBtn addTarget:self action:@selector(gradeRewardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [levelImageV addSubview:gradeRewardBtn];
    }
    
    {//任务列表
        CGFloat taskH = 0;
        if (self.taskListArray.count > 0) {
            taskH = 40+self.taskListArray.count *60+30;
        }
        UIImageView *taskListView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.levelImageV.maxY, kScreenWidth, taskH)];
        taskListView.userInteractionEnabled = YES;
        taskListView.contentMode = UIViewContentModeScaleToFill;
        UIImage *bg_image = [UIImage imageNamed:@"mine_task_back_down"];
        CGFloat img_top = bg_image.size.height/2.0-1;
        CGFloat img_bottom = bg_image.size.height/2.0;
        CGFloat img_left = bg_image.size.width/2.0-1;
        CGFloat img_right = bg_image.size.width/2.0;
        UIEdgeInsets insets = UIEdgeInsetsMake(img_top, img_left, img_bottom, img_right);
        bg_image = [bg_image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        taskListView.image = bg_image;
        self.taskListView = taskListView;
        [self.anchorScroll addSubview:taskListView];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(30, 25, 130, 20)];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.text = kLocalizationMsg(@"任务详情");
        [taskListView addSubview:titleL];
        
        UILabel *completeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-130, 0, 100, 20)];
        completeL.centerY = titleL.centerY;
        completeL.textColor = kRGB_COLOR(@"#999999");
        completeL.font = [UIFont systemFontOfSize:13];
        completeL.textAlignment = NSTextAlignmentRight;
        completeL.text = [NSString stringWithFormat:kLocalizationMsg(@"已完成%d/%ld"),self.completeNum,(unsigned long)self.taskListArray.count];
        [taskListView addSubview:completeL];
         
        
        for (int i = 0; i < self.taskListArray.count; i++) {
            TaskDtoModel *model = self.taskListArray[i];
            UIView *taskContentV = [[UIView alloc]initWithFrame:CGRectMake(15, titleL.maxY+10+i*60, kScreenWidth-30, 60)];
            taskContentV.backgroundColor = [UIColor clearColor];
            [taskListView addSubview:taskContentV];
            UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 30, 30)];
            [leftImageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            [taskContentV addSubview:leftImageV];
            
            UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(leftImageV.maxX+30, 10, taskContentV.width-60-90, 20)];
            nameL.textColor = kRGB_COLOR(@"#333333");
            nameL.font = [UIFont systemFontOfSize:15];
            nameL.text = model.name;
            nameL.textAlignment = NSTextAlignmentLeft;
            [taskContentV addSubview:nameL];
            
            UILabel *rewadL = [[UILabel alloc]initWithFrame:CGRectMake(leftImageV.maxX+30, nameL.maxY, taskContentV.width-60-90, 20)];
            rewadL.textColor = kRGB_COLOR(@"#999999");
            rewadL.font = [UIFont systemFontOfSize:12];
            NSString *reward = [NSString stringWithFormat:@"+%d",model.point];
            NSString *rewadStr = [NSString stringWithFormat:kLocalizationMsg(@"经验值 %@"),reward];
            NSMutableAttributedString *rewadAtt = [[NSMutableAttributedString alloc]initWithString:rewadStr];
            [rewadAtt addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#FDAE5E")} range: [rewadStr rangeOfString:reward]];
            rewadL.attributedText = rewadAtt;
            rewadL.textAlignment = NSTextAlignmentLeft;
            [taskContentV addSubview:rewadL];
            
            UIButton *completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(taskContentV.width-85, 0, 70, 32)];
            completeBtn.centerY = leftImageV.centerY;
            completeBtn.layer.cornerRadius = 16;
            completeBtn.clipsToBounds = YES;
            completeBtn.layer.borderWidth = 0.6;
            completeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            if (model.status == 1) {
                [completeBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
                [completeBtn setTitle:kLocalizationMsg(@"已完成") forState:UIControlStateNormal];
                completeBtn.layer.borderColor = kRGB_COLOR(@"#F6F6F6").CGColor;
                [completeBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F6F6F6")] forState:UIControlStateNormal];
            }else{
                [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [completeBtn setTitle:kLocalizationMsg(@"待完成") forState:UIControlStateNormal];
                completeBtn.layer.borderColor = kRGB_COLOR(@"#FDAE5E").CGColor;
                [completeBtn setTitleColor:kRGB_COLOR(@"#FDAE5E") forState:UIControlStateNormal];
            }
            [taskContentV addSubview:completeBtn];
     
        }
    }
    self.anchorScroll.contentSize = CGSizeMake(kScreenWidth, self.taskListView.maxY+20+kSafeAreaBottom+kNavBarHeight);
    
}
- (void)gradeRewardBtnClick:(UIButton *)btn{
    if (self.rewardModel.apiGradeReList.count > 0) {
        [userTaskRewardToastView showTaskRewardToastOn:self.view isAnchor:YES withReward:self.rewardModel callBack:^(BOOL isClose) {
             
        }];
    }
}
#pragma mark - 获取数据
//获取用户的主播认证信息
- (void)getAnchorInfo{
    kWeakSelf(self);
    [self getAnchorAuthority:^(BOOL success) {
        self.authroityView.hidden =  success;
        self.anchorScroll.hidden = !success;
        if (success) {
            [weakself getLevelGiftData];
        }else{
            [weakself updateAuthrotyView];
        }
    }];
}
//获取主播任务列表
- (void)getAnchorTaskList{
    kWeakSelf(self);
    [HttpApiUserController anchorTaskList:^(int code, NSString *strMsg, NSArray<TaskDtoModel *> *arr) {
        if (code == 1) {
            weakself.taskListArray = arr;
            int num = 0;
            for (TaskDtoModel *model in arr) {
                if (model.status) {
                    num ++;
                }
            }
            weakself.completeNum = num;
            [self updateScrollUI];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
//获取礼包
-(void)getLevelGiftData{
    kWeakSelf(self);
    [HttpApiGradeController userLevelInfo:2 callback:^(int code, NSString *strMsg, ApiGradeReWarReModel *model) {
        if (code == 1) {
            weakself.rewardModel = model;
            [weakself getAnchorTaskList];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

#pragma mark - 认证相关

//认证提示
- (void)updateAuthrotyView{
    [self.authroityView removeAllSubViews];
    
    NSString *tipStr;
    NSString *imageStr;
    NSString *sureStr;
    BOOL btnShow = NO;
    switch(self.authModel.anchorAuditStatus) {
        case 0://已经成为主播（通过）
            if (self.authModel.role <= 0) {
                tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
                sureStr = kLocalizationMsg(@"去认证");
                imageStr = @"icon_authority_applay";
                btnShow = YES;
            }
            break;
        case 1://审核中
            tipStr= kLocalizationMsg(@"你的认证正在审核中...");
            imageStr = @"icon_authority_review";
            break;
        case 2://审核失败
            tipStr = kLocalizationMsg(@"审核未通过,快去重新认证吧！");
            sureStr = kLocalizationMsg(@"重新认证");
            imageStr = @"icon_authority_rejected";
            btnShow = YES;
            break;
        case -1://未申请过主播认证
            tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
            sureStr = kLocalizationMsg(@"去认证");
            imageStr = @"icon_authority_applay";
            btnShow = YES;
            break;
        default:
            imageStr = @"icon_authority_applay";
            tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
            break;
    }
    
    UIImageView *authPicV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, (kScreenHeight-150)/2.0-50-kNavBarHeight, 150, 150)];
    authPicV.image = [UIImage imageNamed:imageStr];
    [self.authroityView addSubview:authPicV];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, authPicV.maxY+20, kScreenWidth-30, 40)];
    titleL.textColor = kRGB_COLOR(@"#666666");
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.numberOfLines = 0;
    titleL.text = tipStr;
    [self.authroityView addSubview:titleL];
    
    if (btnShow) {
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, titleL.maxY+20,150, 32)];
        sureBtn.layer.cornerRadius = 16;
        sureBtn.clipsToBounds = YES;
        [sureBtn setTitle:sureStr forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(authSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        sureBtn.backgroundColor = [ProjConfig normalColors];
        [self.authroityView addSubview:sureBtn];
    }
    self.authroityView.hidden = NO;
}
//去认证
- (void)authSureBtnClick:(UIButton *)btn{
    [self authorityGenderJudge:self.authModel];
}

- (void)getAnchorAuthority:(void(^)(BOOL success))callBack{
    kWeakSelf(self);
    [HttpApiUserController getMyAnchor:^(int code, NSString *strMsg, MyAnchorVOModel *model) {
        if (code == 1) {
            [weakself.authroityView removeAllSubViews];
            weakself.authModel = model;
            if (model.anchorAuditStatus == 0 && model.role > 0) {
                callBack(YES);
            }else{
                [self updateAuthrotyView];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
- (void)authorityGenderJudge:(MyAnchorVOModel *)model{
    
    APPConfigModel *config = KLCAppConfig.appConfig;
    if (config.adminLiveConfig.authIsSex == 0 && [KLCUserInfo getGender] != 2) {//只允许女性
        //弹框
        CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"温馨提示") message:kLocalizationMsg(@"暂时只支持小姐姐认证哦~") liveType:LiveTypeForCommon];
        customAlert.clickCancelBlock = ^{
            
        };
        customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
            
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:customAlert animated:YES completion:nil];
        });
    }else{
        [RouteManager routeForName:RN_center_anchorAuthAC currentC:self];
    }
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self getAnchorInfo];
}
- (void)listWillDisappear{
    
}

@end
