//
//  CAuthorityInfoFooter.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/4.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityInfoFooter.h"
#import <LibProjModel/AnchorAuthVOModel.h>
#import <LibProjModel/UserInterestTabVOModel.h>
 
@interface CAuthorityInfoFooter ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *markCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@end
@implementation CAuthorityInfoFooter
- (NSMutableDictionary *)cellDic{
    if (!_cellDic) {
        _cellDic = [NSMutableDictionary dictionary];
    }
    return _cellDic;
}
- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _layout = layout;
    }
    return _layout;
}
- (UICollectionView *)markCollectionView{
    if (!_markCollectionView) {
        _markCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-24, 100) collectionViewLayout:self.layout];
        _markCollectionView.showsVerticalScrollIndicator = NO;
        _markCollectionView.delegate = self;
        _markCollectionView.dataSource = self;
        [_markCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"markCollectionReusableViewReusableView"];
        _markCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _markCollectionView;
}
- (void)setMyMarkArr:(NSMutableArray *)myMarkArr{
    _myMarkArr = myMarkArr;
    [self updateMarkView];
}
 
- (void)updateMarkView{
    [self removeAllSubViews];
    UIView *markView = [[UIView alloc ]init];
    markView.backgroundColor = [UIColor clearColor];
    CGFloat height = [self getMarkHeight];
    if( self.myMarkArr.count > 0) {
        markView.frame = CGRectMake(12, 0,kScreenWidth, height);
        self.markCollectionView.frame =  CGRectMake(0, 0, kScreenWidth-24, height);
        [self.markCollectionView reloadData];
        [markView addSubview:self.markCollectionView];
    }
    [self addSubview:markView];
    self.height = height;
}
- (CGFloat)getMarkHeight{
    CGFloat height = 60+kSafeAreaBottom;
    if (self.myMarkArr.count > 0) {
        height += (self.myMarkArr.count/4+1)*40;
    }
    return height;
}
#pragma mark - UIcollection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myMarkArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self.cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if(identifier == nil){
        identifier = [NSString stringWithFormat:@"%@%@",[NSString getNowTimeTimestamp], [NSString stringWithFormat:@"%@",indexPath]];
        [self.cellDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
       [self.markCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
     
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    for (UIView *v in cell.subviews) {
        [v removeFromSuperview];
    }
    UserInterestTabVOModel *detailModel = self.myMarkArr[indexPath.row];
    CGSize size = [detailModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width+20, 28)];
    textLabel.layer.cornerRadius = 14;
    textLabel.clipsToBounds = YES;
    textLabel.layer.borderWidth = 1.0;
    textLabel.layer.borderColor = kRGB_COLOR(detailModel.fontColor).CGColor;
    textLabel.textColor =kRGB_COLOR(detailModel.fontColor);
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.text = detailModel.name;
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:textLabel];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserInterestTabVOModel *detailModel  = self.myMarkArr[indexPath.row];
    CGSize size = [detailModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return CGSizeMake(size.width+20, 28);
}
 
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

@end
 
