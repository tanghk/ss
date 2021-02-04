//
//  MineItemsView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "MineItemsView.h"
#import "MineItemsCell.h"
#import "MineModel.h"
static NSString *MineItemsCell_ID = @"mineItemsCell_ID";

@interface MineItemsView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *hLineImageV;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MineItemsView

- (void)configSubView{
    
    ViewRadius(self, 8.0);
    
  
    self.dataArray = [MineModel getWithMineData];
    
    [self addSubview:self.collectionView];
}

- (void)layout{
    
  
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(86);
    }];
}

- (void)configureViewWithModel:(id)contentModel{
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
       
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreen_Width-2*15)/3, 86);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//横向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0;
}

//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MineItemsCell_ID forIndexPath:indexPath];
    [cell configureCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
 *creat collectionView
 */
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        } else {
            //Fallback on earlier versions
        }
        
        [_collectionView registerClass:[MineItemsCell class] forCellWithReuseIdentifier:MineItemsCell_ID];
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
