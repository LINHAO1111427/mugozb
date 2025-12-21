//
//  LocationViewController.m
//  LibProjView
//
//  Created by klc on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "LocationView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/TXMapManager.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/HttpClient.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <QMapKit/QMapKit.h>
#import <SDWebImage.h>
#import "MapResultTableViewCell.h"

@interface LocationView()<QMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) QMapView *mapView;

@property (nonatomic, copy) locationResultBack callBack;

@property (nonatomic, assign) BOOL isNotAutoAnimation;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isShowList;
@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic,strong)UIButton *locationBtn;

@end

@implementation LocationView

- (void)dealloc
{
   // NSLog(@"过滤文字%s"), __func__);
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (void)showInView:(UIView *)superView callBack:(locationResultBack)callBack{
    if (!superView) {
        return;
    }
    if (KLCUserInfo.getLat > 0 && KLCUserInfo.getLng > 0) {
        self.userLocation = CLLocationCoordinate2DMake(KLCUserInfo.getLat, KLCUserInfo.getLng);
    }
    self.callBack = callBack;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [superView addSubview:self];
    [self createUI];
    [self reSingleLocation];
    if (self.isNotAutoAnimation) {
        [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        } completion:nil];
    }
}

///重新定位
-(void)reSingleLocation{
    ///如果之前定位过，则重新定位
    if ([KLCUserInfo.getCity length]>0) [self locationBtnClick:_locationBtn];
}
- (void)createUI{
    self.mapView = [[QMapView alloc] initWithFrame:self.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setZoomLevel:16.01];
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.showsScale = NO;
    [self addSubview:self.mapView];
    [self addTitleView];
    [self addUserView];
    [self addSearchView];
    if (self.userLocation.latitude > 0 && self.userLocation.longitude > 0) {
        [self.mapView setCenterCoordinate:self.userLocation animated:NO];
    }
}


- (void)addTitleView{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(60, kStatusBarHeight+(kNavBarHeight-kStatusBarHeight-34)/2.0, kScreenWidth-120, 34)];
    titleView.backgroundColor = kRGBA_COLOR(@"#FFFFFF", 0.8);
    titleView.layer.cornerRadius = 17;
    titleView.clipsToBounds = YES;
    [self insertSubview:titleView atIndex:3];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, 32, 32)];
    [backbtn setImage:[UIImage imageNamed:@"map_back"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backbtn.centerY = titleView.centerY;
    [self addSubview:backbtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, kScreenWidth-120, 20)];
    titleLabel.textColor = kRGB_COLOR(@"#2B2C2C");
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [titleView addSubview:self.titleLabel];
    
    UIButton *locationSearchBtn = [[UIButton alloc]initWithFrame:titleView.bounds];
    locationSearchBtn.backgroundColor = [UIColor clearColor];
    [locationSearchBtn addTarget:self action:@selector(locationSearchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:locationSearchBtn];
    
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-52, kScreenHeight-kSafeAreaBottom-60, 40, 40)];
    locationBtn.layer.cornerRadius = 20;
    locationBtn.clipsToBounds = YES;
    [locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [locationBtn setImage:[UIImage imageNamed:@"map_location"] forState:UIControlStateNormal];
    _locationBtn = locationBtn;
    [self insertSubview:locationBtn atIndex:1];
    
}

- (void)addUserView{
    UIButton *userBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2.0, kScreenHeight/2.0-80, 60, 80)];
    userBtn.backgroundColor = [UIColor clearColor];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"map_user_location_bg"] forState:UIControlStateNormal];
    self.userBtn = userBtn;
    [self insertSubview:self.userBtn atIndex:1];
    
    UIImageView *userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    userImageView.layer.cornerRadius = 25;
    userImageView.clipsToBounds = YES;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:KLCUserInfo.getAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    [self.userBtn addSubview:userImageView];
}

