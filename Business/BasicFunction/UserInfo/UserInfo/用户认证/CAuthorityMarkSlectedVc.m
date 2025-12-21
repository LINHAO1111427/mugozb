//
//  CAuthorityMarkSlectedVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityMarkSlectedVc.h"
#import <LibProjModel/TabInfoDtoModel.h>
#import <LibProjModel/UserInterestTabVOModel.h>
#import "CAuthorityMarkCollectionCell.h"
 
typedef void (^containCallBack)(BOOL isContain, UserInterestTabVOModel* model);
static NSString *markCollectionViewCellId = @"CAuthorityMarkCollectionCellId";
@interface CAuthorityMarkSlectedVc ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *markCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)NSArray *markArray;
@end

@implementation CAuthorityMarkSlectedVc

- (NSMutableArray *)myMarkArr{
    if (!_myMarkArr) {
        _myMarkArr = [NSMutableArray array];
    }
    return _myMarkArr;
}
- (NSArray *)markArray{
    if (!_markArray) {
        _markArray = [NSArray array];
    }
    return _markArray;
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
         _markCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, kScreenHeight) collectionViewLayout:self.layout];
         _markCollectionView.showsVerticalScrollIndicator = NO;
         _markCollectionView.delegate = self;
         _markCollectionView.dataSource = self;
         [_markCollectionView registerClass:[CAuthorityMarkCollectionCell class] forCellWithReuseIdentifier:markCollectionViewCellId];
         [_markCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"markCollectionReusableViewReusableView"];
         _markCollectionView.backgroundColor = [UIColor whiteColor];
     }
     return _markCollectionView;
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"我的标签");
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadata];
    [self.view addSubview:self.markCollectionView];
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sureButton.frame = CGRectMake(0, 0, 60, 28);
    [sureButton setTitle:kLocalizationMsg(@"保存") forState:UIControlStateNormal];
    sureButton.backgroundColor =[ProjConfig normalColors];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 14;
    sureButton.clipsToBounds = YES;
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureButton addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:sureButton ];
    rightItem.imageInsets = UIEdgeInsetsMake(0, 0,0, 0);//设置向左偏移
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)loadata{
    [HttpApiUserController allTabs:^(int code, NSString *strMsg, NSArray<TabTypeDtoModel *> *arr) {
        if (code == 1) {
            self.markArray = arr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.markCollectionView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
#pragma mark - UIcollection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.markArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    TabTypeDtoModel *model = self.markArray[section];
    return model.tabInfoList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CAuthorityMarkCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:markCollectionViewCellId forIndexPath:indexPath];
    TabTypeDtoModel *model = self.markArray[indexPath.section];
    TabInfoDtoModel *detailModel = model.tabInfoList[indexPath.row];
    cell.indexPath = indexPath;
    cell.model = detailModel;
    [self isContainMark:detailModel back:^(BOOL isContain, UserInterestTabVOModel *model) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.isSelected = isContain;
        });
    }];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TabTypeDtoModel *model = self.markArray[indexPath.section];
   __block TabInfoDtoModel *detailModel = model.tabInfoList[indexPath.row];
    kWeakSelf(self);
    [self isContainMark:detailModel back:^(BOOL isContain, UserInterestTabVOModel *model) {
        if (isContain) {
            [weakself.myMarkArr removeObject:model];
        }else{
            [weakself.myMarkArr addObject:detailModel];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.markCollectionView reloadItemsAtIndexPaths:@[indexPath]];
        });
    }];
     
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    TabTypeDtoModel *model = self.markArray[indexPath.section];
    TabInfoDtoModel *detailModel = model.tabInfoList[indexPath.row];
    CGSize size = [detailModel.name boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return CGSizeMake(size.width+20, 28);
}
 
 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 40);
 
}
 
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    TabTypeDtoModel *model = self.markArray[indexPath.section];
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"markCollectionReusableViewReusableView" forIndexPath:indexPath];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth-24, 20)];
    titleLabel.textColor =kRGB_COLOR(@"#444444");
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = model.name;
    [headerView addSubview:titleLabel];
    return headerView;
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
- (void)sureBtnClick:(UIButton *)btn{
    if (self.myMarkArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择标签")];
        return;
    }
    NSString *requestStr = @"";
    for (int i = 0; i < self.myMarkArr.count; i++) {
        TabInfoDtoModel *detailModel = self.myMarkArr[i];
        if (i == 0) {
            requestStr = [NSString stringWithFormat:@"%lld:%@",detailModel.id_field,detailModel.name];
        }else{
            requestStr = [NSString stringWithFormat:@"%@,%lld:%@",requestStr,detailModel.id_field,detailModel.name];
        }
    }
    kWeakSelf(self);
    [HttpApiUserController updateInterest:requestStr callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.completeBlock) {
                weakself.completeBlock(self.myMarkArr);
            }
            [self.navigationController popViewControllerAnimated:YES];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)isContainMark:(TabInfoDtoModel*)model back:(containCallBack)back{
    for (UserInterestTabVOModel *detailModel in self.myMarkArr) {
        if (model.id_field == detailModel.id_field) {
            back(YES,detailModel);
            return;
        }
    }
    back(NO,nil);
}
 
@end
