//
//  AnchorOnlineView.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "AnchorOnlineView.h"

#import "AnchorCell.h"
#import "MPVideoLiveRes.h"

#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjModel/HttpApiHttpLive.h>

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjView/FunctionSheetBaseView.h>
 

@interface AnchorOnlineView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, copy) NSArray *listArray;
@property (nonatomic, copy) NSArray *searchArray;

@property (nonatomic, weak) UITableView *listTableV;
@property (nonatomic, weak) UITableView *searchTableV;

@property (nonatomic, weak) UIView *listBgView;
@property (nonatomic, weak) UILabel *searchNotingL;
@property (nonatomic, weak) UITextField *searchF;
@property (nonatomic, weak) UIButton *searchBtn;
@property (nonatomic, weak) UIButton *closeBtn;

@property (nonatomic, copy)void (^selectUserConn)(int64_t);

@end

@implementation AnchorOnlineView

+ (void)showOnlineWishSelectConn:(void (^)(int64_t))selectBlock{
    
    AnchorOnlineView *listView = [[AnchorOnlineView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight*0.55)];
    listView.selectUserConn = selectBlock;
    [listView createUI];
    [FunctionSheetBaseView showView:listView cover:NO];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//空白按钮
- (void)hideBtnClick{
    [_searchF resignFirstResponder];
}

- (void)cancelSearch{
    _searchF.text = @"";
    _searchF.frame = CGRectMake(self.frame.size.width - 40, 5, 0, 30);
    _searchBtn.hidden = NO;
    [_searchTableV.mj_header endRefreshing];
    CATransition *transition = [CATransition animation];    //创建动画效果类
    transition.duration = 0.3; //设置动画时长
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  //设置动画淡入淡出的效果
    transition.type = kCATransitionPush;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};设置动画类型，移入，推出等
    //更多私有{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    transition.subtype = kCATransitionFromLeft;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
    //    transition.delegate = self; 　　　　　　//设置属性依赖
    [_searchTableV.layer addAnimation:transition forKey:nil];       //在图层增加动画效果
    _searchTableV.hidden = YES;
    _searchArray = nil;
    [_searchTableV reloadData];
}
//关闭按钮
- (void)hideSelf{
    if (_closeBtn.selected) {
        _closeBtn.selected = NO;
        [_searchF resignFirstResponder];
        [self cancelSearch];
    }else{
        [FunctionSheetBaseView deletePopView:self];
    }
}

//搜索按钮
- (void)searchBtnClick{
    _closeBtn.selected = YES;
    _searchBtn.hidden = YES;
    [_searchF becomeFirstResponder];
    _searchTableV.hidden = NO;
    CATransition *transition = [CATransition animation];    //创建动画效果类
    transition.duration = 0.3; //设置动画时长
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  //设置动画淡入淡出的效果
    transition.type = kCATransitionPush;//{kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};设置动画类型，移入，推出等
    //更多私有{@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    transition.subtype = kCATransitionFromRight;//{kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
    
//    transition.delegate = self; 　　　　　　//设置属性依赖
    [_searchTableV.layer addAnimation:transition forKey:nil];       //在图层增加动画效果
    
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.searchF.frame = CGRectMake(40, 5, kScreenWidth-80, 30);
    }];
}


