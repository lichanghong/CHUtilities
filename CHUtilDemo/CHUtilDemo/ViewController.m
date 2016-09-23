//
//  ViewController.m
//  CHUtilDemo
//
//  Created by lichanghong on 16/9/21.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "ViewController.h"
#import <CHUtilities/CHUtilities.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LogManager defaultManager];
    DDLogInfo(@"logtest");
    [self.view makeToast:@"hehe"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
