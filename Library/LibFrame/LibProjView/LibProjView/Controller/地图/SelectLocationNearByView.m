//
//  SelectLocationNearByView.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SelectLocationNearByView.h"
#import <LibProjBase/TXMapManager.h>
#import <CoreLocation/CoreLocation.h>
#import <LibProjBase/HttpClient.h>

@interface SelectNearbyLocationCell : UITableViewCell
@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UILabel *contentL;
@property (nonatomic, weak)UIImageView *selectImgV;
@end

@implementation SelectNearbyLocationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}


- (void)createUI{
    
    UIImageView *selectImgV = [[UIImageView alloc] init];
    selectImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:selectImgV];
    self.selectImgV = selectImgV;
    [selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleL];
    self.titleL  = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(selectImgV.mas_left).offset(-5);
    }];
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textColor = [UIColor lightGrayColor];
    contentL.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentL];
    self.contentL  = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(selectImgV.mas_left).offset(-5);
    }];
}


@end


@interface SelectLocationNearByView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *addressList;

@property (nonatomic, assign)NSInteger selectIndex;

@end

@implementation SelectLocationNearByView

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (NSMutableArray *)addressList{
    if (!_addressList) {
        _addressList = [[NSMutableArray alloc] init];
    }
    return _addressList;
}

- (void)searchLocation:(CLLocationCoordinate2D)cc2d {
    self.currentCC2d = cc2d;
    [self.tableV.mj_footer endRefreshing];
    [self reloadAroundLocation:YES];
}

- (void)reloadAroundLocation:(BOOL)isRefresh{
    int pageSize = kPageSize;
    int pageIndex = isRefresh?0:((int)self.addressList.count/pageSize + (self.addressList.count%pageSize?1:0));
    NSDictionary *param = @{
        @"boundary":[NSString stringWithFormat:@"nearby(%f,%f,1000,1)",self.currentCC2d.latitude,self.currentCC2d.longitude],
        @"page_size":@(pageSize),
        @"page_index":@(pageIndex+1),
        @"key":[TXMapManager shareInstance].appkey,
        @"orderby": @"_distance"
    };
    kWeakSelf(self);
    [HttpClient requestGETWithPath:@"https://apis.map.qq.com/ws/place/v1/explore" Param:param success:^(id  _Nonnull dataBody) {
        [weakself.tableV.mj_footer endRefreshing];
        
        NSArray *dataArr = dataBody[@"data"];
        if (isRefresh) {
            [weakself.addressList removeAllObjects];
        }
        [weakself.addressList addObjectsFromArray:dataArr];
        
        if (dataArr.count == 0) {
            [weakself.tableV.mj_footer endRefreshingWithNoMoreData];
        }
        [weakself.tableV reloadData];
    } failed:^(NSString * _Nonnull error) {
        [weakself.tableV.mj_footer endRefreshing];
        
    }];
}



- (void)createUI{
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30)];
    titleL.text = kLocalizationMsg(@"附近地点");
    titleL.textColor = [UIColor lightGrayColor];
    titleL.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleL];
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2.0) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    tableV.allowsSelection = YES;
    tableV.tableFooterView = [UIView new];
    [tableV registerClass:[SelectNearbyLocationCell class] forCellReuseIdentifier:@"SelectNearbyLocationCell"];
    [self addSubview:tableV];
    self.tableV = tableV;
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    kWeakSelf(self);
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself reloadAroundLocation:NO];
    }];
    tableV.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectNearbyLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectNearbyLocationCell" forIndexPath:indexPath];
    if (self.addressList.count > indexPath.row) {
        NSDictionary *infoAddress = self.addressList[indexPath.row];
        cell.titleL.text = infoAddress[@"title"];
        cell.contentL.text = infoAddress[@"address"];
        if (self.selectIndex) {
            cell.selectImgV.image = [UIImage imageNamed:( (self.selectIndex-1) == indexPath.row )?@"shortVideo_privateBtn_sel":@"shortVideo_privateBtn_normal"];
        }else{
            cell.selectImgV.image = [UIImage imageNamed:@"shortVideo_privateBtn_normal"];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addressList.count > indexPath.row) {
        self.selectIndex = (indexPath.row+1);
        [tableView reloadData];
        
        if (self.selectLocationBlock) {
            
            NSDictionary *locationDic = self.addressList[indexPath.row];
            LocationInfoModel *selectLocationInfo = [[LocationInfoModel alloc] init];
            
            NSDictionary *location = locationDic[@"location"];
            NSDictionary *ad_info = locationDic[@"ad_info"];
            
            selectLocationInfo.coordinate = CLLocationCoordinate2DMake([location[@"lat"] doubleValue],[location[@"lng"] doubleValue]);
            selectLocationInfo.name = locationDic[@"title"];
            selectLocationInfo.address = locationDic[@"address"];
            selectLocationInfo.city = ad_info[@"city"];
            selectLocationInfo.province = ad_info[@"province"];

            self.selectLocationBlock(selectLocationInfo);
        }
    }
}

@end
