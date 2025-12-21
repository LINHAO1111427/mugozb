//
//  TiUIMeiZhuangView.m
//  TiFancy
//
//  Created by MBP DA1003 on 2019/8/1.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import "TiUIMeiZhuangView.h"
#import "TIConfig.h"
#import "TIButton.h"
#import "TiUIMeiZhuangViewCell.h"
#import "TIDownloadZipManager.h"


static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMeiZhuangViewCellId";
@interface TiUIMeiZhuangView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)TIButton *totalSwitch;
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong) UICollectionView *menuCollectionView;

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;

//添加退出手势的View
@property(nonatomic, strong) UIView *exitTapView;
@property(nonatomic, strong) UIWindow *window;

@end

@implementation TiUIMeiZhuangView

-(UIView *)exitTapView{
    if (_exitTapView ==nil) {
        _exitTapView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH,SCREEN_HEIGHT - TiUIViewBoxTotalHeight )];
        _exitTapView.hidden = NO;
//        _exitTapView.backgroundColor = [UIColor redColor];
        _exitTapView.userInteractionEnabled = YES;
        [_exitTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onExitTap1:)]];
    }
    return _exitTapView;
}
 

-(UIWindow *)window{
    if (_window==nil) {
        _window = [self lastWindow];
    }
    return _window;
}
// MARK: --退出手势相关--
- (void)onExitTap1:(UITapGestureRecognizer *)recognizer {
    [self setHiddenAnimation:YES];
}


-(TIButton *)totalSwitch{
    if (_totalSwitch==nil) {
        _totalSwitch = [[TIButton alloc]initWithScaling:0.9];
        [_totalSwitch addTarget:self action:@selector(backParentMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _totalSwitch;
}

-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = TI_Color_Default_Text_Black;
    }
    return _lineView;
}

-(UICollectionView *)menuCollectionView{
    if (_menuCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(TiUISubMenuOneViewTIButtonWidth, TiUISubMenuOneViewTIButtonHeight);
//        // 设置最小行间距
        layout.minimumLineSpacing = 15;
        
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor whiteColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        [_menuCollectionView registerClass:[TiUIMeiZhuangViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
    }
    return _menuCollectionView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0;
       [self addSubview:self.totalSwitch];
       [self addSubview:self.lineView];
       
       [self addSubview:self.menuCollectionView];
        
        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        
       [self.totalSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.mas_centerY).with.offset(-safeBottomHeigh);
           make.left.equalTo(self.mas_left).offset(35);
           make.width.mas_equalTo(TiUISubMenuOneViewTIButtonWidth-12);
           make.height.mas_equalTo(TiUISubMenuOneViewTIButtonHeight);
       }];
       [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.mas_centerY).with.offset(-safeBottomHeigh);
           make.left.equalTo(self.totalSwitch.mas_right).offset(20);
           make.width.mas_equalTo(0.25);
           make.height.mas_equalTo(TiUISubMenuOneViewTIButtonHeight);
       }];
        
       [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.mas_centerY).with.offset(-safeBottomHeigh);
           make.left.equalTo(self.lineView.mas_right).offset(25);
           make.right.equalTo(self.mas_right).offset(-20);
           make.height.mas_equalTo(TiUISubMenuOneViewTIButtonHeight);
       }];
    }
    
    
    return self;
}

//获取到当前所在的视图

 - (UIWindow *)lastWindow
 {
 NSArray *windows = [UIApplication sharedApplication].windows;
 for(UIWindow *window in [windows reverseObjectEnumerator]) {
 if ([window isKindOfClass:[UIWindow class]] &&
 CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
 return window;
 }
 return [UIApplication sharedApplication].keyWindow;
 }

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.mode.menuTag) {
            case 1:
                return [TIMenuPlistManager shareManager].cheekRedModArr.count;
            break;
            case 2:
                       return [TIMenuPlistManager shareManager].cheekRedModArr.count;
                       break;
            case 3:
                       return [TIMenuPlistManager shareManager].cheekRedModArr.count;
                       break;
            
        default:
            return 0;
            break;
    }
    

}
  
 
   
 //返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   TiUIMeiZhuangViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    
    [cell setCellTypeBorderIsShow:indexPath.row!=0];
    TIMenuMode * subMod =nil;
    switch (self.mode.menuTag) {
        case 1:{
            subMod = [[TIMenuPlistManager shareManager].cheekRedModArr objectAtIndex:indexPath.row];
          
                   [cell setSubMod:subMod];
        }
            break;
        case 2:{
            TIMenuMode * subMod = [[TIMenuPlistManager shareManager].eyelashModArr objectAtIndex:indexPath.row];
                        
                   [cell setSubMod:subMod];
        }
            break;
        case 3:{
            TIMenuMode * subMod = [[TIMenuPlistManager shareManager].eyebrowsModArr objectAtIndex:indexPath.row];
                           
                   [cell setSubMod:subMod];
        }
            
       
            
            break;
            
        default:
            break;
    }
  
