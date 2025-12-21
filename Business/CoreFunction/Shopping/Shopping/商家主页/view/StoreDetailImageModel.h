//
//  StoreDetailImageModel.h
//  Shopping
//
//  Created by yww on 2020/8/12.
//  Copyright © 2020 klc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LibProjModel/ShopBusinessModel.h>
NS_ASSUME_NONNULL_BEGIN
 

@interface StoreDetailImageModel : NSObject
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, strong)UIImageView *imageV;
@end




@interface StoreDetailSectionModel : NSObject
@property (nonatomic, assign)int section;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)ShopBusinessModel *model;
@property (nonatomic, strong)NSArray<StoreDetailImageModel *> *images;
@end
NS_ASSUME_NONNULL_END
