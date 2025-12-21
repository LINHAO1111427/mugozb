//
//  MyPrivilegeViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import "MyPrivilegeViewController.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppGradePrivilegeModel.h>
@interface MyPrivilegeViewController ()
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)MyMemberVOModel *memberModel;
@end

@implementation MyPrivilegeViewController

- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _scrollview.backgroundColor = [UIColor whiteColor];
        _scrollview.scrollEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
    }
    return _scrollview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    [self.view addSubview:self.scrollview];
    self.navigationController.navigationBar.translucent = NO;
    UIButton *levelDesBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 32)];
    [levelDesBtn setTitleColor: kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [levelDesBtn setTitle:kLocalizationMsg(@"等级说明") forState:UIControlStateNormal];
    levelDesBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [levelDesBtn addTarget:self action:@selector(levelDesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:levelDesBtn];;
    self.navigationItem.rightBarButtonItem = item;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    [self.navigationController.navigationBar addSubview:line];
    
    [self loadData];
}
- (void)loadData{
    kWeakSelf(self);
    [HttpApiUserController getMyMember:^(int code, NSString *strMsg, MyMemberVOModel *model) {
        if (code == 1) {
            weakself.memberModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself createUI];
                weakself.scrollview.contentSize = [weakself getContentSize];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (CGSize)getContentSize{
    CGFloat cellHeight = 0;
    CGFloat width = kScreenWidth*46/360.0;
    CGFloat height = width+40;
     
    //用户特权
    NSInteger userNum = self.memberModel.userGradePrivilegeList.count;
    NSInteger userRow = 0;
    CGFloat userHeight = 0;
    if (userNum > 0) {
        userRow = (userNum-1)/4+1;
        userHeight =  userRow *height+30;
    }
    cellHeight += userHeight+20;
    
    //财富特权
    NSInteger wealthNum = self.memberModel.wealthGradePrivilegeList.count;
    NSInteger wealthRow = 0;
    CGFloat wealthHeight = 0;
    if (wealthNum > 0) {
        wealthRow = (wealthNum-1)/4+1;
        wealthHeight =  wealthRow *height+30;
    }
    cellHeight += wealthHeight+20;
    
    //贵族特权
    NSInteger nobelhNum = self.memberModel.nobleGradePrivilegeList.count;
    NSInteger nobelRow = 0;
    CGFloat nobelHeight = 0;
    if (nobelhNum > 0) {
        nobelRow = (nobelhNum-1)/4+1;
        nobelHeight =  nobelRow *height+30;
    }
    cellHeight += nobelHeight+20;
    if (cellHeight+20+60 >= kScreenHeight-kNavBarHeight) {
        return CGSizeMake(kScreenWidth, cellHeight+20+60);
    }
    
    return  CGSizeMake(kScreenWidth, kScreenHeight-kNavBarHeight);
}


- (void)createUI{
    CGFloat width = kScreenWidth*46/360.0;
    CGFloat height = width+40;
//    CGFloat space = (kScreenWidth-24-width*4)/5.0;
     
    //用户特权
    NSInteger userNum = self.memberModel.userGradePrivilegeList.count;
    NSInteger userRow = 0;
    CGFloat userHeight = 0;
    if (userNum > 0) {
        userRow = (userNum-1)/4+1;
        userHeight =  userRow *height+30;
    }
    UIView *userPrivilegeView = [[UIView alloc]initWithFrame:CGRectMake(12, 20, kScreenWidth-24, userHeight)];
    userPrivilegeView.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:userPrivilegeView];
    if (userNum > 0) {
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 20)];
        titleL.textColor =kRGB_COLOR(@"#999999");
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.text = kLocalizationMsg(@"用户等级");
        [userPrivilegeView addSubview:titleL];
    }
    [self createPrivilegeSubView:self.memberModel.userGradePrivilegeList superView:userPrivilegeView type:0];
     
    
    //财富特权
    NSInteger wealthNum = self.memberModel.wealthGradePrivilegeList.count;
    NSInteger wealthRow = 0;
    CGFloat wealthHeight = 0;
    if (wealthNum > 0) {
        wealthRow = (wealthNum-1)/4+1;
        wealthHeight =  wealthRow *height+30;
    }
    UIView *wealthPrivilegeView = [[UIView alloc]initWithFrame:CGRectMake(12, userPrivilegeView.maxY, kScreenWidth-24,wealthHeight)];
    wealthPrivilegeView.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:wealthPrivilegeView];
    if (wealthNum > 0) {
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 20)];
        titleL.textColor =kRGB_COLOR(@"#999999");
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.text = kLocalizationMsg(@"财富等级");
        [wealthPrivilegeView addSubview:titleL];
    }
    [self createPrivilegeSubView:self.memberModel.wealthGradePrivilegeList superView:wealthPrivilegeView type:1];
    
    //贵族特权
    NSInteger nobleNum = self.memberModel.nobleGradePrivilegeList.count;
    NSInteger nobleRow = 0;
    CGFloat nobleHeight = 0;
    if (nobleNum > 0) {
        nobleRow = (nobleNum-1)/4+1;
        nobleHeight =  nobleRow *height+30;
    }
    UIView *noblePrivilegeView = [[UIView alloc]initWithFrame:CGRectMake(12, wealthPrivilegeView.maxY, kScreenWidth-24, nobleHeight)];
    noblePrivilegeView.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:noblePrivilegeView];
    if (nobleNum > 0) {
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 20)];
        titleL.textColor =kRGB_COLOR(@"#999999");
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.text = kLocalizationMsg(@"贵族等级");
        [noblePrivilegeView addSubview:titleL];
    }
    [self createPrivilegeSubView:self.memberModel.nobleGradePrivilegeList superView:noblePrivilegeView type:2];
}
- (void)createPrivilegeSubView:(NSArray *)privilegeArr superView:(UIView *)superView type:(NSInteger)type{
    CGFloat width = kScreenWidth*46/360.0;
    CGFloat height = width+40;
    CGFloat space = (kScreenWidth-24-width*4)/5.0;
    CGFloat maginW = 0;
    if (space > 0) {
       maginW = space/2.0;
    }
    NSInteger row = 0;
    NSInteger col = 0;
    for (int i = 0; i < privilegeArr.count; i++) {
        AppGradePrivilegeModel *model = privilegeArr[i];
        row = i/4;
        col = i%4;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(space-maginW/2.0+col*(width+space),30+ row*height, width+maginW, height-10)];
        view.backgroundColor = [UIColor whiteColor];
        [superView addSubview:view];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(maginW/2.0, 0, width, width)];
        if (model.status) {
            //0：未拥有 1：已拥有
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.lineLogo] placeholderImage:PlaholderImage];
        }else{
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.offLineLogo] placeholderImage:PlaholderImage];
        }
        
        imageV.contentMode =  UIViewContentModeScaleAspectFit;
        [view addSubview:imageV];
        UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, width, width+maginW, 10)];
