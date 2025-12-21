//
//  ShowLocationVC.m
//  LibProjView
//
//  Created by klc_sl on 2021/7/15.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShowLocationVC.h"
#import <QMapKit/QMapKit.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/TXMapManager.h>

@interface ShowLocationVC ()<QMapViewDelegate>

@property (nonatomic, weak)QMapView *mapView;

@end

@implementation ShowLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"位置");
    [self createUI];
}

- (void)createUI{
    QMapView *mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    mapView.delegate = self;
//    mapView.showsUserLocation = YES;
    [mapView setZoomLevel:16.0];
    mapView.scrollEnabled = YES;
    mapView.zoomEnabled = YES;
    mapView.showsScale = NO;
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
    self.mapView = mapView;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
    [mapView setCenterCoordinate:coordinate animated:NO];
    
    
    QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
    // 点标注的标题
    pointAnnotation.title = self.name;
    // 副标题
    pointAnnotation.subtitle = self.address;
    // 将点标记添加到地图中
    [self.mapView addAnnotation:pointAnnotation];
    
}

#pragma mark-QMapViewDelegate

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated gesture:(BOOL)bGesture {
    CLLocationCoordinate2D cc2d = mapView.centerCoordinate;
    [self reverCodeWith:cc2d];
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



/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation{

    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString *annotationIdentifier = @"pointAnnotation";
        QPinAnnotationView *pinView = (QPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (pinView == nil) {
            pinView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            pinView.canShowCallout = YES;
//            pinView.image = [UIImage imageNamed:@"map_location_needle"];
        }
        return pinView;
    }
    
    return nil;
}

///**
// * @brief 根据anntationView生成对应的CustomCallout (当标注被选中后会调用)
// * @param mapView 地图View
// * @param annotationView 指定的标注view
// * @return 对应的CustomCallout
// */
//- (UIView *)mapView:(QMapView *)mapView customCalloutForAnnotationView:(QAnnotationView *)annotationView{
//    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    bgV.backgroundColor = [UIColor redColor];
//    return bgV;
//}


@end