- (void)addSearchView{
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight+45)];
    searchView.hidden = YES;
    searchView.backgroundColor = [UIColor whiteColor];
    self.searchView = searchView;
    [self insertSubview:self.searchView atIndex:2];
    
    UIView *textV = [[UIView alloc]initWithFrame:CGRectMake(20, kStatusBarHeight+(kNavBarHeight-kStatusBarHeight-34)/2.0+45, kScreenWidth-40, 34)];
    textV.backgroundColor = kRGB_COLOR(@"#F2F2F2");
    textV.layer.cornerRadius = 17;
    textV.clipsToBounds = YES;
    [searchView addSubview:textV];
    
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-60, 34)];
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.textColor = kRGB_COLOR(@"#2B2C2C");
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.placeholder = kLocalizationMsg(@"搜索地点");
    searchTextField.delegate = self;
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    leftImg.image = [UIImage imageNamed:@"map_search"];
    searchTextField.leftView = leftImg;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField = searchTextField;
    [textV addSubview:self.searchTextField];
    [self.searchView addSubview:self.tableView];
}

- (void)updateTitleView{
    if (!self.address) {
        return;
    }
    NSMutableAttributedString *attr  = [[NSMutableAttributedString alloc]initWithString:self.address];
    //箭头
    NSTextAttachment *attchmentA = [[NSTextAttachment alloc]init];
    attchmentA.bounds = CGRectMake(0, -3, 15, 15);//设置frame
    if (self.isShowList) {
        attchmentA.image = [UIImage imageNamed:@"map_location_up"];
    }else{
        attchmentA.image = [UIImage imageNamed:@"map_location_down"];
    }
    NSAttributedString *imgA= [NSAttributedString attributedStringWithAttachment:attchmentA];
    [attr insertAttributedString:imgA atIndex:attr.length];
    
    NSTextAttachment *attchmentB = [[NSTextAttachment alloc]init];
    attchmentB.bounds = CGRectMake(0, -3, 15, 15);//设置frame
    attchmentB.image = [UIImage imageNamed:@"userInfo_location"];
    NSAttributedString *imgB= [NSAttributedString attributedStringWithAttachment:attchmentB];
    [attr insertAttributedString:imgB atIndex:0];
    self.titleLabel.attributedText = attr;
}
- (void)locationSearchBtnClick:(UIButton *)btn{
    self.isShowList = !self.isShowList;
    if (self.isShowList) {
        [self.searchArray removeAllObjects];
        [self startSearh:self.name.length > 0?self.name:KLCUserInfo.getCity];
    }
    [self updateTitleView];
    self.searchView.hidden = !self.isShowList;
    [self.searchArray removeAllObjects];
    self.searchTextField.text = @"";
    [self.searchTextField resignFirstResponder];
    
}
- (void)backbtnClick:(UIButton *)btn{
    [self closeViewNow];
}
- (void)locationBtnClick:(UIButton *)btn{
    self.mapView.zoomLevel = 16.01;
    kWeakSelf(self);
    [self.searchTextField resignFirstResponder];
    [[TXMapManager shareInstance] startSingleLocation:^(BOOL success, LocationInfoModel * _Nonnull infoModel) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.mapView setCenterCoordinate:infoModel.coordinate animated:NO];
            });
            [weakself showAddressInfo:infoModel.coordinate name:infoModel.name city:infoModel.city];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"定位失败")];
        }
    }];
}

- (void)showAddressInfo:(CLLocationCoordinate2D)corrdinate2d name:(NSString *)name city:(NSString *)city{
    self.userLocation = corrdinate2d;
    if ([city hasSuffix:kLocalizationMsg(@"市")]) {
        city =[city substringToIndex:city.length-1];
    }
    self.address = name;
    self.city = city;
    self.name = name;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTitleView];
    });
}


