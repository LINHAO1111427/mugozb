//
//  MessageMainVC.m
//  klcDemo
//
//  Created by klc_sl on 2020/12/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MessageMainVC.h"
#import <JXCategoryView/JXCategoryTitleView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>
#import "MessageCenterVC.h"
#import <LibProjBase/BaseNavBarItem.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import "MessageNoReadSocketTool.h"
#import <LibProjView/ForceAlertController.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import <LibProjView/PopView.h>
#import "MineAddressBookVC.h"

@interface MessageMainVC () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,JXCategoryTitleViewDataSource>

@property (nonatomic, weak) JXCategoryTitleView *titleView;

@property (nonatomic, strong) MessageCenterVC *messageCenterVC;

@property (nonatomic, copy) MessageNoReadSocketTool *noReadSocketTool;

@property (nonatomic, assign)int64_t unReadTotalNumBlock;

@property (nonatomic,copy)NSArray  *typeArr;//类型


@end

@implementation MessageMainVC

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}

- (void)dealloc
{
    [_noReadSocketTool removeMessageSocket];
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self);
        _noReadSocketTool = [MessageNoReadSocketTool share];
        _noReadSocketTool.unReadTotalNumBlock = ^(int64_t noReadNum) {
            weakself.unReadTotalNumBlock = noReadNum;
        };
        [_noReadSocketTool getAppSystemNoReadData];
        
        _typeArr = [[ProjConfig shareInstence].businessConfig getMessageCenterClassfiyArray];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationUpdateStatusNoti:) name:NotificationUpdateStatus object:nil];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ///一键清除
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn setBackgroundImage:[UIImage imageNamed:@"message_func_add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(showClearView:) forControlEvents:UIControlEventTouchUpInside];
    [self addCategoryView];
}

- (void)showClearView:(UIButton *)btn{
    kWeakSelf(self);

    NSArray *itemArr = @[@{@"name":kLocalizationMsg(@"一键已读"),@"image":@"message_list_allread",@"type":@"1"},
                         @{@"name":kLocalizationMsg(@"一键删除"),@"image":@"message_list_alldelete",@"type":@"2"},
                         @{@"name":kLocalizationMsg(@"黑名单"),@"image":@"message_list_black",@"type":@"3"},];
    
    CGFloat itemHeight = 40;
    UIView *popListV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, itemArr.count*itemHeight+20)];
    popListV.backgroundColor = [UIColor whiteColor];
    popListV.layer.cornerRadius = 5;
    for (int i = 0; i< itemArr.count; i++) {
        NSDictionary *subDic = itemArr[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 10+i*itemHeight, popListV.width, itemHeight);
        [popListV addSubview:btn];
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (itemHeight-20)/2.0, 20, 20)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [btn addSubview:imgV];
        imgV.image = [UIImage imageNamed:subDic[@"image"]];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(imgV.maxX+10, 0, btn.width-imgV.width-10, btn.height)];
        titleL.text = subDic[@"name"];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        [btn addSubview:titleL];
        
        NSInteger selectType = [subDic[@"type"] intValue];
        [btn klc_whenTapped:^{
            if (selectType == 1) {
                [weakself showClearUnRead];
            }else if (selectType == 2){
                [weakself showDeleteChatAndUnread];
            }else{
                [weakself pushUserBlack];
            }
            [PopView hidenPopView];
        }];
    }

    
    PopView *popView = [PopView popUpContentView:popListV direct:PopViewDirection_PopUpBottom onView:btn];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

- (void)pushUserBlack{
    [RouteManager routeForName:RN_User_MineBlackList currentC:self];
}

- (void)showClearUnRead{
    if (self.unReadTotalNumBlock >0) {
        [self clearAllMessage];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"暂时没有未读消息~")];
    }
}

- (void)showDeleteChatAndUnread{
    if (self.messageCenterVC) {
        kWeakSelf(self);
        ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定将所有消息都删除吗？")];
        [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
        [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
            [weakself.messageCenterVC clearConversations];
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


- (void)clearAllMessage{
    kWeakSelf(self);
    ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确定将所有消息标记为已读吗？")];
    [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [weakself.noReadSocketTool clearAllUnreadMessage];
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}
 
- (void)addCategoryView{
    
    [self.titleView removeAllSubViews];
    [self.titleView removeFromSuperview];
    
    self.titleView = nil;
    
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSDictionary *subDic in _typeArr) {
        [titles addObject:subDic[@"title"]];
    }
    
    CGFloat itemW = 100;
    CGFloat maxW = MIN(itemW*titles.count, kScreenWidth-200);

    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake((kScreenWidth-maxW)/2.0, 0, maxW, kNavBarHeight-kStatusBarHeight-5)];
    titleView.delegate = self;
    titleView.titleDataSource = self;
    titleView.titles = titles;
    titleView.titleColorGradientEnabled = NO;
    titleView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.titleFont = [UIFont systemFontOfSize:kTitleViewTitleFont];
    titleView.titleSelectedFont = [UIFont systemFontOfSize:kTitleViewTitleSelectedFont];
    titleView.titleColor = [ProjConfig projNavTitleColor];
    titleView.titleSelectedColor = [ProjConfig projNavTitleColor];
    [titleView setDefaultSelectedIndex:0];
    self.titleView = titleView;
    
    ///多于一个
    if (titles.count > 1) {
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [ProjConfig projNavTitleColor];
        lineView.indicatorWidth = 16.0;
        titleView.indicators = @[lineView];
    }else{
        titleView.height = 30;
    }
    
    JXCategoryListContainerView *listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    listContainerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:listContainerView];
    [listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.titleView.listContainer = listContainerView;
//    [listContainerView reloadData];
//    [self.navigationController.navigationBar addSubview:self.titleView];
    
    self.navigationItem.titleView = self.titleView;

    for (int i = 0; i < _typeArr.count; i++) {
        NSDictionary *subDic = _typeArr[i];
        if ([subDic[@"id"] intValue] == 1) { //消息
            ///优先刷新消息
            [self listContainerView:listContainerView initListForIndex:i];
        }
    }
}

- (void)NotificationUpdateStatusNoti:(NSNotification *)aNotification{
    [_noReadSocketTool getAppSystemNoReadData];
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index{
    NSDictionary *subDic = _typeArr[index];
    switch ([subDic[@"id"] intValue]) {
        case 1://消息
        {
            MessageCenterVC *messageCenterVC = [[MessageCenterVC alloc] init];
            self.messageCenterVC = messageCenterVC;
            return messageCenterVC;
        }
            break;
        case 2://通讯录
        {
            MineAddressBookVC *listVC = [[MineAddressBookVC alloc] init];
            return listVC;
        }
            break;
    }
    return nil;
}



- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.typeArr.count;
}

@end
