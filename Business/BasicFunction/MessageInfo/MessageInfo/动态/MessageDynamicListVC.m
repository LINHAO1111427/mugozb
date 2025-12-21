//
//  MessageDynamicListVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MessageDynamicListVC.h"

#import "MessageDyListCell.h"

#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiDynamicController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/HttpApiMessage.h>

#import <LibProjView/ChatInputView.h>
#import <LibProjView/ForceAlertController.h>
#import <LibProjView/EmptyView.h>

@interface MessageDynamicListVC ()<UITableViewDelegate,UITableViewDataSource,DynamicMsgCommentRespondDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, assign)int switchType;//0动态 1短视频
@property (nonatomic, strong)UIView *switchView;
@property (nonatomic, strong)UIView *shortVideoRedPoint;
@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, assign)NSUInteger currentInteractiveIndex;

@end

@implementation MessageDynamicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ProjConfig projBgColor];
    self.navigationItem.title = kLocalizationMsg(@"评论列表");
    [self creatSubView];
    
    [self clearDynamicComment];
}


- (void)clearDynamicComment{
    [HttpApiMessage clearNoticeMsg:-1 type:1 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
    }];
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadMessageDyData:YES];
    if ([ProjConfig getAppType] == 4) {
        [self clearShortVideoUnreadMessage];
    }
}

-(void)creatSubView{
    self.switchType = 0;
    if ([ProjConfig getAppType] == 4) { //纯短视频
        self.switchType = 1;
    }

    if([ProjConfig isContainShortVideo] && [ProjConfig getAppType] != 4){
        UIView *switchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        switchView.backgroundColor = [ProjConfig projBgColor];
        self.switchView = switchView;
        [self.view addSubview:self.switchView];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.3)];
        line.backgroundColor = kRGBA_COLOR(@"#999999", 0.5);
        [self.switchView addSubview:line];
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*kScreenWidth/2.0, 1, kScreenWidth/2.0, 39)];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                btn.selected = YES;
                [btn setTitle:kLocalizationMsg(@"动态评论") forState:UIControlStateNormal];
            }else{
                [btn setTitle:kLocalizationMsg(@"短视频评论") forState:UIControlStateNormal];
            }
            [btn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
            [btn setTitleColor:kRGB_COLOR(@"#925EFF") forState:UIControlStateSelected];
            btn.tag = i;
            [btn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.switchView addSubview:btn];
            
            UIView *point = [[UIView alloc]initWithFrame:CGRectMake(3*kScreenWidth/4.0+38,8, 6, 6)];
            point.layer.cornerRadius = 3;
            point.clipsToBounds = YES;
            point.backgroundColor = [UIColor redColor];
            point.hidden = YES;
            self.shortVideoRedPoint = point;
            [self.switchView addSubview:self.shortVideoRedPoint];
            [self getUnreadShortVideoMessageNum];//获取未读
        }
    }
    
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(0);
        make.top.equalTo(self.view).mas_offset(self.switchView.height);
    }];
    [self.tableView registerClass:[MessageDyListCell class] forCellReuseIdentifier:@"MessageDyListCellID"];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadMessageDyData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself reloadMessageDyData:NO];
    }];
    
    EmptyView *empty = [[EmptyView alloc] init];
    empty.titleL.text = kLocalizationMsg(@"暂无评论哦~");
    [empty showInView:self.view andFrame:CGRectMake(0, self.switchView.height, self.view.width, self.view.height - 100-self.switchView.height)];
    _emptyV = empty;
    
}

- (void)getUnreadShortVideoMessageNum{
    kWeakSelf(self);
    [HttpApiMessage getAppSystemNoRead:^(int code, NSString *strMsg, ApiNoReadModel *model) {
        if (code== 1) {
            weakself.shortVideoRedPoint.hidden = !model.shortVideoNoRead;
        }
    }];
}
- (void)clearShortVideoUnreadMessage{
    kWeakSelf(self);
    [HttpApiMessage clearNoticeMsg:-1 type:4 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.shortVideoRedPoint.hidden = YES;
        }
    }];
}

