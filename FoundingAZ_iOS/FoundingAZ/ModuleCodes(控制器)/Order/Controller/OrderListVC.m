//
//  OrderListVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "OrderListVC.h"
#import "OrderListCell.h"

static NSString *OrderListCell_ID = @"orderListCell_ID";

@interface OrderListVC ()

@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    self.tableFrame = CGRectMake(0, OrderMenuViewHeight, kScreen_Width, kScreen_Height-kTopHeight-OrderMenuViewHeight-kTabBarHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:OrderListCell_ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderListCell_ID forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