//    if (subMod.selected)
//     {
//        self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//        if (self.clickOnCellBlock)
//        {
//            //        拼接标示符 1 腮红  2睫毛。3眉毛
//            //       例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
//                NSUInteger tag = self.mode.menuTag * 1000 + self.selectedIndexPath.row;
//             self.clickOnCellBlock(tag);
//            }
//        }
    
    return cell;
         
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.mode.menuTag) {
            
        case 1:
            {
                    TIMenuMode *mode = [TIMenuPlistManager shareManager].cheekRedModArr[indexPath.row];
                    if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
                    {
                        if(indexPath.row == self.selectedIndexPath.row) return;
                        
                          [TIMenuPlistManager shareManager].cheekRedModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TICheekRed.json"];
                        
                          [TIMenuPlistManager shareManager].cheekRedModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TICheekRed.json"];
            
                                       if (self.selectedIndexPath) {
                                           [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                                       }else{
                                           [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                       }
                                       self.selectedIndexPath = indexPath;
                        if (self.clickOnCellBlock)
                        {
//                            拼接标示符 1 腮红  2睫毛。3眉毛
//                           例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
                            NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                                self.clickOnCellBlock(tag);
                          }
//                        [[TiSDKManager shareManager] setStickerName:mode.name];
                    }
                    else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
                    {
                        // 开始下载
                      [TIMenuPlistManager shareManager].cheekRedModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TICheekRed.json"];
                        
                      [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                        WeakSelf;
                     [[TIDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_blusher MenuMode:mode completeBlock:^(BOOL successful) {
                            DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                            if (successful) {
                                // 开始下载
                                state = TI_DOWNLOAD_STATE_CCOMPLET;
                            }else{
                                state = TI_DOWNLOAD_STATE_NOTBEGUN;
                            }
                               [TIMenuPlistManager shareManager].cheekRedModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TICheekRed.json"];
                            
                         [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                            
                        }];
                    }
                }
 
        
            break;
        case 2:
        {
                             TIMenuMode *mode = [TIMenuPlistManager shareManager].eyelashModArr[indexPath.row];
                            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
                            {
                                if(indexPath.row == self.selectedIndexPath.row) return;
                                  [TIMenuPlistManager shareManager].eyelashModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TIEyelash.json"];
                                
                                  [TIMenuPlistManager shareManager].eyelashModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TIEyelash.json"];
                    
                                               if (self.selectedIndexPath) {
                                                   [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                                               }else{
                                                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                               }
                                               self.selectedIndexPath = indexPath;
                            if (self.clickOnCellBlock)
                                                    {
                            //                            拼接标示符 1 腮红  2睫毛。3眉毛
                            //                           例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
                                                        NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                                                            self.clickOnCellBlock(tag);
                                                      }
        //                        [[TiSDKManager shareManager] setStickerName:mode.name];
                            }
                            else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
                            {
                                // 开始下载
                              [TIMenuPlistManager shareManager].eyelashModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TIEyelash.json"];
                                
                              [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                WeakSelf;
                             [[TIDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyelash MenuMode:mode completeBlock:^(BOOL successful) {
                                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                                    if (successful) {
                                        // 开始下载
                                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                                    }else{
                                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                                    }
                                       [TIMenuPlistManager shareManager].eyelashModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TIEyelash.json"];
                                    
                                 [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                                    
                                }];
                            }
                        }
                break;
            case 3:{
                                TIMenuMode *mode = [TIMenuPlistManager shareManager].eyebrowsModArr[indexPath.row];
                                if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
                                {
                                    if(indexPath.row == self.selectedIndexPath.row) return;
                                      [TIMenuPlistManager shareManager].eyebrowsModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TIEyebrows.json"];
                                    
                                      [TIMenuPlistManager shareManager].eyebrowsModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TIEyebrows.json"];
                        
                                                   if (self.selectedIndexPath) {
                                                       [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                                                   }else{
                                                       [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                   }
                                                   self.selectedIndexPath = indexPath;
                                if (self.clickOnCellBlock)
                                                        {
                                //                            拼接标示符 1 腮红  2睫毛。3眉毛
                                //                           例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
                                                            NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                                                                self.clickOnCellBlock(tag);
                                                          }
            //                        [[TiSDKManager shareManager] setStickerName:mode.name];
                                }
                                else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
                                {
                                    // 开始下载
                                  [TIMenuPlistManager shareManager].eyebrowsModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TIEyebrows.json"];
                                    
                                  [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                    WeakSelf;
                                 [[TIDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyebrow MenuMode:mode completeBlock:^(BOOL successful) {
                                        DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                                        if (successful) {
                                            // 开始下载
                                            state = TI_DOWNLOAD_STATE_CCOMPLET;
                                        }else{
                                            state = TI_DOWNLOAD_STATE_NOTBEGUN;
                                        }
                                           [TIMenuPlistManager shareManager].eyebrowsModArr  =  [[TIMenuPlistManager shareManager] modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TIEyebrows.json"];
                                        
                                     [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                                        
                                    }];
                                }
                            }
//            {
//             [TIMenuPlistManager shareManager].eyebrowsModArr   =  [[TIMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TIEyebrows.json"];
//
//             [TIMenuPlistManager shareManager].eyebrowsModArr   =  [[TIMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TIEyebrows.json"];
//
//                  if (self.selectedIndexPath) {
//                         [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
//                     }else{
//                         [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                     }
//                self.selectedIndexPath = indexPath;
//
//            }
                    break;
            
        default:
            break;
    }
}


- (void)setMode:(TIMenuMode *)mode{
    if (mode) {
    
    _mode = mode;
        
        switch (mode.menuTag) {
            case 1:{
                for (int i = 0; i<[TIMenuPlistManager shareManager].cheekRedModArr.count; i++) {
                    TIMenuMode * subMod = [TIMenuPlistManager shareManager].cheekRedModArr[i];
                    
//                   // NSLog(@"过滤文字%@--腮红--%d"),subMod.dir,subMod.selected);
                    if (subMod.selected) {
                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        
                        if (self.clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                                self.clickOnCellBlock(tag);
                        }
                    }
                }
            }
              break;
                case 2:{
                    for (int i = 0; i<[TIMenuPlistManager shareManager].eyelashModArr.count; i++) {
                        TIMenuMode * subMod = [TIMenuPlistManager shareManager].eyelashModArr[i];
                        
//                       // NSLog(@"过滤文字%@--睫毛--%d"),subMod.dir,subMod.selected);
                        if (subMod.selected) {
                                               self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                               [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                            if (self.clickOnCellBlock&&i)
                            {
                                NSUInteger tag = self.mode.menuTag * 1000 + i;
                                    self.clickOnCellBlock(tag);
                            }
                                           }
                    }
                }
                 break;
                case 3:{
                    for (int i = 0; i<[TIMenuPlistManager shareManager].eyebrowsModArr.count; i++) {
                        TIMenuMode * subMod = [TIMenuPlistManager shareManager].eyebrowsModArr[i];
                        
//                       // NSLog(@"过滤文字%@--眉毛--%d"),subMod.dir,subMod.selected);
                        if (subMod.selected) {
                                               self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                               [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                            if (self.clickOnCellBlock&&i)
                            {
                                NSUInteger tag = self.mode.menuTag * 1000 + i;
                                    self.clickOnCellBlock(tag);
                            }
                                           }
                    }
                }

                break;
                
            default:
                break;
        }
        
        
    [self.totalSwitch setTitle:[NSString stringWithFormat:@"%@",mode.name] withImage:[UIImage imageNamed:@"beautyMakeup_back.png"] withTextColor:TI_Color_Default_Background_Pink forState:UIControlStateNormal];
    
         
      }
}

-(void)backParentMenu:(TIButton *)sender{
    [self setHiddenAnimation:YES];
}


-(void)setHiddenAnimation:(BOOL)hidden{
    
    [self.exitTapView setHidden:hidden];
    if (hidden) {
        [self.exitTapView removeFromSuperview];
    }else{
        BOOL isSubView = [self.exitTapView isDescendantOfView:self.window];
        if (!isSubView) {
            [self.window addSubview:self.exitTapView];
        }
    }

    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = !hidden;
        
    }];
    
    if (hidden) {
        if (self.makeupShowDisappearBlock)
       {
                self.makeupShowDisappearBlock(YES);
       }
        return;
    }
     [self.menuCollectionView reloadData];
}

@end
