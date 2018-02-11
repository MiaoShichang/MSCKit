//
//  WKJsBridgeWebView.m
//  ExampleApp-iOS
//
//  Created by miaoshichang on 2018/2/11.
//  Copyright © 2018年 Marcus Westin. All rights reserved.
//

#import "WKJsBridgeWebView.h"

#if defined supportsWKWebView

@interface WKJsBridgeWebView ()
@property (nonatomic, strong)WKWebViewJavascriptBridge *bridge;
@end

@implementation WKJsBridgeWebView

- (WKWebViewJavascriptBridge *)bridge
{
    if (!_bridge) {
         _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self];
    }
    return _bridge;
}

- (void)setNavigationDelegate:(id<WKNavigationDelegate>)navigationDelegate
{
    if ([navigationDelegate isKindOfClass:[WKWebViewJavascriptBridge class]]){
        [super setNavigationDelegate:navigationDelegate];
    }
    else{
        [self.bridge setWebViewDelegate:navigationDelegate];
    }
}

+ (void)enableLogging
{
    [WKWebViewJavascriptBridge enableLogging];
}

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler
{
    [[self bridge]registerHandler:handlerName handler:handler];
}

- (void)removeHandler:(NSString*)handlerName
{
    [[self bridge]removeHandler:handlerName];
}

- (void)callHandler:(NSString*)handlerName
{
    [[self bridge]callHandler:handlerName];
}

- (void)callHandler:(NSString*)handlerName data:(id)data
{
    [[self bridge]callHandler:handlerName data:data];
}

- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [[self bridge]callHandler:handlerName data:data responseCallback:responseCallback];
}

- (void)reset
{
    [[self bridge]reset];
}

- (void)disableJavscriptAlertBoxSafetyTimeout
{
    [[self bridge]disableJavscriptAlertBoxSafetyTimeout];
}

@end

#endif
