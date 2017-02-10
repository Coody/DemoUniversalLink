//
//  ViewController.m
//  DemoUniversalLink
//
//  Created by Coody on 2017/2/10.
//  Copyright © 2017年 Coody. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pressDown:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
