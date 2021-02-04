//
//  AZWebCodeView.m
//  FoundingAZ
//
//  Created by mark on 2021/2/2.
//


#import "AZWebCodeView.h"
#import <YYModel/YYModel.h>
@interface DSVerifyResultModel : BaseModel

@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *randstr;
@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, copy) NSString *ticket;

@end

@implementation DSVerifyResultModel

@end

@interface AZWebCodeView ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AZWebCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.webView];
}

- (void)dismiss {
    [self removeFromSuperview];
    if (self.dismissCallback) {
        self.dismissCallback();
    }
}

// 加载入口方法
- (void)loadTencentCaptcha {
//    NSString *randomstr = [self randomPassword];
    NSString* htmlText = DSWebBridge_html_js();
    [self.webView loadHTMLString:htmlText baseURL:nil];
}

//自动生成8位随机密码
//-(NSString *)randomPassword{
//    NSTimeInterval random = [NSDate timeIntervalSinceReferenceDate];
//    NSString *randomString = [[NSString stringWithFormat:@"%.8f",random] MD5];
//    NSString *randompassword = [randomString substringWithRange:NSMakeRange(6, 8)];
//    return randompassword;
//}

//js调用原生回调
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"loadAction"]) {
        //加载成功, 更新webview的frame
        NSDictionary *jsData =  message.body;
        self.webView.frame = CGRectMake(0, 0, [jsData[@"sdkView"][@"width"] doubleValue], [jsData[@"sdkView"][@"height"] doubleValue]);
        self.webView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }else if([message.name isEqualToString:@"verifiedAction"]) {
        //划动验证
       DSVerifyResultModel *model = [DSVerifyResultModel yy_modelWithJSON:message.body];
        if (model.ret == 0) {//验证成功
            [self removeFromSuperview];
            !self.verifySuccessCallback ? :self.verifySuccessCallback(model.ticket);
        }else if (model.ret == 2) {//点击关闭
            [self dismiss];
        }
    }else if([message.name isEqualToString:@"errorAction"]) {//加载失败
        [self removeFromSuperview];
        !self.verifyFailCallback?:self.verifyFailCallback();
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        //注册果断回调方法
        [configuration.userContentController addScriptMessageHandler:self name:@"loadAction"];
        [configuration.userContentController addScriptMessageHandler:self name:@"errorAction"];
        [configuration.userContentController addScriptMessageHandler:self name:@"verifiedAction"];
        
        WKWebView* webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        webView.navigationDelegate = self;
        _webView = webView;
    }
    return _webView;
}

NSString * DSWebBridge_html_js() {
#define __wvjb_js_func__(x) #x
    static NSString * html = @__wvjb_js_func__(
                                               <!DOCTYPE html>
                                               <html>
                                               <head>
                                               <script  src="https://ssl.captcha.qq.com/TCaptcha.js?v=%@" type="text/javascript"></script>
                                               <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
                                               </head>
                                               <body>
                                               <script type="text/javascript">
                                               (function(){
        // 验证成功返回ticket
        window.SDKTCaptchaVerifyCallback = function (retJson) {
            if (retJson){
                window.webkit.messageHandlers.verifiedAction.postMessage(retJson)
            }
        };
        // 验证码加载完成的回调，用来设置webview尺寸
        window.SDKTCaptchaReadyCallback = function (retJson) {
            if (retJson && retJson.sdkView && retJson.sdkView.width && retJson.sdkView.height &&  parseInt(retJson.sdkView.width) >0 && parseInt(retJson.sdkView.height) >0 ){
                window.webkit.messageHandlers.loadAction.postMessage(retJson)
            }
        };
        window.onerror = function (msg, url, line, col, error) {
            if (window.TencentCaptcha == null) {
                window.webkit.messageHandlers.errorAction.postMessage(error)
            }
        };
        var sdkOptions = {"sdkOpts": {"width": 265, "height": 265}};
        sdkOptions.ready = window.SDKTCaptchaReadyCallback;
        window.onload = function () {
           //此处需要替换xxxxxx为appid
            new TencentCaptcha("2045028879", SDKTCaptchaVerifyCallback, sdkOptions).show();
        };
    })();
     </script></body></html>
    );
#undef __wvjb_js_func__
    return html;
};

@end
