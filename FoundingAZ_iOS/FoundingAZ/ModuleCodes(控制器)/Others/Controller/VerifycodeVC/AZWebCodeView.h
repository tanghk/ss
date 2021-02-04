//
//  AZWebCodeView.h
//  FoundingAZ
//
//  Created by mark on 2021/2/2.
//

#import "BaseView.h"

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^DSWebCodeViewDismissCallback)(void);
typedef void(^DSWebCodeViewVerifySucessCallback)(NSString *ticket);
typedef void(^DSWebCodeViewVerifyFailCallback)(void);

@interface AZWebCodeView : BaseView<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, copy) DSWebCodeViewDismissCallback dismissCallback;
@property (nonatomic, copy) DSWebCodeViewVerifySucessCallback verifySuccessCallback;
@property (nonatomic, copy) DSWebCodeViewVerifyFailCallback verifyFailCallback;

- (void)loadTencentCaptcha;

@end
