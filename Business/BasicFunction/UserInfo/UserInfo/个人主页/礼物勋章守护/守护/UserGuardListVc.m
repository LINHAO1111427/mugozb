//
//  UserGuardListVc.m
//  UserInfo
//
//  Created by ssssssss on 2020/1/4.
//

#import "UserGuardListVc.h"
#import "UserGuardDetailListVc.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/guardPrivilegeView.h>
#import <LibProjModel/GuardUserVOModel.h>
#import <LibProjModel/HttpApiGuard.h>

@interface UserGuardListVc ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView *guardListbackView;
@property (nonatomic, strong)guardPrivilegeView *privilegeView;
 
@property (nonatomic, strong)UIView *botomView;
 
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong)GuardUserVOModel *guardInfoModel;
@end

@implementation UserGuardListVc
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addGuardPrivilegeView];//守护特权
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"Ta的守护");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}
 
//守护滚动列表
- (void)updateUserGuardListView{
     
    [self.scrollView removeAllSubViews];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self.guardListbackView removeAllSubViews];
    [self.guardListbackView removeFromSuperview];
    self.guardListbackView = nil;
     
    CGFloat scale = 500/750.0;
    CGFloat viewHeight = kScreenWidth*scale;
    CGFloat pt = kScreenWidth/375.0;
    
    UIImageView *guardListbackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    guardListbackView.userInteractionEnabled = YES;
    guardListbackView.image = [UIImage imageNamed:@"icon_userinfo_guard_list_back"];
    self.guardListbackView = guardListbackView;
    [self.view insertSubview:guardListbackView atIndex:0];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
    titleL.text = kLocalizationMsg(@"Ta的守护");
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentLeft;
    [guardListbackView addSubview:titleL];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-20, 0, 16, 16)];
    imageV.centerY = titleL.centerY;
    imageV.image = [UIImage imageNamed:@"icon_white_more"];
    [guardListbackView addSubview:imageV];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    moreBtn.backgroundColor = [UIColor clearColor];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [guardListbackView addSubview:moreBtn];
    
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 40, kScreenWidth-10, viewHeight-40)];
    scrollV.backgroundColor = [UIColor clearColor];
    scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollV;
    [guardListbackView addSubview:scrollV];
    
    CGFloat itemH = viewHeight-40;
    CGFloat itemW = 300*itemH/340.0;
    NSInteger num = self.dataArr.count;
    CGFloat margin = (itemH-20-60-50*pt)/2.0;
    if (num > 0) {
        for (int i = 0; i < num; i++) {
            GuardUserVOModel *model = self.dataArr[i];
            UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-2*itemW+20)/2.0+i*itemW, 10, itemW-20, itemH-20)];
            contentV.backgroundColor = kRGB_COLOR(@"#FFF4F4");
            contentV.clipsToBounds = YES;
            contentV.layer.cornerRadius = 12;
            [scrollV addSubview:contentV];
            
            // 三角
            UIImageView *triangleView = [[UIImageView alloc]initWithFrame:CGRectMake((itemW-20)/2.0, 0, (itemW-20)/2.0, 0.5*(itemW-20)*110/150.0)];
            triangleView.image = [UIImage imageNamed:@"icon_guard_triang"];
            [contentV addSubview:triangleView];
            
            UILabel *rightUpL = [[UILabel alloc]initWithFrame:CGRectMake((itemW-20)/2.0-3, 5, (itemW-20)/2.0, 20)];
            rightUpL.textAlignment = NSTextAlignmentRight;
            rightUpL.font = [UIFont systemFontOfSize:10];
            rightUpL.textColor = [UIColor whiteColor];
            rightUpL.text = kLocalizationMsg(@"守护Ta ");
            [contentV addSubview:rightUpL];
            
            UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, margin, 50*pt, 50*pt)];
            rightImageV.centerX = (itemW-20)/2.0+15;
            rightImageV.layer.cornerRadius = 25*pt;
            rightImageV.clipsToBounds = YES;
            rightImageV.layer.borderWidth = 1.0;
            rightImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            [rightImageV sd_setImageWithURL:[NSURL URLWithString:model.anchorIdImg] placeholderImage:[ProjConfig getAppIcon]];
            [contentV addSubview:rightImageV];
            
            UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, margin, 50*pt, 50*pt)];
            leftImageV.centerX = (itemW-20)/2.0-15;
            leftImageV.layer.cornerRadius = 25*pt;
            leftImageV.clipsToBounds = YES;
            leftImageV.layer.borderWidth = 1.0;
            [leftImageV sd_setImageWithURL:[NSURL URLWithString:model.userHeadImg] placeholderImage:[ProjConfig getAppIcon]];
            leftImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            [contentV addSubview:leftImageV];
            
             
            UIImageView *connectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, rightImageV.maxY-35*pt, 50*pt, 50*pt)];
            connectImageV.contentMode = UIViewContentModeScaleAspectFit;
            connectImageV.centerX = (itemW-20)/2.0;
            connectImageV.image = [UIImage imageNamed:@"icon_mine_guard_normal"];
            [contentV addSubview:connectImageV];
            
            UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, leftImageV.maxY+10, itemW-20, 20)];
            nameL.textColor = kRGB_COLOR(@"#333333");
            nameL.font = [UIFont systemFontOfSize:14];
            nameL.textAlignment = NSTextAlignmentCenter;
            nameL.text = model.username;
            [contentV addSubview:nameL];
            
            UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY, itemW-20, 30)];
            dayL.textColor = model.isOverdue?kRGB_COLOR(@"#666666"):kRGB_COLOR(@"#FC4B5C");
            dayL.font = [UIFont boldSystemFontOfSize:25];
            dayL.textAlignment = NSTextAlignmentCenter;
            NSString *dayStr = [NSString stringWithFormat:kLocalizationMsg(@"%lld天"),model.guardDay];
            NSMutableAttributedString *dayAtt = [[NSMutableAttributedString alloc]initWithString:dayStr];
            [dayAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[dayStr rangeOfString:kLocalizationMsg(@"天")]];
            dayL.attributedText = dayAtt;
            [contentV addSubview:dayL];
        }
    }else{
        guardListbackView.image = [UIImage imageNamed:@"icon_userinfo_guard_list_empty"];
        UIImageView *emptyImageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, (viewHeight-40-90)/2.0-30, 100, 90)];
        emptyImageV.image = [UIImage imageNamed:@"icon_guard_empty"];
        [self.scrollView addSubview:emptyImageV];
        
        UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(emptyImageV.maxX+10, 0, kScreenWidth-20-100, 20)];
        tipL.textColor = kRGB_COLOR(@"#999999");
        tipL.font = [UIFont systemFontOfSize:13];
        tipL.centerY = emptyImageV.centerY;
        tipL.textAlignment = NSTextAlignmentCenter;
        tipL.text = kLocalizationMsg(@"还没有人守护Ta哦~");
        [self.scrollView addSubview:tipL];
    }
    scrollV.contentSize = CGSizeMake(num*itemW, viewHeight-40);
    
}
- (void)addGuardPrivilegeView{
    [self.privilegeView removeAllSubViews];
    [self.privilegeView removeFromSuperview];
    self.privilegeView = nil;
    
    CGFloat pt = kScreenWidth/375.0;
    CGFloat scale = 500/750.0;
    CGFloat viewHeight = kScreenWidth*scale;
    CGFloat margin = (viewHeight-40-20-60-50*pt)/2.0;
    CGFloat bottmH = 0;
    if (self.userId != [ProjConfig userId]) {
        bottmH = 70+kSafeAreaBottom;
    }
    guardPrivilegeView *privilegeView = [[guardPrivilegeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight-bottmH) from:YES contentY:viewHeight-margin-10];
    self.privilegeView = privilegeView;
    [self.view insertSubview:privilegeView atIndex:2];
     
}
- (void)updateBottomView{
    [self.botomView removeAllSubViews];
    [self.botomView removeFromSuperview];
    self.botomView = nil;
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-70-kSafeAreaBottom, kScreenWidth, 70+kSafeAreaBottom)];
    bottomV.backgroundColor = kRGB_COLOR(@"#FFF8FD");
    self.botomView = bottomV;
    [self.view insertSubview:bottomV atIndex:1];
    
    UIImageView *avterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    avterImageV.contentMode = UIViewContentModeScaleAspectFill;
    avterImageV.layer.cornerRadius = 25;
    avterImageV.clipsToBounds = YES;
    [avterImageV sd_setImageWithURL:[NSURL URLWithString:self.guardInfoModel.anchorIdImg] placeholderImage:[ProjConfig getAppIcon]];
    [bottomV addSubview:avterImageV];
    
    if (self.guardInfoModel.isOverdue > 0) {
        UIImageView *guardImageV = [[UIImageView alloc]initWithFrame:CGRectMake( 30, 20, 50, 50)];
        guardImageV.contentMode = UIViewContentModeScaleAspectFit;
        if (self.guardInfoModel.isOverdue) {
            guardImageV.image = [UIImage imageNamed:@"icon_mine_guard_fail"];
        }else{
            guardImageV.image = [UIImage imageNamed:@"icon_mine_guard_normal"];
        }
        [bottomV addSubview:guardImageV];
    }
    
    UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(avterImageV.maxX+20, 25, kScreenWidth-80-100-50, 20)];
    textL.textColor = kRGB_COLOR(@"#333333");
    textL.textAlignment = NSTextAlignmentLeft;
    textL.font = [UIFont systemFontOfSize:14];
    NSString *str;
    NSString *day;
    NSString *title;
    if (self.guardInfoModel.isOverdue != -1) {
        if (self.guardInfoModel.isOverdue > 0) {
            title = kLocalizationMsg(@"我要守护");
            day = [NSString stringWithFormat:@"%lld",self.guardInfoModel.guardDay];
            str = [NSString stringWithFormat:kLocalizationMsg(@"守护Ta%@天"),day];
        }else{
            title = kLocalizationMsg(@"继续守护");
            day = [NSString stringWithFormat:@"%lld",self.guardInfoModel.guardDay];
            str = [NSString stringWithFormat:kLocalizationMsg(@"第%@天守护Ta"),day];
        }
    }else{
        day = @"";
        title = kLocalizationMsg(@"开始守护");
        str = kLocalizationMsg(@"从今天开始守护Ta");
    }
    NSMutableAttributedString *dayAtt = [[NSMutableAttributedString alloc]initWithString:str];;
    [dayAtt addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range:[str rangeOfString:day]];
    textL.attributedText = dayAtt;
    [bottomV addSubview:textL];
    
    UIButton *guardBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-15-80, 19, 80, 32)];
    guardBtn.layer.cornerRadius = 16;
    guardBtn.clipsToBounds = YES;
    guardBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [guardBtn setBackgroundImage:[UIImage createImageSize:guardBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    [guardBtn setTitle:title forState:UIControlStateNormal];
    [guardBtn addTarget:self action:@selector(guardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:guardBtn];
}
#pragma mark - 数据
- (void)loadData{
    kWeakSelf(self);
    [HttpApiGuard getMyGuardList:0 pageSize:10 queryType:1 type:2 userId:self.userId callback:^(int code, NSString *strMsg, NSArray<GuardUserVOModel *> *arr) {
        if (code == 1) {
            [weakself.dataArr removeAllObjects];
            if (arr.count > 0) {
                [weakself.dataArr addObjectsFromArray:arr];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself updateUserGuardListView];
            });
            if (weakself.userId != [ProjConfig userId]) {
                [weakself getMyToUserGuardInfo];
            }
             
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getMyToUserGuardInfo{
    kWeakSelf(self);
    [HttpApiGuard getMyGuardInfo:self.userId callback:^(int code, NSString *strMsg, GuardUserVOModel *model) {
        if (code == 1) {
            weakself.guardInfoModel = model;
            weakself.guardInfoModel.userId = [ProjConfig userId];
            weakself.guardInfoModel.anchorId = weakself.userId;
            [weakself updateBottomView];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

#pragma mark - 按钮 手势
//查看守护列表
- (void)moreBtnClick:(UIButton *)btn{
    UserGuardDetailListVc *listVc = [[UserGuardDetailListVc alloc]init];
    listVc.userId = self.userId;
    [self.navigationController pushViewController:listVc animated:YES];
}

// 购买守护
- (void)guardBtnClick:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
        return;
    }
    [RouteManager routeForName:RN_center_buyGuard currentC:self  parameters:@{@"userId":@(self.guardInfoModel.anchorId)}];
}
 


@end
