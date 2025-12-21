//
//  LiveOnlineUserList.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveOnlineUserList.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <MJRefresh/MJRefresh.h>
#import "LiveUserListCell.h"
#import <SDWebImage/SDWebImage.h>
#import "UserInfoListView.h"

@interface LiveOnlineUserList ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *muItems;

@property (nonatomic, assign)int page;

@property (nonatomic, weak)UserInfoListView *userInfoList;

@end

@implementation LiveOnlineUserList

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _page = 0;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self.tableV reloadData];
    [self loadData];
}

- (void)loadData{
//    int pageSize = kPageSize;
    //    PublicLive_getLiveUser *list = [[PublicLive_getLiveUser alloc] init];
    //    list.anchorId = [LiveManager liveInfo].anchorId;
    //    list.page = _page;
    //    list.liveType = [LiveManager liveInfo].serviceLiveType;
    ////    list.pageSize = pageSize;
    ////    int page = 0;
    ////    if (_muItems.count) {
    ////        page = _muItems.count/pageSize+(_muItems.count%pageSize>0?1:0);
    ////    }
    
    [self.muItems removeAllObjects];
    kWeakSelf(self);
    [HttpApiPublicLive getLiveUser:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiUserBasicInfoModel *> *arr) {
        [weakself.tableV.mj_footer endRefreshing];
        if (code == 1) {
            if (weakself.page == 0) {
                [self.muItems removeAllObjects];
            }
            [weakself.muItems addObjectsFromArray:arr];
            [weakself.tableV reloadData];
//            if (arr.count<pageSize) {
//                [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
//            }
            [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
        }else{
            
        }
    }];
}


- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        kWeakSelf(self);
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            ++ weakself.page;
            [weakself loadData];
        }];
        [tableView registerClass:[LiveUserListCell class] forCellReuseIdentifier:@"LiveUserListCellIdentifier"];
        [self addSubview:tableView];
        _tableV = tableView;
        
        if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
            tableView.frame = CGRectMake(0, 0, self.width, self.height-60);
            UserInfoListView *userList = [[UserInfoListView alloc] initWithFrame:CGRectMake(0,tableView.maxY, self.width, 60)];
            [self addSubview:userList];
            [userList loadUserInfoData];
            _userInfoList = userList;
        }
    }
    return _tableV;
}

- (NSMutableArray *)muItems{
    if (!_muItems) {
        _muItems = [[NSMutableArray alloc] init];
    }
    return _muItems;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveUserListCellIdentifier" forIndexPath:indexPath];
    if (_muItems.count>indexPath.row) {        
        [self showNumberLab:cell.numberL number:indexPath.row+1];
        cell.userModel = _muItems[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)showNumberLab:(UILabel *)numberL number:(NSInteger)number{
    numberL.text = [NSString stringWithFormat:@"%zi",number];
    switch (number) {
        case 1:
        case 2:
        case 3:
        {
            numberL.textColor = [UIColor redColor];
        }
            break;
        default:
        {
            numberL.textColor = [UIColor darkGrayColor];
        }
            break;
    }
}



@end
