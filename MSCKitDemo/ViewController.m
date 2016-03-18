//
//  ViewController.m
//  MSCKitDemo
//
//  Created by MiaoShichang on 15/10/29.
//  Copyright © 2015年 MiaoShichang. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+MSCKit.h"
#import "UIViewDrawRect.h"
#import "MSCApp.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
//    UIImage *image = [UIImage imageNamed:@"image_v.png"];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    imageView.image = image;
//    [self.view addSubview:imageView];
    
    
    UIViewDrawRect *drawView = [[UIViewDrawRect alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    drawView.text = @"hello world!";
    drawView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:drawView];
    
    NSLog(@"%@ --- %@ --- %@",[MSCApp appName], [MSCApp appVersion], [MSCApp appBuildVersion]);
    
    [MSCApp onFirstStartAPPForCurrentVersion:^(BOOL isFirst) {
        
    }];
    
    MSCB *b = [[MSCB alloc]init];
    b = nil;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
