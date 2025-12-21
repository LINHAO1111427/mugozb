//
//  TiUIMeiZhuangViewCell.m
//  TiFancy
//
//  Created by MBP DA1003 on 2019/8/3.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import "TiUIMeiZhuangViewCell.h"
#import "TIButton.h"
#import "TIUITool.h"


@interface TiUIMeiZhuangViewCell ()

@property(nonatomic ,strong)TIButton *cellButton;

@end

@implementation TiUIMeiZhuangViewCell

-(TIButton *)cellButton{
    if (_cellButton==nil) {
        _cellButton = [[TIButton alloc]initWithScaling:0.9];
        _cellButton.userInteractionEnabled = NO;
        [_cellButton setDownloadViewFrame:downloadViewFrame_equalToImage];
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.cellButton];
        [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];

    }
    return self;
}

- (void)setSubMod:(TIMenuMode *)subMod
{
    if (subMod) {
    _subMod = subMod;
    
        if (subMod.menuTag) {
            WeakSelf;
            NSString *iconUrl =[TiSDK getMakeupIconURL];
            NSString *folder = @"makeup_icon";
           
            iconUrl = iconUrl?iconUrl:@"";
            [TIUITool getImageFromeURL:[NSString stringWithFormat:@"%@%@", iconUrl, subMod.thumb] WithFolder:folder downloadComplete:^(UIImage *image) {

                          [weakSelf.cellButton setTitle:subMod.dir
                                               withImage:image
                                           withTextColor:TI_Color_Default_Text_Black
                                                forState:UIControlStateNormal];

                           [weakSelf.cellButton setTitle:subMod.dir
                                               withImage:image
                                           withTextColor:TI_Color_Default_Background_Pink
                                                forState:UIControlStateSelected];
                   }];
            
            switch (subMod.downloaded) {
                case TI_DOWNLOAD_STATE_CCOMPLET://完成
                    [self endAnimation];
                    [self.cellButton setDownloaded:YES];
                    
                        break;
                    case TI_DOWNLOAD_STATE_NOTBEGUN://未开始
                    
                    [self endAnimation];
                    [self.cellButton setDownloaded:NO];
                    
                        break;
                    case TI_DOWNLOAD_STATE_BEBEING://正在
                    
                      [self startAnimation];
                      [self.cellButton setDownloaded:YES];
                        break;
                default:
                    break;
            }
            
            
        }else{

            
            [self.cellButton setTitle:subMod.dir
                            withImage:[UIImage imageNamed:subMod.normalThumb]
                        withTextColor:TI_Color_Default_Text_Black
                             forState:UIControlStateNormal];
                                 
            [self.cellButton setTitle:subMod.dir
                            withImage:[UIImage imageNamed:subMod.selectedThumb]
                        withTextColor:TI_Color_Default_Background_Pink
                             forState:UIControlStateSelected];
            [self endAnimation];
            [self.cellButton setDownloaded:YES];
        }
        
        [self.cellButton setSelected:subMod.selected];
    }
}

-(void)startAnimation{
    [self.cellButton startAnimation];
}
-(void)endAnimation{
    [self.cellButton endAnimation];
}




-(void)setCellTypeBorderIsShow:(BOOL)show{
   
    if (show) {
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:1.f BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
    }else{
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:0.f BorderColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
       
}


@end
