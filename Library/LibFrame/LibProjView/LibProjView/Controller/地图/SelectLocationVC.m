//
//  SelectLocationVC.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SelectLocationVC.h"
#import <QMapKit/QMapKit.h>
#import "SelectLocationInputView.h"
#import "SelectLocationNearByView.h"
#import <LibProjBase/TXMapManager.h>
#import <LibProjBase/HttpClient.h>
#import <LibProjBase/LocationInfoModel.h>

@interface SelectLocationVC () <QMapViewDelegate>

@property (nonatomic, weak)QMapView *mapView;

@property (nonatomic, weak)SelectLocationNearByView *nearByView;

@property (nonatomic, weak)SelectLocationInputView *inputView;

@property (nonatomic, weak)UIButton *userLocationBtn;

@property (nonatomic, strong)LocationInfoModel *selectLocationInfo;

@end

@implementation SelectLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf(self);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"确认") bgColor:[UIColor clearColor] textColor:[UIColor blackColor] clickHandle:^{
        [weakself sureSelectLocation];
    }]];
    [self createBaseView];
}

- (void)sureSelectLocation{
    if (![self.selectLocationInfo.city isEqualToString:self.selectCity]) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:kLocalizationMsg(@"请选择%@内"),self.selectCity]];
        return;
    }
    if (self.sureLocationBlock) {
        self.sureLocationBlock(self.selectLocationInfo);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createBaseView{
    kWeakSelf(self);
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat searchBarHeight = 50;
    SelectLocationInputView *inputView = [[SelectLocationInputView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    inputView.selectLocationBlock = ^(LocationInfoModel * _Nonnull selectLocation) {
        weakself.selectLocationInfo = selectLocation;
        [weakself sureSelectLocation];
    };
    inputView.selectCity = self.selectCity;
    [self.view addSubview:inputView];
    self.inputView = inputView;
    
    QMapView *mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, searchBarHeight, kScreenWidth, (kScreenHeight-kNavBarHeight-searchBarHeight)/2.0)];
    mapView.delegate = self;
//    mapView.showsUserLocation = YES;
    [mapView setZoomLevel:16.0];
    mapView.scrollEnabled = YES;
    mapView.zoomEnabled = YES;
    mapView.showsScale = NO;
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
    self.mapView = mapView;
    
    SelectLocationNearByView *nearbyView = [[SelectLocationNearByView alloc] init];
    nearbyView.selectLocationBlock = ^(LocationInfoModel * _Nonnull selectLocation) {
        weakself.selectLocationInfo = selectLocation;
    };
    [self.view addSubview:nearbyView];
    [self.view sendSubviewToBack:nearbyView];
    self.nearByView = nearbyView;
    [nearbyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mapView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self addUserView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([KLCUserInfo getLat], [KLCUserInfo getLng]);
    [mapView setCenterCoordinate:coordinate animated:NO];
    
}

- (void)addUserView{
    UIButton *userBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
    userBtn.center = CGPointMake(self.mapView.center.x, self.mapView.center.y-40);
    userBtn.backgroundColor = [UIColor clearColor];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"map_user_location_bg"] forState:UIControlStateNormal];
    self.userLocationBtn = userBtn;
    [self.view insertSubview:userBtn aboveSubview:self.mapView];
    
    UIImageView *userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    userImageView.layer.cornerRadius = 25;
    userImageView.clipsToBounds = YES;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:KLCUserInfo.getAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    [userBtn addSubview:userImageView];
}


#pragma mark-QMapViewDelegate

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated gesture:(BOOL)bGesture {
    CLLocationCoordinate2D cc2d = mapView.centerCoordinate;
    [self reverCodeWith:cc2d];
    [self.nearByView searchLocation:cc2d];
}

//反编码
- (void)reverCodeWith:(CLLocationCoordinate2D)locate{
    //    kWeakSelf(self);
    [[TXMapManager shareInstance] ReverseGeocoderWith:locate completeResult:^(BOOL success, LocationInfoModel * _Nullable infoModel) {
        if (success) {
            //            [weakself showAddressInfo:infoModel.coordinate name:infoModel.name city:infoModel.city];
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


@end
