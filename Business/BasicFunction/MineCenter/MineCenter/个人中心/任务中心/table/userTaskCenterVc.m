//
//  userTaskCenterVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "userTaskCenterVc.h"
#import "userTaskRewardToastView.h"
#import <LibProjView/SignToastView.h>
#import <LibProjModel/TaskDtoModel.h>
#import <LibProjModel/HttpApiGradeController.h>
#import <LibProjModel/ApiSignInDtoModel.h>
#import <LibProjModel/ApiGradeReWarReModel.h>
 
@interface userTaskCenterVc ()
@property (nonatomic, strong)UIScrollView *userScroll;
@property (nonatomic, strong)UIView *taskListView;

 
@property (nonatomic, strong)ApiSignInDtoModel *signModel;//签到
@property (nonatomic, strong)UIImageView *signImageV;

@property (nonatomic, strong)ApiGradeReWarReModel *userGradeRewadModel;//奖励
@property (nonatomic, strong)UIImageView *gradeRewadImageV;

@property (nonatomic, strong)NSArray *taskListArray;//任务列表
@property (nonatomic, assign)int completeNum;//完成情况
@property (nonatomic, strong)UIImageView *signListV;
@end

@implementation userTaskCenterVc
- (UIScrollView *)userScroll{
    if (!_userScroll) {
        _userScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _userScroll.showsVerticalScrollIndicator = NO;
        _userScroll.backgroundColor = [UIColor whiteColor];
    }
    return _userScroll;
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
    [self.view addSubview:self.userScroll];
 
}
- (void)upadteUI{
    [self.signImageV removeAllSubViews];
    [self.gradeRewadImageV removeAllSubViews];
    [self.signListV removeAllSubViews];
    [self.userScroll removeAllSubViews];
    CGFloat pt = kScreenWidth/375.0;
    
    {//签到
        UIImageView *signImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 145)];
        signImageV.userInteractionEnabled = YES;
        signImageV.contentMode = UIViewContentModeScaleToFill;
        UIImage *bg_image = [UIImage imageNamed:@"mine_task_back_up"];
        CGFloat img_top = 40;
        CGFloat img_bottom = 40;
        CGFloat img_left = 40;
        CGFloat img_right = 40;
        UIEdgeInsets insets = UIEdgeInsetsMake(img_top, img_left, img_bottom, img_right);
        bg_image = [bg_image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        signImageV.image = bg_image;
        self.signImageV = signImageV;
        [self.userScroll addSubview:signImageV];
        
        UILabel *signTitleL = [[UILabel alloc]initWithFrame:CGRectMake(30, 25, 130, 20)];
        signTitleL.textColor = kRGB_COLOR(@"#999999");
        signTitleL.font = [UIFont systemFontOfSize:13];
        signTitleL.textAlignment = NSTextAlignmentLeft;
        NSString *signStr = [NSString stringWithFormat:kLocalizationMsg(@"签到（已签到%d天）"),self.signModel.signDay];
        NSMutableAttributedString *signAtt = [[NSMutableAttributedString alloc]initWithString:signStr];
        [signAtt addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSStrokeColorAttributeName:kRGB_COLOR(@"#333333")} range:NSMakeRange(0, 2)];
        signTitleL.attributedText = signAtt;
        [signImageV addSubview:signTitleL];
        
        UIButton *signBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 0, 60, 30)];
        signBtn.centerY = signTitleL.centerY;
        signBtn.layer.cornerRadius = 15;
        signBtn.clipsToBounds = YES;
        signBtn.selected = self.signModel.isSign;
        [signBtn setTitle:self.signModel.isSign?kLocalizationMsg(@"已签到"):kLocalizationMsg(@"去签到") forState:UIControlStateNormal];
        [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        signBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [signBtn setBackgroundImage:[UIImage createImageSize:signBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.2,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [signBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
        [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [signImageV addSubview:signBtn];
        
        //签到记录
        CGFloat signMragin = (kScreenWidth-50-7*30)/6.0;
        for (int i = 0; i < 7; i++) {
            UIView *ribandV = [[UIView alloc]initWithFrame:CGRectMake(25+15+(30+signMragin)*i, 0, 30+signMragin, 5)];
            if (self.signModel.signDay > 0 && i < self.signModel.signDay-1) {
                ribandV.backgroundColor = [ProjConfig normalColors];
            }else{
                ribandV.backgroundColor = kRGB_COLOR(@"#F6F6F6");
            }
            if (i != 6) {
                [signImageV insertSubview:ribandV atIndex:0];
            }
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(25+(30+signMragin)*i, 65, 30, 30)];
            if (self.signModel.signDay > 0 && i < self.signModel.signDay) {
                imageV.image = [UIImage imageNamed:@"mine_usertask_progress_hightlight"];
            }else{
                imageV.image = [UIImage imageNamed:@"mine_usertask_progress_normal"];
            }
            ribandV.centerY = imageV.centerY;
            [signImageV insertSubview:imageV atIndex:1];
            [signImageV bringSubviewToFront:imageV];
            UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.maxY+5, 30+signMragin, 20)];
            dayL.textAlignment = NSTextAlignmentCenter;
            dayL.centerX = imageV.centerX;
            dayL.textColor = kRGB_COLOR(@"#666666");
            dayL.font = [UIFont systemFontOfSize:12];
            dayL.text = [NSString stringWithFormat:kLocalizationMsg(@"第%d天"),i+1];
            [signImageV insertSubview:dayL atIndex:1];
        }
    }
    
    {//等级礼包
        CGFloat gradeH = kScreenWidth*260/750.0;
        UIImageView *gradeRewadImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.signImageV.maxY, kScreenWidth, gradeH)];
        gradeRewadImageV.userInteractionEnabled = YES;
        gradeRewadImageV.contentMode = UIViewContentModeScaleToFill;
        UIImage *bg_image = [UIImage imageNamed:@"mine_usertask_gift_back"];
        CGFloat img_top = bg_image.size.height/2.0-1;
        CGFloat img_bottom = bg_image.size.height/2.0;
        CGFloat img_left = bg_image.size.width/2.0-1;
        CGFloat img_right = bg_image.size.width/2.0;
        UIEdgeInsets insets = UIEdgeInsetsMake(img_top, img_left, img_bottom, img_right);
        bg_image = [bg_image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        gradeRewadImageV.image = bg_image;
        self.gradeRewadImageV = gradeRewadImageV;
        [self.userScroll addSubview:gradeRewadImageV];
        
        UIImageView *giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-gradeH+36-20, 18, gradeH-36, gradeH-36)];
        giftImageV.contentMode = UIViewContentModeScaleAspectFit;
        giftImageV.userInteractionEnabled = YES;
        giftImageV.image = [UIImage imageNamed:@"mine_usertask_gift"];
        [gradeRewadImageV addSubview:giftImageV];
        
        UILabel *giftL = [[UILabel alloc]initWithFrame:CGRectMake(55*pt, 30, kScreenWidth-gradeH+36-20-55*pt, 20)];
        giftL.textAlignment = NSTextAlignmentLeft;
        giftL.font = [UIFont systemFontOfSize:14];
        giftL.textColor = [UIColor whiteColor];
        
        [gradeRewadImageV addSubview:giftL];
        
        if (self.userGradeRewadModel.nextGiftPackLevel == -1) {
            ///以后没有礼包
            giftL.text = @"";
        }else{
            giftL.text = [NSString stringWithFormat:kLocalizationMsg(@"完成任务获得LV%d级大礼包"),self.userGradeRewadModel.nextGiftPackLevel];
        }
        
        
        UIView *gradBackV = [[UIView alloc]initWithFrame:CGRectMake(55, giftL.maxY+15, 180*pt, 10)];
        gradBackV.backgroundColor = kRGBA_COLOR(@"#FFF1F8", 0.32);
        gradBackV.layer.cornerRadius = 5;
        gradBackV.clipsToBounds = YES;
        [gradeRewadImageV addSubview:gradBackV];
        CGFloat currentW = 0;
        if (self.userGradeRewadModel.nextLevelTotalEmpirical) {
            currentW = 180*(1-(1.0*self.userGradeRewadModel.nextLevelEmpirical/self.userGradeRewadModel.nextLevelTotalEmpirical));
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
        levelL.text = [NSString stringWithFormat:@"Lv%d",self.userGradeRewadModel.currLevel];
        [gradeRewadImageV addSubview:levelL];
        
        UILabel *nextLevelL = [[UILabel alloc]initWithFrame:CGRectMake(levelL.maxX+10, gradBackV.maxY, 180*pt-levelL.width-10, 20)];
        nextLevelL.textColor = [UIColor whiteColor];
        nextLevelL.font = [UIFont systemFontOfSize:10];
        nextLevelL.textAlignment = NSTextAlignmentRight;
        [gradeRewadImageV addSubview:nextLevelL];
        
        if (self.userGradeRewadModel.nextLevel == self.userGradeRewadModel.currLevel) {
            nextLevelL.text = @"";
        }else{
            nextLevelL.text = [NSString stringWithFormat:kLocalizationMsg(@"升级LV%d还差%d"),self.userGradeRewadModel.nextLevel,self.userGradeRewadModel.nextLevelEmpirical];
        }
        
        UIButton *gradeRewardBtn = [[UIButton alloc]initWithFrame:gradeRewadImageV.bounds];
        gradeRewardBtn.backgroundColor = [UIColor clearColor];
        [gradeRewardBtn addTarget:self action:@selector(gradeRewardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [gradeRewadImageV addSubview:gradeRewardBtn];
    }
    
    
    {//任务列表
        CGFloat taskH = 0;
        if (self.taskListArray.count > 0) {
            taskH = 40+self.taskListArray.count *60+30;
        }
        UIImageView *taskListView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.gradeRewadImageV.maxY, kScreenWidth, taskH)];
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
        [self.userScroll addSubview:taskListView];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(30, 25, 130, 20)];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.text = kLocalizationMsg(@"每日任务");
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
            [rewadAtt addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range: [rewadStr rangeOfString:reward]];
            rewadL.attributedText = rewadAtt;
            rewadL.textAlignment = NSTextAlignmentLeft;
            [taskContentV addSubview:rewadL];
            
            UIButton *completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(taskContentV.width-85, 0, 70, 32)];
            completeBtn.centerY = leftImageV.centerY;
            completeBtn.layer.cornerRadius = 16;
            completeBtn.clipsToBounds = YES;
            completeBtn.layer.borderWidth = 0.6;
            completeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            if (model.status) {
                [completeBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
                [completeBtn setTitle:kLocalizationMsg(@"已完成") forState:UIControlStateNormal];
                completeBtn.layer.borderColor = kRGB_COLOR(@"#F6F6F6").CGColor;
                [completeBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F6F6F6")] forState:UIControlStateNormal];
            }else{
                [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [completeBtn setTitle:kLocalizationMsg(@"待完成") forState:UIControlStateNormal];
                completeBtn.layer.borderColor = [ProjConfig normalColors].CGColor;
                [completeBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
            }
            [taskContentV addSubview:completeBtn];
     
        }
    }
 
    self.userScroll.contentSize = CGSizeMake(kScreenWidth, self.taskListView.maxY+20+kSafeAreaBottom+kNavBarHeight);
}
#pragma mark - 按钮 通知
- (void)gradeRewardBtnClick:(UIButton *)btn{
    if (self.userGradeRewadModel.apiGradeReList.count > 0) {
        [userTaskRewardToastView showTaskRewardToastOn:self.view isAnchor:NO withReward:self.userGradeRewadModel callBack:^(BOOL isClose) {
             
        }];
    }
}
- (void)signBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (!self.signModel.isSign) {
        [SignToastView showSignViewWithComplition:^(BOOL isSignIn) {
            if (isSignIn) {
                [weakself getSignInfo];
            }
        }];
    }
}

