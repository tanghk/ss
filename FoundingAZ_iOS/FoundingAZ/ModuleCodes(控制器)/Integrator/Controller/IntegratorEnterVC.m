//
//  IntegratorEnterVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "IntegratorEnterVC.h"
#import "IntegratorFieldCell.h"
#import "IntegratorSelectCell.h"
#import "IntegrLicenseCell.h"
#import "IntegEnterFootView.h"
#import "IntegrEnterModel.h"
#import "IntegrEnterSuccVC.h"

static NSString *IntegratorFieldCell_ID = @"integratorFieldCell_ID";
static NSString *IntegratorSelectCell_ID = @"integratorSelectCell_ID";
static NSString *IntegrLicenseCell_ID = @"integrLicenseCell_ID";

@interface IntegratorEnterVC ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) IntegEnterFootView *footView;

@end

@implementation IntegratorEnterVC

- (void)initWithData{
    
    self.dataArray = [IntegrEnterModel getWithIntegrEnterViewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"集成商入驻" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[IntegratorFieldCell class] forCellReuseIdentifier:IntegratorFieldCell_ID];
    [self.tableView registerClass:[IntegratorSelectCell class] forCellReuseIdentifier:IntegratorSelectCell_ID];
    [self.tableView registerClass:[IntegrLicenseCell class] forCellReuseIdentifier:IntegrLicenseCell_ID];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegrEnterModel *model = [self.dataArray safeObjectIndex:indexPath.row];
    
    if (model.integrEnterType == IntegrEnterType_name || model.integrEnterType == IntegrEnterType_adress || model.integrEnterType == IntegrEnterType_contact) {
        return 56.0;
    }else if (model.integrEnterType == IntegrEnterType_license){
        return 56.0;
    } else{
        CGFloat conHeight = [NSString heightOfStringWithString:model.conStr Font:[UIFont M_PingFang_RegularOfSize:Font_16] width:(kScreen_Width-16-64-24-24-18-10)];
        
        return 17.0+conHeight+17.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegrEnterModel *model = [self.dataArray safeObjectIndex:indexPath.row];
    
    if (model.integrEnterType == IntegrEnterType_name || model.integrEnterType == IntegrEnterType_adress || model.integrEnterType == IntegrEnterType_contact) {
        IntegratorFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegratorFieldCell_ID forIndexPath:indexPath];
        
        [cell configureCellWithModel:model];
        
        return cell;
    }else if (model.integrEnterType == IntegrEnterType_license){
        IntegrLicenseCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegrLicenseCell_ID forIndexPath:indexPath];
        
        [cell configureCellWithModel:model];
        
        return cell;
    } else{
        IntegratorSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegratorSelectCell_ID forIndexPath:indexPath];
        
        @weakify(self);
        cell.IntegratorSelectReloadBlock = ^{
            @strongify(self);
            [self.tableView reloadData];
        };
        
        [cell configureCellWithModel:model];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 * creat headView
 */
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 12)];
        _headView.backgroundColor = Color_MainGroud;
    }
    
    return _headView;
}

/*
 * creat footView
 */
- (IntegEnterFootView *)footView{
    
    if (!_footView) {
        _footView = [[IntegEnterFootView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 18+17+24+48+32+42+44+24+58*2+40)];
        
        @weakify(self);
        _footView.IntegEnterNextBtnBlock = ^{
            @strongify(self);
            
            IntegrEnterSuccVC *vc = [[IntegrEnterSuccVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
    }
    
    return _footView;
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