- (void)switchBtnClick:(UIButton *)btn{
    self.switchType = (int)btn.tag;
    for (UIView *subV in self.switchView.subviews) {
        if ([subV isKindOfClass:[UIButton class]]) {
            UIButton *btnS = (UIButton *)subV;
            if (btnS.tag == self.switchType) {
                btnS.selected = YES;
            }else{
                btnS.selected = NO;
            }
        }
    }
    if (self.switchType == 1 && !self.shortVideoRedPoint.hidden) {
        [self clearShortVideoUnreadMessage];
    }
    [self reloadMessageDyData:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ApiCommentsMsgModel *model = _dataArr[indexPath.row];
    return model.type==2?120:140;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageDyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageDyListCellID" forIndexPath:indexPath];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[MessageDyListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageDyListCellID"];
    }
    
    cell.model = self.dataArr[indexPath.row];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiCommentsMsgModel *model = self.dataArr[indexPath.row];
    if (self.switchType == 0) {
        [HttpApiDynamicController getDynamicInfo:(int)model.commentId dynamicId:model.videoId type:model.type callback:^(int code, NSString *strMsg, ApiUserVideoModel *model) {
            [RouteManager routeForName:RN_dynamic_playVideoVC currentC:[ProjConfig currentVC] parameters:@{@"models":@[model],@"hasLoading":@(NO)}];
        }];
        
    }else{
        NSDictionary *prams = @{
            @"dataType":@(4), 
            @"checkType":@(model.type),
            @"commentId":@(model.commentId),
            @"index":@(0),
            @"shortVideoId":@(model.videoId)
        };
        [RouteManager routeForName:RN_shortVideo_play_List currentC:self parameters:prams];
    }
}
 

//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.switchView.height, kScreenWidth, kScreenHeight - kNavBarHeight -self.switchView.height) style:UITableViewStyleGrouped];
        _tableView.separatorColor = kRGB_COLOR(@"#DDDDDD");
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)reloadMessageDyData:(BOOL)refresh{
    if (self.switchType == 0) {
        [self loadDynamicCommentList:refresh];//加载动态评论
    }else{
        [self loadShortVideoCommentList:refresh];//加载短视频评论
    }
    
}
- (void)loadShortVideoCommentList:(BOOL)refresh{
    int pageSize = kPageSize;
    int page = refresh?0:(int)self.dataArr.count/pageSize  + (self.dataArr.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiMessage shortVideoCommentsList:page pageSize:pageSize callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiCommentsMsgModel *> *arr) {
        if (code == 1) {
            
            if (refresh) {
                [weakself.dataArr removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArr addObjectsFromArray:arr];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
        }else{
            
            [SVProgressHUD showInfoWithStatus:strMsg];
            
        }
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
        weakself.emptyV.hidden = weakself.dataArr.count;
    }];
}

- (void)loadDynamicCommentList:(BOOL)refresh{
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArr.count/pageSize  + (self.dataArr.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiMessage videoCommentsList:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiCommentsMsgModel *> *arr) {
        if (code == 1) {
            
            if (refresh) {
                [weakself.dataArr removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.dataArr addObjectsFromArray:arr];
            }else{
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
        }else{
            
            [SVProgressHUD showInfoWithStatus:strMsg];
            
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        weakself.emptyV.hidden = weakself.dataArr.count;
    }];
    
}

-(void)respondUserComment:(ApiCommentsMsgModel *)model{
    NSString *showPlaceHolder = @"";
    if (model.type == 1) {
        showPlaceHolder = [NSString stringWithFormat:kLocalizationMsg(@"回复%@:"),model.userName];
    }
    [ChatInputView showInput:showPlaceHolder inputText:^(NSString * _Nullable inputText) {
        int commentType = 1;
        if (model.type == 1) {
            commentType = 2;
        }
        int64_t objId = commentType == 1?model.videoId:model.commentId;
        if (inputText.length>0) {
            if (self.switchType == 0) {//动态
                [HttpApiDynamicController addComment:commentType content:inputText objId:objId callback:^(int code, NSString *strMsg, ApiUsersVideoCommentsModel *model) {
                    if (strMsg.length > 0) {
                        HudShowString(strMsg)
                    }
                }];
            } else {//短视频
                [HttpApiAppShortVideo shortVideoComment:commentType content:inputText objId:objId callback:^(int code, NSString *strMsg, ApiShortVideoCommentsModel *model) {
                    if (strMsg.length > 0) {
                        HudShowString(strMsg)
                    }
                }];
            }
        }
    }];
}



-(void)deleteUserComment:(ApiCommentsMsgModel *)model{
    kWeakSelf(self);
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"删除评论") message:kLocalizationMsg(@"是否删除这条评论")];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [weakself deleteCommentAction:model];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)deleteCommentAction:(ApiCommentsMsgModel *)model{
    kWeakSelf(model);
    if (self.switchType == 0) {//动态
        [HttpApiDynamicController delComment:model.commentId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [self.dataArr removeObject:weakmodel];
                [self.tableView reloadData];
                HudShowSuccess(strMsg)
            }else{
                
                HudShowError(strMsg)
            }
        }];
    } else {//短视频
        [HttpApiAppShortVideo delShortVideoComment:model.commentId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [self.dataArr removeObject:weakmodel];
                [self.tableView reloadData];
                HudShowSuccess(strMsg)
            }else{
                HudShowError(strMsg)
            }
        }];
    }
}


- (UIView *)listView {
    return self.view;
}

@end
