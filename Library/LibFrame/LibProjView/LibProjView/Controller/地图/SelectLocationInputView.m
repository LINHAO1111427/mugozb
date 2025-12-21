//
//  SelectLocationInputView.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SelectLocationInputView.h"
#import <LibProjBase/TXMapManager.h>
#import <CoreLocation/CoreLocation.h>
#import <LibProjBase/HttpClient.h>

@interface SearchLocationItemCell : UITableViewCell
@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UILabel *contentL;
@end

@implementation SearchLocationItemCell
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
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleL];
    self.titleL  = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textColor = [UIColor lightGrayColor];
    contentL.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentL];
    self.contentL  = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}


@end

@interface SelectLocationInputView () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, weak)UISearchBar *searchBar;

@property (nonatomic, strong)NSMutableArray *addressList;

@property (nonatomic, weak)UIView *coverV;

@end

@implementation SelectLocationInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (NSMutableArray *)addressList{
    if (!_addressList) {
        _addressList = [[NSMutableArray alloc] init];
    }
    return _addressList;
}

- (void)setSelectCity:(NSString *)selectCity{
    _selectCity = selectCity;
    
    if ([selectCity hasSuffix:kLocalizationMsg(@"市")]) {
        _selectCity = [selectCity substringToIndex:selectCity.length-1];
    }
}

- (void)keyboardWillNotification:(NSNotification *)notify{
    kWeakSelf(self);
    CGFloat bottomSpace = 0;  ///距离底部的距离
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect keyboardRect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        bottomSpace = keyboardRect.size.height;
    }
    [UIView animateWithDuration:time animations:^{
        weakself.tableV.height = weakself.height-weakself.searchBar.height-bottomSpace;
    } completion:^(BOOL finished) {
    }];
}

- (UIView *)coverV{
    if (!_coverV) {
        UIView *coverV = [[UIView alloc] init];
        [self addSubview:coverV];
        _coverV = coverV;
        [self sendSubviewToBack:coverV];
        coverV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [coverV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        kWeakSelf(self);
        
        [coverV klc_whenTapped:^{
            [weakself searchBarCancelButtonClicked:self.searchBar];
        }];
    }
    return _coverV;
}


- (void)createView{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    searchBar.placeholder = kLocalizationMsg(@"搜索");
    searchBar.delegate = self;
    [self addSubview:searchBar];
    self.searchBar = searchBar;
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, searchBar.maxY, self.width, 1.0) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    tableV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tableV.allowsSelection = YES;
    tableV.tableFooterView = [UIView new];
    tableV.hidden = YES;
    [tableV registerClass:[SearchLocationItemCell class] forCellReuseIdentifier:@"SearchLocationItemCell"];
    [self addSubview:tableV];
    self.tableV = tableV;
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBar.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    kWeakSelf(self);
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself startSearh:NO];
    }];
    tableV.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
}

#pragma mark  - 搜索附近 -
- (void)startSearh:(BOOL)isRefresh{
    if (self.searchBar.text.length == 0) {
        return;
    }
    int pageSize = kPageSize;
    int pageIndex = isRefresh?0:((int)self.addressList.count/pageSize + (self.addressList.count%pageSize?1:0));
    TXMapManager *manager = [TXMapManager shareInstance];
    NSDictionary *param = @{
        @"keyword":self.searchBar.text, ///必填文字
        @"region":self.selectCity,
        @"region_fix":@(1),
        @"page_size":@(pageSize),
        @"page_index":@(pageIndex+1),
        @"key":manager.appkey,
        @"policy": @(0),
    };
    kWeakSelf(self);
    [HttpClient requestGETWithPath:@"https://apis.map.qq.com/ws/place/v1/suggestion" Param:param success:^(id  _Nonnull dataBody) {
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


#pragma mark <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchLocationItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchLocationItemCell" forIndexPath:indexPath];
    if (self.addressList.count > indexPath.row) {
        NSDictionary *infoAddress = self.addressList[indexPath.row];
        cell.titleL.text = infoAddress[@"title"];
        cell.contentL.text = infoAddress[@"address"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.addressList.count > indexPath.row) {
        
        NSDictionary *locationDic = self.addressList[indexPath.row];
        if ([locationDic[@"type"] intValue] == 0 || [locationDic[@"type"] intValue] == 1 || [locationDic[@"type"] intValue] == 2) {
            
            tableView.hidden = YES;
            
            LocationInfoModel *selectLocationInfo = [[LocationInfoModel alloc] init];
            
            NSDictionary *location = locationDic[@"location"];

            selectLocationInfo.coordinate = CLLocationCoordinate2DMake([location[@"lat"] doubleValue],[location[@"lng"] doubleValue]);
            selectLocationInfo.name = locationDic[@"title"];
            selectLocationInfo.address = locationDic[@"address"];
            selectLocationInfo.city = locationDic[@"city"];
            selectLocationInfo.province = locationDic[@"province"];
            
            if (self.selectLocationBlock) {
                self.selectLocationBlock(selectLocationInfo);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择明确地点")];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate -
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    self.coverV.hidden = NO;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
        }
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length) {
        self.tableV.hidden = NO;
        [self startSearh:YES];
    }else{
        
        self.tableV.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    self.tableV.hidden = self.coverV.hidden = YES;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}


@end
