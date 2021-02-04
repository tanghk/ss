//
//  ConnectUsVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "ConnectUsVC.h"
#import "ConnectUsItemsView.h"
#import "ConnectUsModel.h"
#import "BaseWKWebView.h"
#import "MineModel.h"
#import "ConnectUsCell.h"
static NSString *ConnectUsCell_ID = @"connectUsCell_ID";

@interface ConnectUsVC ()

@property (nonatomic, strong) ConnectUsItemsView *headView;

@end

@implementation ConnectUsVC

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
    
    self.dataArray = [ConnectUsModel getWithAddressData];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}
/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"联系我们" isShowBack:YES hasLine:NO];
}


- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight);
    self.tableView.backgroundColor = Color_Whitle;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ConnectUsCell class] forCellReuseIdentifier:ConnectUsCell_ID];
    
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
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.0)];
    headSectionView.backgroundColor = Color_Whitle;
    
    return headSectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
    ConnectUsModel *model = [arr safeObjectIndex:indexPath.row];
    
    ConnectUsCell *cell = [tableView dequeueReusableCellWithIdentifier:ConnectUsCell_ID forIndexPath:indexPath];
    
    [cell configureCellWithModel:model withIndexPath:indexPath withArray:arr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
    ConnectUsModel *model = [arr safeObjectIndex:indexPath.row];
    
//    if (model.connectUsType == ConnectUsType_order) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //IntegratorEnterVC *vc = [[IntegratorEnterVC alloc] init];
//            IntegratorHomeVC *vc = [[IntegratorHomeVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }else if (model.mineViewType == ConnectUsType_information){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }else if (model.mineViewType == ConnectUsType_setting){
//        [self versionTap];
//    }else if (model.mineViewType == ConnectUsType_contact){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *tel = [model.conStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", tel]];
//            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
//        });
//    }else if (model.mineViewType == MineViewType_about){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            AboutUsVC *vc = [[AboutUsVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }
}

- (void)versionTap{
    

}

/*
 * creat headView
 */
- (ConnectUsItemsView *)headView{
    
    if (!_headView) {
        _headView = [[ConnectUsItemsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 125)];
//        _headView.layer.borderWidth = 1;
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
