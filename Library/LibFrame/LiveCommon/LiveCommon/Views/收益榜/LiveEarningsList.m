//
//  LiveEarningsList.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveEarningsList.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LiveCommon/LiveManager.h>
#import <MJRefresh/MJRefresh.h>
#import "LiveAnchorListCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@interface LiveEarningsList ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *muItems;

@property (nonatomic, assign)int earningType;

@end

@implementation LiveEarningsList


- (instancetype)initWithFrame:(CGRect)frame earningType:(int)earningType
{
    self = [super initWithFrame:frame];
    if (self) {
        _earningType = earningType;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self.tableV reloadData];
    [self loadData];
}

- (void)loadData{
    kWeakSelf(self);
    [HttpApiAPPFinance votesList:0 sex:-1 type:self.earningType uid:0 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<RanksDtoModel *> *arr) {
        if (code == 1) {
            [self.muItems removeAllObjects];
            [weakself.muItems addObjectsFromArray:arr];
            [weakself.tableV reloadData];
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
        [tableView registerClass:[LiveAnchorListCell class] forCellReuseIdentifier:@"LiveAnchorListCellIdentifier"];
        [self addSubview:tableView];
        _tableV = tableView;
        
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
    LiveAnchorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveAnchorListCellIdentifier" forIndexPath:indexPath];
    if (_muItems.count>indexPath.row) {
        cell.voterModel = _muItems[indexPath.row];
        cell.index = indexPath.row+1;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}






@end
