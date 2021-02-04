//
//  ConnectUsItemsView.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "ConnectUsItemsView.h"
#import "ConnectUsItemsCell.h"
#import "ConnectUsModel.h"
static NSString *ConnectUsItemsCell_ID = @"connectUsItemsCell_ID";

@interface ConnectUsItemsView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIImageView *hLineImageV;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ConnectUsItemsView

- (void)configSubView{
    
    ViewRadius(self, 8.0);
    
  
    self.dataArray = [ConnectUsModel getWithConnectUsData];
    
    [self addSubview:self.collectionView];
}

- (void)layout{
    
  
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(95+30);
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
    
    return CGSizeMake((kScreen_Width-40)/3, 95);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
   return UIEdgeInsetsMake(0, 10, 0, 10);
}

//横向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10.0;
}

//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ConnectUsItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ConnectUsItemsCell_ID forIndexPath:indexPath];
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
        
        [_collectionView registerClass:[ConnectUsItemsCell class] forCellWithReuseIdentifier:ConnectUsItemsCell_ID];
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
