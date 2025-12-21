//
//  DynamicPhotoView.h
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrowserPhotoView : UIView

//默认不显示大图
@property (nonatomic, assign)BOOL isShowBig;

//默认显示网络数据
@property (nonatomic, assign)BOOL isAdd;





/// 显示图片 imgArr 图片数组
@property (nonatomic, copy)NSArray *imageArr;





/// index  点击第一个图片
@property (nonatomic, copy)void (^selectPhoto) (BOOL isAdd, NSInteger index);

/// 删除某一张图片
@property (nonatomic, copy) void (^deleteBtnClick)(int index);


@end

NS_ASSUME_NONNULL_END
