//
//  FansGroupListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FansGroupListView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/FansInfoDtoModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <MJRefresh/MJRefresh.h>
#import "FansGroupItemCell.h"
#import <LibProjView/EmptyView.h>


@interface FansGroupListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)int64_t userId;
@property (nonatomic, copy)FansGroupListCallback callBack;
@property (nonatomic, strong)FansInfoDtoModel *dtoModel;
@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, weak)EmptyView *emptyV;
@property (nonatomic, strong)NSMutableArray *items;

@end

@implementation FansGroupListView

+ (void)showList:(FansInfoDtoModel *)dtoModel userId:(int64_t)userId callBack:(FansGroupListCallback)callBack{
    FansGroupListView *fans = [[FansGroupListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 420)];
    fans.userId = userId;
    fans.callBack = callBack;
    fans.dtoModel = dtoModel;
    [fans createUI];
    [FunctionSheetBaseView showView:fans cover:NO];
}

- (void)createUI{
    
    UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    [self addSubview:headerBgV];
    
    UIButton *arrowBtn = [UIButton buttonWithType:0];
    arrowBtn.frame = CGRectMake(10, 0, 30, 30);
    arrowBtn.centerY = headerBgV.height/2.0;
    arrowBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [arrowBtn setImage:[UIImage imageNamed:@"back_fanhui_gray"] forState:UIControlStateNormal];
    arrowBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [arrowBtn addTarget:self action:@selector(arrowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBgV addSubview:arrowBtn];
    
    UILabel *fanNameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, self.width-100, 21)];
    fanNameL.centerX = headerBgV.width/2.0;
    fanNameL.textColor = kRGB_COLOR(@"#333333");
    fanNameL.textAlignment = NSTextAlignmentCenter;
    fanNameL.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
    fanNameL.text = _dtoModel.fansTeamName;
    [headerBgV addSubview:fanNameL];
    
    UILabel *fanNumL = [[UILabel alloc] init];
    fanNumL.textColor = kRGB_COLOR(@"#999999");
    fanNumL.font = [UIFont systemFontOfSize:13];
    fanNumL.attributedText = [[NSString stringWithFormat:kLocalizationMsg(@"%d人"),_dtoModel.fansNum] attachmentForImage:[UIImage imageNamed:@"fans_list_member"] bounds:CGRectMake(0, -2, 15, 15) before:YES];
    [headerBgV addSubview:fanNumL];
    [fanNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fanNameL);
        make.right.equalTo(headerBgV).mas_offset(-15);
    }];
    kWeakSelf(self);
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headerBgV.maxY, self.width, self.height-headerBgV.height) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[FansGroupItemCell class] forCellReuseIdentifier:@"FansGroupItemCell"];
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself getFansList];
    }];
    [self addSubview:tableV];
    _tableV = tableV;
    
    [self getFansList];
}

- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"～暂无粉丝～");
        emptyView.frame = self.tableV.bounds;
        [self.tableV addSubview:emptyView];
        emptyView.hidden = YES;
        _emptyV = emptyView;
    }
    return _emptyV;
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (void)getFansList{
    int pageSize = kPageSize;
    int pageIndex = (int)self.items.count/pageSize + (self.items.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiAPPFinance getFansTeamRank:self.userId pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<RanksDtoModel *> *arr) {
        if (code == 1) {
            [self.tableV.mj_footer endRefreshing];
            if (arr.count > 0) {
                [weakself.items addObjectsFromArray:arr];
            }else{
                [self.tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableV reloadData];
        }else{
            [self.tableV.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        self.emptyV.hidden = weakself.items.count;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FansGroupItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansGroupItemCell" forIndexPath:indexPath];
    cell.userModel = (_items.count > indexPath.row)?_items[indexPath.row]:nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_items.count > indexPath.row) {
        RanksDtoModel *dto = _items[indexPath.row];
        self.callBack(YES, dto.userId);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)arrowBtnClick{
    [FunctionSheetBaseView deletePopView:self];
}


@end
