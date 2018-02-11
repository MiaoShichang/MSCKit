//
//  UIJsBridgeWebView.h
//  ExampleApp-iOS
//
//  Created by miaoshichang on 2018/2/11.
//  Copyright © 2018年 Marcus Westin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface UIJsBridgeWebView : UIWebView

+ (void)enableLogging;

+ (void)setLogMaxLength:(int)length;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;

- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;

- (void)disableJavscriptAlertBoxSafetyTimeout;

@end


/*
请在HTML页面中写入下面的相关代码
 
<script>
 
    
     function setupWebViewJavascriptBridge(callback) {
         if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
         if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
         window.WVJBCallbacks = [callback];
         var WVJBIframe = document.createElement('iframe');
         WVJBIframe.style.display = 'none';
         WVJBIframe.src = 'https://__bridge_loaded__';
         document.documentElement.appendChild(WVJBIframe);
         setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
     }
 
    setupWebViewJavascriptBridge(function(bridge) {
         // 注册函数，此函数是原生来调用的
         bridge.registerHandler('jsFunction', function(data, responseCallback) {
            var responseData = { 'data':'data from js callback'}
            responseCallback(responseData)
         })
 
         var call_ios_Fun = document.getElementById('btn1')
         call_ios_Fun.onclick = function(e) {
             //调用原生函数
             bridge.callHandler('iosFunction', {'data': 'data from js'}, function(response) {
                alert(response);
            })
        }
    })
 
 
 </script>
 
 
 
 
 */