//        if (model.isStart) {
//            levelLabel.textColor =kRGB_COLOR(@"#00B4F6");
//        }else{
            levelLabel.textColor =kRGB_COLOR(@"#999999");
//        }
         
        levelLabel.textAlignment = NSTextAlignmentCenter;
        if (type == 2) {
            levelLabel.text = [NSString stringWithFormat:@"Lv:%@",model.desr];
        }else{
            levelLabel.text = [NSString stringWithFormat:@"Lv:%d",model.grade];
        }
        
        switch (type) {
            case 0:
               levelLabel.text = [NSString stringWithFormat:@"Lv:%d",model.grade];
                if (model.status) {
                   levelLabel.textColor =kRGB_COLOR(@"#00B4F6");
                }
                break;
            case 1:
                levelLabel.text = [NSString stringWithFormat:@"Lv:%d",model.grade];
                if (model.status) {
                   levelLabel.textColor =kRGB_COLOR(@"#FEA10E");
                }
                break;
            case 2:
                 levelLabel.text = [NSString stringWithFormat:@"Lv:%@",model.desr];
                if (model.status) {
                   levelLabel.textColor =kRGB_COLOR(@"#E73789");
                }
                break;
            default:
                break;
        }
        
        levelLabel.font = [UIFont systemFontOfSize:9];
        [view addSubview:levelLabel];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, levelLabel.maxY, width+maginW, 20)];
        if (model.status) {
            nameLabel.textColor = MineBlackTextColor;
        }else{
            nameLabel.textColor =kRGB_COLOR(@"#999999");
        }
        nameLabel.font = [UIFont systemFontOfSize:10];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = model.name;
        [view addSubview:nameLabel];
    }
}
- (void)levelDesBtnClick:(UIButton *)btn{
    NSString *strUrl = @"/api/h5/gradeDesr?type=1";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":strUrl}];
}
@end
