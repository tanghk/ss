//
//  VerifycodeVC.m
//  FoundingAZ
//
//  Created by mark on 2021/2/2.
//

#import "VerifycodeVC.h"

#define titleHeight  20
#define buttonHeight 35

@interface VerifycodeVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    
    UIImageView *imgBg;//
    UITextView *txtContent;//新版本更新内容
}
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)NSString *appId;

@end

@implementation VerifycodeVC
@synthesize updateVerSion,updateMsg,updateUrl;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubViews];
    
    
}
#pragma  mark - 网络请求
-(void)requestCodeData{
    @weakify(self);

    [HttpTool getRequestWithUrl:@"/tsec"
                         Params:nil
                        success:^(id returnData) {
        @strongify(self);

        NSDictionary *returnDic =returnData[@"data"];
        self.appId = FormatString(returnDic[@"app_id"]);
        
        NSString *jsString = [NSString stringWithFormat:@"show_code('%@')", self.appId];
        NSLog(@"jsString -%@",jsString );
        [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            
            NSLog(@"改变HTML的背景色");
            
        }];
    } error:^(NSString *error, NSInteger errorCode) {
        
    }];
    
}
- (void)addSubViews
{
    if (!imgBg) {
        
        imgBg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-265)/2 ,(kScreen_Height-265)/2, 265,265)];
        imgBg.userInteractionEnabled = YES;
        imgBg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imgBg];
    }
    
    [self.view addSubview:self.webView];
    self.webView.frame =CGRectMake((kScreen_Width-265)/2 ,(kScreen_Height-265)/2, 265,265);
    
    
    //    [imgBg beginAnimation];
    
}

-(void)showAnimation{
    
    //    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //    animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
    //    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    //    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //    animation.duration = 0.5;
    ////    animation.delegate = self;
    ////    [animation setValue:completion forKey:@"handler"];
    //    [imgBg.layer addAnimation:animation forKey:@"bouce"];
}



-(void)dismiss{
    
//    [imgBg dismissAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(WKWebView *)webView{
    if(_webView == nil){
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //设置是否支持 javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在 iOS 上默认为 NO，表示是否允许不经过用户交互由 javaScript 自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        //这个类主要用来做 native 与 JavaScript 的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:self  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:self  name:@"jsToOcWithPrams"];
        config.userContentController = wkUController;
        //用于进行 JavaScript 注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 265,265) configuration:config];
  _webView.backgroundColor = [UIColor clearColor];
        // UI 代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        //此处即需要渲染的网页
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
        NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    return _webView;
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    [self.progressView setProgress:0.0f animated:NO];
}
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //    [self getCookie];
    
    [self requestCodeData];
    
}
//提交发生错误时调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //    [self.progressView setProgress:0.0f animated:NO];
}
// 接收到服务器跳转请求即服务重定向时之后调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    // 此处message.body即传给客户端的json数据
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    NSLog(@"%@",parameter);
    //JS调用OC
    if([message.name isEqualToString:@"jsToOcWithPrams"]){
        //在此处客户端得到js透传数据  并对数据进行后续操作
        if ([parameter isKindOfClass:[NSDictionary class]]) {
            self.verifycodeDismiss(parameter);
            [self dismiss];
        }else{
            
            NSDictionary *dic =[MTools dictionaryWithString:parameter ];
            self.verifycodeDismiss(dic);
            [self dismiss];
        }
       
    }
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        //在此处客户端得到js透传数据  并对数据进行后续操作
       
        [self dismiss];
    }
    
    
    
    /*
     *{"randstr":"@9R0","ticket":"t03S923rUfpAtEi9w0yybNS9tvY-DafD-l3CT5poCs-flwjRWQ8gyVNcSHPEztIysD8mNRztIEssHnCVTtRyHfX32FEv0Sg6pRS0YMA_0w6Rco*"}
     */
}


@end

