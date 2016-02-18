//
//  ViewController.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 15/10/29.
//  Copyright © 2015年 MiaoShichang. All rights reserved.
//

#import "ViewController.h"
#import "MSCDevice.h"
#import "NSArray+MSCKit.h"
#import "NSString+MSCKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
//    NSLog(@"name -- %@", [MSCDevice name]);
//    NSLog(@"wifi name -- %@", [MSCDevice currentWiFiName]);
//    NSLog(@"carrier -- %@", [MSCDevice carrierName]);
//    NSLog(@"model -- %@", [MSCDevice model]);
//    NSLog(@"model type -- %@", [MSCDevice modelType]);
//    NSLog(@"model name -- %@", [MSCDevice modelName]);
    

//    NSLog(@"NSIntegerMin -- %ld", NSIntegerMin);

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    NSString *str = @"苗";
    NSLog(@"苗first -- %c", [str ex_firstLetter]);
    str = @"士";
    NSLog(@"士first -- %c", [str ex_firstLetter]);
    str = @"xinhai";
    NSLog(@"昌first -- %c", [str ex_firstLetter]);
    NSLog(@"UUID--%@", [NSString ex_generateUUID]);
    NSLog(@"UUID string--%@", [NSString ex_generateUUIDString]);
    str = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
