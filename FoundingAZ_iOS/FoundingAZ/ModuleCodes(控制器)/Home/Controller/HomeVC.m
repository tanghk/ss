//
//  HomeVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "HomeVC.h"
#import "HomeTableCell.h"
#import "MineHeadView.h"
#import "MineModel.h"
#import "IntegratorEnterVC.h"
#import "IntegratorHomeVC.h"
#import "BaseWKWebView.h"
#import "SettingVC.h"

#import "HomeHeadView.h"
static NSString *HomeTableCell_ID = @"homeTableCell_ID";

@interface HomeVC ()<SDCycleScrollViewDelegate>{
    
}
@property (nonatomic, strong) HomeHeadView *headView;
@property (nonatomic, strong)UIView  *navView;
@property (nonatomic, strong)UILabel  *navLabel;

@end

@implementation HomeVC

- (id)init{
    self = [super init];
    
    if (self) {
      //  self.title=@"首页";
        self.tabBarItem.title=@"首页";
//        [self setNavigationTitle:@"首页" NavBackViewGroundColor:Color_Whitle textColor:Color_MainBlack isShowBack:NO];
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_home_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_home_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavUI];
    //   self.dataArray = [MineModel getWithMineViewData];
    NSArray *titleOneArr = @[@"培训服务",@"大课交付",@"咨询服务"];
    self.dataArray =[NSMutableArray arrayWithArray:titleOneArr];
    [self.tableView reloadData];
    
    
    
    self.view.backgroundColor = [UIColor randomColor];
    // Do any additional setup after loading the view.
    
    NewVersionTipVC *newVersion = [[NewVersionTipVC alloc] init];
    newVersion.updateUrl = null(@"", @"https://itunes.apple.com/cn/app/1489263525?mt=8");
    
    newVersion.updateMsg =@"更新描述";
    newVersion.isforup = [FormatString(@"0") integerValue];
    newVersion.titleKey = @"更新描述";;
    [Global shareGlobal].isForceUpdate = [FormatString(@"0") integerValue];
    newVersion.updateViewDismiss = ^{
        //        updateAction();
    };
    newVersion.cancelAction = ^{
        //        cancelAction();
    };
    // Do any additional setup after loading the view.
    NSDictionary *token =@{
        @"from":@"APP"
      
                           };
     NSLog(@"字典%@",token);
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:token ];
    
    [HttpTool getRequestWithUrl:@"/app/app_version"
                          Params:nil
                         success:^(id returnData) {
       
        
    } error:^(NSString *error, NSInteger errorCode) {
       
        
       
    }] ;
    
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
    
    
    
}
/*
 * UI部分
 */
//- (void)initWithNaviUI{
//    [super initWithNaviUI];
//}
- (void)initWithNavUI{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    self.navView = navView;
    self.navView.backgroundColor =HEXACOLOR(0xF6F6F6, 0.0);
    [self.view addSubview:self.navView];
   
    UILabel *navTitleLabel = [UILabel createLabelWithFrame:CGRectMake(50, kStatusBarHeight, kScreen_Width-2*50, kNavBarHeight) font:[UIFont M_PingFang_MediumOfSize:18.0] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@"创业酵母"];
    navTitleLabel.textColor =HEXACOLOR(0x001738, 0.0);
    self.navLabel = navTitleLabel;
    [self.navView addSubview:self.navLabel];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-kTabBarHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[HomeTableCell class] forCellReuseIdentifier:HomeTableCell_ID];
    
    self.tableView.tableHeaderView = self.headView;
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //  NSArray *arr = [self.dataArray safeObjectIndex:section];
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40.0)];
    sectionHeadView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-2*20, CGRectGetHeight(sectionHeadView.bounds))];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeadView addSubview:titleLabel];
    
    [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    titleLabel.text =self.dataArray[section];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.centerY.equalTo(sectionHeadView.mas_centerY);
        make.height.mas_equalTo(40);
        
    }];
    
    
    UILabel*mustLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-2*20, CGRectGetHeight(sectionHeadView.bounds))];
    
    mustLabel.font = [UIFont systemFontOfSize:13];
    mustLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeadView addSubview:mustLabel];
    mustLabel.textColor  =  Color_MainBlack;
    [mustLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [mustLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(titleLabel.mas_right).offset(5);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.height.mas_equalTo(40);
        
    }];
    
    return sectionHeadView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
//    HomeModel *model = [arr safeObjectIndex:indexPath.row];
    
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeTableCell_ID forIndexPath:indexPath];
    
    //   [cell configureCellWithModel:model withIndexPath:indexPath withArray:arr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IntegratorHomeVC *vc = [[IntegratorHomeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//
//    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
//    MineModel *model = [arr safeObjectIndex:indexPath.row];
//
//    if (model.mineViewType == MineViewType_order) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //IntegratorEnterVC *vc = [[IntegratorEnterVC alloc] init];
//            IntegratorHomeVC *vc = [[IntegratorHomeVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }else if (model.mineViewType == MineViewType_information){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }else if (model.mineViewType == MineViewType_setting){
//        [self versionTap];
//    }else if (model.mineViewType == MineViewType_contact){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *tel = [model.conStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", tel]];
//            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
//        });
//    }else if (model.mineViewType == MineViewType_about){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            SettingVC *vc = [[SettingVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }
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
- (HomeHeadView *)headView{
    
    if (!_headView) {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 180+97+kTopHeight)];
        
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
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    if (contentOffsetY>0&&contentOffsetY < kTopHeight) {
        CGFloat alpha = contentOffsetY/ (kTopHeight);
        self.navView.backgroundColor = HEXACOLOR(0xF6F6F6, alpha);
        self.navLabel.textColor =HEXACOLOR(0x001738, alpha);
    }else if (contentOffsetY>kTopHeight){
        self.navView.backgroundColor = HEXACOLOR(0xF6F6F6, 1.0);
        self.navLabel.textColor =  HEXACOLOR(0x001738, 1.0);
    }else{
        self.navView.backgroundColor = HEXACOLOR(0xF6F6F6, 0.0);
        self.navLabel.textColor =HEXACOLOR(0x001738, 0.0);
    }

}
@end

