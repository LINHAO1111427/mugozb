//
//  ShoppingAddressModel.h
//  LibProjView
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
 
///县区
@interface SACountyModel : NSObject
@property (nonatomic, assign)int areaId;
@property (nonatomic, copy)NSString *areaName;
@end
///地区 分区
@interface SARegionModel : NSObject
@property (nonatomic, assign)int areaId;
@property (nonatomic, copy)NSString *areaName;
@property (nonatomic, strong)NSArray *counties;
@end
///省市
@interface SAProvinceModel : NSObject
@property (nonatomic, assign)int areaId;
@property (nonatomic, copy)NSString *areaName;
@property (nonatomic, strong)NSArray *cities;
@end

///选中的地址
@interface SASelctedModel : NSObject
@property (nonatomic, assign)int areaId_one;
@property (nonatomic, copy)NSString *areaName_one;
@property (nonatomic, assign)int areaId_two;
@property (nonatomic, copy)NSString *areaName_two;
@property (nonatomic, assign)int areaId_three;
@property (nonatomic, copy)NSString *areaName_three;
@end

 
NS_ASSUME_NONNULL_END