- (void)closeViewNow{
    NSString *city = self.city;
    if ([city hasSuffix:kLocalizationMsg(@"市")]) {
        self.city =[city substringToIndex:city.length-1];
    }
    self.callBack(NO, self.city, self.userLocation.latitude, self.userLocation.longitude, self.address);
    
    if (!self.isNotAutoAnimation) {
        [UIView animateWithDuration:0.3f animations:^{
            [self setFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        } completion:^(BOOL finished) {
            [self removeAllSubViews];
            [self removeFromSuperview];
        }];
    }
    
}


#pragma mark-QMapViewDelegate
- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated gesture:(BOOL)bGesture {
    CLLocationCoordinate2D location = mapView.centerCoordinate;
    [self reverCodeWith:location];
    [self.searchTextField resignFirstResponder];
}

//反编码
- (void)reverCodeWith:(CLLocationCoordinate2D)locate{
    kWeakSelf(self);
    [[TXMapManager shareInstance] ReverseGeocoderWith:locate completeResult:^(BOOL success, LocationInfoModel * _Nullable infoModel) {
        if (success) {
            [weakself showAddressInfo:infoModel.coordinate name:infoModel.name city:infoModel.city];
        }else{
           // NSLog(@"过滤文字********反地理失败**********"));
            return ;
        }
    }];
}

- (void)mapViewWillStartLocatingUser:(QMapView *)mapView{
    //获取开始定位的状态
   // NSLog(@"过滤文字mapViewWillStartLocatingUser"));
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView{
    //获取停止定位的状态
   // NSLog(@"过滤文字mapViewDidStopLocatingUser"));
}

- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    //刷新位置
   // NSLog(@"过滤文字didUpdateUserLocation"));
}
#pragma mark-tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MapResultTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MapResultTableViewCell alloc]initWithIndexpath:indexPath];
    }
    if (indexPath.row < self.searchArray.count) {
        NSDictionary *dic = self.searchArray[indexPath.row];
        cell.infoAddress = dic;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.searchArray.count) {
        NSDictionary *dic = self.searchArray[indexPath.row];
        double lat = [dic[@"location"][@"lat"] doubleValue];
        double lng = [dic[@"location"][@"lng"] doubleValue];
        CLLocationCoordinate2D locate = CLLocationCoordinate2DMake(lat, lng);
        [self.mapView setCenterCoordinate:locate animated:NO];
        [self locationSearchBtnClick:nil];
        [self.searchTextField resignFirstResponder];
        [self reverCodeWith:locate];
    }
}
#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self startSearh:str];
    return YES;
}
- (void)startSearh:(NSString *)str{
    TXMapManager *manager = [TXMapManager shareInstance];
    NSDictionary *param = @{
        @"keyword":str.length > 0?str:@"",
        @"boundary":[NSString stringWithFormat:@"nearby(%f,%f,100000,1)",self.userLocation.latitude,self.userLocation.longitude],
        @"page_size":@(20),
        @"key":manager.appkey,
        @"orderby": @"_distance"
    };
    kWeakSelf(self);
    [HttpClient requestGETWithPath:@"https://apis.map.qq.com/ws/place/v1/search" Param:param success:^(id  _Nonnull dataBody) {
       // NSLog(@"过滤文字dataBdy == %@"),dataBody);
        NSArray *dataArr = dataBody[@"data"];
        [weakself.searchArray removeAllObjects];
        [weakself.searchArray addObjectsFromArray:dataArr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakself.searchArray.count *50>(kScreenHeight/2.0-kNavBarHeight-45)) {
                weakself.searchView.height = kScreenHeight/2.0;
                
            }else{
                weakself.searchView.height = weakself.searchArray.count *50+kNavBarHeight+45 ;
            }
            weakself.tableView.frame = CGRectMake(0, kNavBarHeight+45, kScreenWidth, weakself.searchView.height-kNavBarHeight-45);
            [weakself.tableView reloadData];
        });
        
    } failed:^(NSString * _Nonnull error) {
    }];
}


@end



@implementation SelectLocationToMapVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    kWeakSelf(self);
    self.navigationController.navigationBarHidden = YES;
    LocationView *locationV = [[LocationView alloc] init];
    locationV.isNotAutoAnimation = YES;
    [locationV showInView:self.view callBack:^(BOOL cancel, NSString * _Nonnull city, double lat, double lng, NSString * _Nonnull address) {
        
        [weakself.navigationController popViewControllerAnimated:YES];
        weakself.selectBlock?weakself.selectBlock(cancel, city, lat, lng, address):nil;
        
    }];
    
}

@end
