//
//  TiUIClassifyView.m
//  TiFancy
//
//  Created by iMacA1002 on 2019/4/26.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import "TiUIClassifyView.h"
#import "TIConfig.h"
#import "TIButton.h"

#define MINIMUMLINESPACING  20

@interface TiUIClassifyView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSArray *modArr;

@property(nonatomic,strong) UICollectionView *classifyMenuView;

@end

@implementation TiUIClassifyView

static NSString *const TiUIClassifyViewCellId = @"TiUIClassifyViewCellId";

-(NSArray *)modArr{
    if (_modArr==nil) {
        ///0:美颜。 1:美型。 2:贴纸。 3:礼物  4:滤镜   5:抖动   6:哈哈镜   7:水印   8:面具   9:绿幕   10:一键美颜   11:互动贴纸   12:美妆
        _modArr= @[
            @{
                @"name":kLocalizationMsg(@"美颜"),
                @"icon":@"icon_function_meiyan.png",
                @"TIMenuClassify":@[@(0)]
            },
            @{
                @"name":kLocalizationMsg(@"美型"),
                @"icon":@"icon_function_meixing.png",
                @"TIMenuClassify":@[@(1)]
            },
            @{
                @"name":kLocalizationMsg(@"互动"),
                @"icon":@"icon_function_mengyan.png",
                @"TIMenuClassify":@[@(2),@(11),@(3),@(6),@(8),@(9)]
            },
            @{
                @"name":kLocalizationMsg(@"滤镜"),
                @"icon":@"icon_function_lvjing.png",
                @"TIMenuClassify":@[@(4),@(5)/**,@(7)*/]
            },
            @{
                @"name":kLocalizationMsg(@"一键美颜"),
                @"icon":@"icon_function_yijian.png",
                @"TIMenuClassify":@[@(10)]
            },
            @{
                @"name":kLocalizationMsg(@"美妆"),
                @"icon":@"icon_function_meizhuang.png",
                @"TIMenuClassify":@[@(12)]
            },
            @{
                @"name":@"",
                @"icon":@"",
                @"TIMenuClassify":@[@(0)]
            },
//            @{
//                @"name":@"",
//                @"icon":@"",
//                @"TIMenuClassify":@[@(0)]
//            },
            
        ];
    }
    return _modArr;
}

-(UICollectionView *)classifyMenuView{
    if (_classifyMenuView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _classifyMenuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _classifyMenuView.showsHorizontalScrollIndicator = NO;
        _classifyMenuView.backgroundColor=[UIColor whiteColor];
        _classifyMenuView.dataSource= self;
        _classifyMenuView.delegate = self;
        [_classifyMenuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:TiUIClassifyViewCellId];
        
        
    }
    return _classifyMenuView;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    if (_classifyMenuView) {
         [self collectionView:_classifyMenuView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.classifyMenuView];
        [self.classifyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self).mas_offset(-kSafeAreaBottom);
        }];

    }
    return self;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modArr.count;
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIClassifyViewCellId forIndexPath:indexPath];
    NSDictionary *dic = self.modArr[indexPath.row];
    
    UIButton *classifyBtn = nil;
    for (UIView *btnV in cell.contentView.subviews) {
        if ([btnV isKindOfClass:[UIButton class]]) {
            classifyBtn = (UIButton *)btnV;
        }
    }
    if (!classifyBtn) {
        classifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        classifyBtn.titleLabel.font = TI_Font_Default_Size_Medium;
        classifyBtn.userInteractionEnabled = NO;
        [classifyBtn setTitleColor:TI_Color_Default_Text_Black forState:UIControlStateNormal];
        [cell.contentView addSubview:classifyBtn];
        [classifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView.mas_left).offset(0);
            make.right.equalTo(cell.contentView.mas_right).offset(0);
        }];
        
    }
    [classifyBtn setTitle:[dic valueForKey:@"name"] forState:UIControlStateNormal];
    return cell;
    
}


// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, MINIMUMLINESPACING, 0, MINIMUMLINESPACING);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 45);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return MINIMUMLINESPACING;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name = [self.modArr[indexPath.row] objectForKey:@"name"];
    if (![name isEqualToString:@""]) {
        NSArray *arr = [self.modArr[indexPath.row] objectForKey:@"TIMenuClassify"];
        
        if (_clickOnTheClassificationBlock) {
            _clickOnTheClassificationBlock(arr);
        }
    }
    
}


@end
