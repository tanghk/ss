//
//  MineVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "MineVC.h"
#import "MineTableCell.h"
#import "MineHeadView.h"
#import "MineModel.h"
#import "IntegratorEnterVC.h"
#import "IntegratorHomeVC.h"
#import "BaseWKWebView.h"
#import "SettingVC.h"
#import "ConnectUsVC.h"
static NSString *MineTableCell_ID = @"mineTableCell_ID";

@interface MineVC ()

@property (nonatomic, strong) MineHeadView *headView;

@end

@implementation MineVC

- (id)init{
    self = [super init];
    
    if (self) {
        
        self.title=@"";
        self.tabBarItem.title=@"我的";
        
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_mine_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_mine_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [MineModel getWithMineViewData];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-kTabBarHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MineTableCell class] forCellReuseIdentifier:MineTableCell_ID];
    
    self.tableView.tableHeaderView = self.headView;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = [self.dataArray safeObjectIndex:section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 15.0)];
    headSectionView.backgroundColor = Color_MainGroud;
    
    return headSectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
    MineModel *model = [arr safeObjectIndex:indexPath.row];
    
    MineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTableCell_ID forIndexPath:indexPath];
    
    [cell configureCellWithModel:model withIndexPath:indexPath withArray:arr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
    MineModel *model = [arr safeObjectIndex:indexPath.row];
    
    if (model.mineViewType == MineViewType_order) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //IntegratorEnterVC *vc = [[IntegratorEnterVC alloc] init];
            IntegratorHomeVC *vc = [[IntegratorHomeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }else if (model.mineViewType == MineViewType_information){
        dispatch_async(dispatch_get_main_queue(), ^{
            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }else if (model.mineViewType == MineViewType_setting){
        [self versionTap];
    }else if (model.mineViewType == MineViewType_contact){
        dispatch_async(dispatch_get_main_queue(), ^{
            ConnectUsVC *vc = [[ConnectUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }else if (model.mineViewType == MineViewType_about){
        dispatch_async(dispatch_get_main_queue(), ^{
            AboutUsVC *vc = [[AboutUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
}

- (void)versionTap{
    
    //    [TTLoginSession getVersion:^(TTVersionData * _Nonnull data) {
    //        [TTVersionView showVersionViewWithData:data];
    //        TTTabBarController *tab = (TTTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //        [tab showNewLabel];
    //    } theNew:^{
    //        [MBProgressHUD showMessageInWindow:@"您已是最新版本"];
    //    }];
}

/*
 * creat headView
 */
- (MineHeadView *)headView{
    
    if (!_headView) {
        _headView = [[MineHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 86+20+70+70+kStatusBarHeight)];
    }
    
    return _headView;
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
