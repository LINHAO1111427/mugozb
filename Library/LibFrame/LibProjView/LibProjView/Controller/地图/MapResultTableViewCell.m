//
//  MapResultTableViewCell.m
//  LibProjView
//
//  Created by klc on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//

#import "MapResultTableViewCell.h"
#import <LibTools/LibTools.h>
#import <CoreLocation/CoreLocation.h>
 
@interface MapResultTableViewCell()
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation MapResultTableViewCell
- (instancetype)initWithIndexpath:(NSIndexPath *)indexPath{
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
        [self viewSetUp];
    }
    return self;
}
- (void)viewSetUp{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, kScreenWidth-24, 20)];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textColor = kRGB_COLOR(@"#333333");
    self.titlelabel = titlelabel;
    [self.contentView addSubview:self.titlelabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 25, kScreenWidth-24, 20)];
    contentLabel.textColor = kRGB_COLOR(@"#999999");
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel = contentLabel;
    [self.contentView addSubview:self.contentLabel];
    
}
- (void)setInfoAddress:(NSDictionary *)infoAddress{
    _infoAddress = infoAddress;
    NSString *district = infoAddress[@"ad_info"][@"district"];
    NSString *title = infoAddress[@"title"];
    NSString *distance = infoAddress[@"_distance"];
    /*
    double lat = [infoAddress[@"location"][@"lat"] doubleValue];
    double lng = [infoAddress[@"location"][@"lng"] doubleValue];
    double distence = [self distanceBetweenOrderBy:CLLocationCoordinate2DMake(lat, lng)];
     */
    self.titlelabel.text = title;
    self.contentLabel.text = [NSString stringWithFormat:@"%.2fKm|%@",[distance floatValue]/1000,district];
}
//-(double)distanceBetweenOrderBy:(CLLocationCoordinate2D)locate{
//
//    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:locate.latitude longitude:locate.longitude];
//    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:self.userLocation.latitude longitude:self.userLocation.longitude];
//    double  distance  = [curLocation distanceFromLocation:otherLocation];
//    return  distance;
//}
 
@end
