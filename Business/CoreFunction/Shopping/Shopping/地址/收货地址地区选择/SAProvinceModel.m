//
//  ShoppingAddressModel.m
//  LibProjView
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 . All rights reserved.
//

#import "SAProvinceModel.h"
#import <MJExtension/MJExtension.h>

@implementation SACountyModel

@end

@implementation SARegionModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"counties":@"SACountyModel"};
}
@end
@implementation SAProvinceModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"cities":@"SARegionModel"};
}
@end

@implementation SASelctedModel
 
@end

 
  