#pragma mark - 获取数据
//获取个人签到信息
- (void)getSignInfo{
    kWeakSelf(self);
   [HttpApiUserController getSignInfo:^(int code, NSString *strMsg, ApiSignInDtoModel *model) {
       if (code == 1) {
           weakself.signModel = model;
           [weakself getUserLevelReward];
       }else{
           [SVProgressHUD showInfoWithStatus:strMsg];
       }
   }];
}
//获取用户等级信息
- (void)getUserLevelReward{
    kWeakSelf(self);
    [HttpApiGradeController userLevelInfo:1 callback:^(int code, NSString *strMsg, ApiGradeReWarReModel *model) {
        if (code == 1) {
            weakself.userGradeRewadModel = model;
            [weakself getTaskList];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
//获取任务列表
-(void)getTaskList{
    kWeakSelf(self);
    [HttpApiUserController userTaskList:^(int code, NSString *strMsg, NSArray<TaskDtoModel *> *arr) {
        if (code == 1) {
            int num = 0;
            weakself.taskListArray = arr;
            for (TaskDtoModel *model in arr) {
                if (model.status) {
                    num ++;
                }
            }
            weakself.completeNum = num;
            [weakself upadteUI];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
- (void)listWillAppear{
    [self getSignInfo];
}
- (void)listWillDisappear{
    
}
@end
