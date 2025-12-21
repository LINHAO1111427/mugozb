//
//  ShowMsgPictureView.h
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowMsgPictureView : UIView

@property (nonatomic, weak)UIImageView *imgV;

@property (nonatomic, weak)UIView *coverV;

@property (nonatomic, weak)UIView *tempTransformV;

@property (nonatomic, weak)UIView *animationV;

@property (nonatomic, assign)CGRect oldframe;;


@property(nonatomic, copy)void(^showBlock)(BOOL);


+ (void)showOncePic:(UIView *)origin isOwner:(BOOL)isOwner picUrl:(NSString *)picUrl showBlock:(void(^_Nullable)(BOOL look))block;

+ (void)showImage:(UIView *)origin picUrl:(NSString *)picUrl;

@end

NS_ASSUME_NONNULL_END
