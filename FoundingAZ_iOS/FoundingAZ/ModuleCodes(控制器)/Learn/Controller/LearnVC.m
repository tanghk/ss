//
//  LearnVC.m
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import "LearnVC.h"

@interface LearnVC ()

@end

@implementation LearnVC

- (id)init{
    self = [super init];
    
    if (self) {
        
        self.title=@"";
        self.tabBarItem.title=@"学习";
                
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_learn_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_learn_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
