//
//  AnchorCell.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
@class ApiUsableAnchorRespModel;


NS_ASSUME_NONNULL_BEGIN

@interface AnchorCell : UITableViewCell

@property (weak, nonatomic) KlcAvatarView *iconImgView;
@property (weak, nonatomic) UILabel *nameL;
@property (weak, nonatomic) SWHTapImageView *sexImgView;
@property (weak, nonatomic) UIImageView *level1ImgV;
@property (weak, nonatomic) UIImageView *level2ImgV;
@property (weak, nonatomic) UIButton *linkBtn;



@property (nonatomic, strong)ApiUsableAnchorRespModel *model;

@end

NS_ASSUME_NONNULL_END
