//
//  FansContributionList.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "FansContributionList.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LiveCommon/LiveManager.h>
#import <MJRefresh/MJRefresh.h>
#import "LiveUserListCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@interface FansContributionList ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, copy)NSArray *muItems;

@end

@implementation FansContributionList

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData:YES];
    }
    return self;
}

- (void)createUI{
    
}

- (void)loadData:(BOOL)refresh{
    kWeakSelf(self);
    [HttpApiAPPFinance contributionList:[LiveManager liveInfo].anchorId findType:4 sex:-1 showId:[LiveManager liveInfo].serviceShowId type:0 callback:^(int code, NSString *strMsg, NSArray<RanksDtoModel *> *arr) {
        [weakself.tableV.mj_footer endRefreshing];
        if (code == 1) {
            weakself.muItems = arr;
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
        [tableView registerClass:[LiveUserListCell class] forCellReuseIdentifier:@"LiveUserListCellIdentifier"];
        [self addSubview:tableView];
        _tableV = tableView;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveUserListCellIdentifier" forIndexPath:indexPath];
    if (_muItems.count>indexPath.row) {
        RanksDtoModel *model = _muItems[indexPath.row];
        [self showNumberLab:cell.numberL number:model.sort];
        cell.ranksModel = model;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)showNumberLab:(UILabel *)numberL number:(int)number{
    
    [numberL.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (number) {
        case 1:
            {
                [self createLeveView:numberL number:number imageName:@"live_list_no1"];
            }
            break;
        case 2:
            {
                [self createLeveView:numberL number:number imageName:@"live_list_no2"];
            }
            break;
        case 3:
            {
                [self createLeveView:numberL number:number imageName:@"live_list_no3"];
            }
            break;
        default:
        {
            numberL.text = [NSString stringWithFormat:@"%d",number];
        }
            break;
    }
}


- (void)createLeveView:(UILabel *)lab number:(int)number imageName:(NSString *)imageName{
    lab.text = @"";
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [lab addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(lab);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    UILabel *numL = [[UILabel alloc] init];
    numL.textAlignment = NSTextAlignmentCenter;
    numL.textColor = [UIColor whiteColor];
    numL.font = [UIFont systemFontOfSize:10];
    numL.text = [NSString stringWithFormat:@"%d",number];
    [imgV addSubview:numL];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgV);
        make.bottom.equalTo(imgV).mas_offset(-1);
    }];
}


@end
