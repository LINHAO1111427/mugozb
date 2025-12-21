//
//  CitySelecteView.h
//  LibProjView
//
//  Created by ssssssss on 2020/1/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    CitySelecteTypeNearby,
    CitySelecteTypeSquare
}CitySelecteType;

typedef void(^citySelectedCallBack)(BOOL cancel,NSString *_Nullable city,NSString *_Nullable gender,NSArray *_Nullable tags);

@interface CitySelecteView : UIView

- (void)showInView:(UIView*) view withType:(CitySelecteType)viewType callBack:(citySelectedCallBack)callBack;


- (void)showInView:(UIView*)view withType:(CitySelecteType)viewType andSetSeleCityName:(NSString *)cityName andGenderStr:(NSString *)genderStr andTagsArr:(NSArray *)TagsArr callBack:(citySelectedCallBack)callBack;

@end

NS_ASSUME_NONNULL_END
