//
//  DynamicShowPhotoView.h
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicShowPhotoView : UIView

//默认不显示大图
@property (nonatomic, assign)BOOL isShowBig;


/// 显示图片 imgArr 图片数组
@property (nonatomic, copy)NSArray *imageArr;

@end

NS_ASSUME_NONNULL_END
