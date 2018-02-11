//
//  UIJsBridgeWebView.m
//  ExampleApp-iOS
//
//  Created by miaoshichang on 2018/2/11.
//  Copyright © 2018年 Marcus Westin. All rights reserved.
//

#import "UIJsBridgeWebView.h"

@interface UIJsBridgeWebView ()
@property (nonatomic, strong)WebViewJavascriptBridge *bridge;
@end

@implementation UIJsBridgeWebView
- (WebViewJavascriptBridge *)bridge
{
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self];
    }
    return _bridge;
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    if ([delegate isKindOfClass:[WebViewJavascriptBridge class]]){
        [super setDelegate:delegate];
    }
    else{
        [self.bridge setWebViewDelegate:delegate];
    }
}

+ (void)enableLogging
{
    [WebViewJavascriptBridge enableLogging];
}

+ (void)setLogMaxLength:(int)length
{
    [WebViewJavascriptBridge setLogMaxLength:length];
}

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler
{
    [[self bridge] registerHandler:handlerName handler:handler];
}

- (void)removeHandler:(NSString*)handlerName
{
    [[self bridge] removeHandler:handlerName];
}

- (void)callHandler:(NSString*)handlerName
{
    [[self bridge] callHandler:handlerName];
}

- (void)callHandler:(NSString*)handlerName data:(id)data
{
    [[self bridge]callHandler:handlerName data:data];
}

- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [[self bridge]callHandler:handlerName data:data responseCallback:responseCallback];
}

- (void)disableJavscriptAlertBoxSafetyTimeout
{
    [[self bridge]disableJavscriptAlertBoxSafetyTimeout];
}

@end