- (void)createUI{

    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    _listBgView = bgView;

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5.0;
    [bgView addSubview:headerView];
    
    UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame)-5, headerView.frame.size.width, 5)];
    headerBgV.backgroundColor = [UIColor whiteColor];
    [bgView insertSubview:headerBgV belowSubview:headerView];
    
    //头部视图
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(10, 5, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:0];
    [closeBtn setImage:[UIImage imageNamed:@"live_PK_list_back"] forState:UIControlStateSelected];
    closeBtn.selected = NO;
    [closeBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [headerView addSubview:closeBtn];
    _closeBtn = closeBtn;
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, 0, 160, 40)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = kRGB_COLOR(@"#626364");
    titleL.text = kLocalizationMsg(@"当前在线主播");
    [headerView addSubview:titleL];
    
    UIButton *searchBtn = [UIButton buttonWithType:0];
    searchBtn.frame = CGRectMake(kScreenWidth-40, 5, 30, 30);
    [searchBtn setImage:[UIImage imageNamed:@"live_PK_list_searchBar"] forState:0];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [headerView addSubview:searchBtn];
    _searchBtn = searchBtn;
    
    UITextField *searchT = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-40, 5, 0, 30)];
    searchT.delegate = self;
    searchT.placeholder = kLocalizationMsg(@"输入您要搜索的主播昵称或ID");
    searchT.backgroundColor = kRGB(241, 241, 241);
    //TextField
    searchT.layer.cornerRadius = 15;
    searchT.layer.masksToBounds = YES;
    searchT.font = [UIFont systemFontOfSize:14];
    searchT.leftViewMode = UITextFieldViewModeAlways;
    searchT.keyboardType = UIKeyboardTypeWebSearch;
    [headerView addSubview:searchT];
    _searchF = searchT;
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftImgView.image = [UIImage imageNamed:@"live_PK_list_searchBar"];
    _searchF.leftView = leftImgView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    [headerView addSubview:line];
    
    UITableView *listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), bgView.frame.size.width, bgView.frame.size.height-40) style:0];
    listTable.delegate =self;
    listTable.dataSource = self;
    listTable.separatorStyle = 0;
    [listTable registerClass:[AnchorCell class] forCellReuseIdentifier:@"AnchorCellIdentifier"];
    [_listBgView addSubview:listTable];
    _listTableV = listTable;
    kWeakSelf(self);
    listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself requestDataForAnchor:@""];
    }];
    
    UITableView *searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), kScreenWidth, bgView.frame.size.height-40) style:0];
    searchTable.delegate =self;
    searchTable.dataSource = self;
    searchTable.separatorStyle = 0;
    searchTable.hidden = YES;
    [searchTable registerClass:[AnchorCell class] forCellReuseIdentifier:@"AnchorCellIdentifier"];
    searchTable.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:searchTable];
    _searchTableV = searchTable;
    searchTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self requestDataForAnchor:searchT.text];
    }];
    
    UILabel *searchNotingL = [[UILabel alloc]initWithFrame:CGRectMake(0, searchTable.frame.size.height/2-10, searchTable.frame.size.width, 20)];
    searchNotingL.font = [UIFont systemFontOfSize:13];
    searchNotingL.text = kLocalizationMsg(@"没有搜索到相关内容");
    searchNotingL.textAlignment = NSTextAlignmentCenter;
    searchNotingL.textColor = kRGB_COLOR(@"#969696");
    searchNotingL.hidden = YES;
    [searchTable addSubview:searchNotingL];
    _searchNotingL = searchNotingL;
    [self requestDataForAnchor:@""];

}

////有字符串是搜索
- (void)requestDataForAnchor:(NSString *)string{
    kWeakSelf(self);
    BOOL isSearch = string.length > 0? YES : NO;
    [HttpApiHttpLive getUsableAnchor:string callback:^(int code, NSString *strMsg, NSArray<ApiUsableAnchorRespModel *> *arr) {
        [weakself.listTableV.mj_header endRefreshing];
        [weakself.searchTableV.mj_header endRefreshing];
        if (isSearch) {
            if (code == 1) {
                weakself.searchArray = arr;
                [weakself.searchTableV reloadData];
            }else{
              [weakself.searchTableV.mj_header endRefreshing];
            }
            weakself.searchNotingL.hidden = arr.count?YES:NO;
        }else{

            if (code == 1) {
                weakself.listArray = arr;
                [weakself.listTableV reloadData];
            }else{
                [weakself.listTableV.mj_header endRefreshing];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _listTableV) {
        return _listArray.count;
    }
    return _searchArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnchorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnchorCellIdentifier" forIndexPath:indexPath];
    cell.model = (tableView == self.listTableV)?_listArray[indexPath.row]:_searchArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiUsableAnchorRespModel *model = (tableView == self.listTableV)?_listArray[indexPath.row]:_searchArray[indexPath.row];
    if (model.ismic) {
        if (self.selectUserConn) {
            self.selectUserConn(model.userId);
        }
        [self hideSelf];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark ================ searchBar代理 ===============
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideBtnClick];
    if (textField.text.length>0) {
        [self requestDataForAnchor:_searchF.text];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入搜索的内容")];
    }
    return YES;
}


@end
