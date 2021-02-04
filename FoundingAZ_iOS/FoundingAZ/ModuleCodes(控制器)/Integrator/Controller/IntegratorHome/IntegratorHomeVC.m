//
//  IntegratorHomeVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "IntegratorHomeVC.h"
#import "IntegratorHomeCell.h"
#import "IntegrHomeHeadView.h"
#import "IntegrCaseDetailVC.h"

static NSString *IntegratorHomeCell_ID = @"integratorHomeCell_ID";
static NSString *IntegrHomeHeadView_ID = @"integrHomeHeadView_ID";

@interface IntegratorHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation IntegratorHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"企业信息" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[IntegratorHomeCell class] forCellWithReuseIdentifier:IntegratorHomeCell_ID];
    [self.collectionView registerClass:[IntegrHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IntegrHomeHeadView_ID];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;//self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (kScreen_Width-2*16-23)/2;
    return CGSizeMake(width, 12+(width*9/16)+8+20);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8, 16, kBottomHeight, 16);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 23.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreen_Width,60+200+53);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        IntegrHomeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IntegrHomeHeadView_ID forIndexPath:indexPath];
        
        return headerView;
        
    }else{
        
        return [UICollectionReusableView new];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegratorHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IntegratorHomeCell_ID forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegrCaseDetailVC *vc = [[IntegrCaseDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionView*)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
