//
//  ViewController.m
//  DawingLine
//
//  Created by Zuo.Kevin on 2017/7/14.
//  Copyright © 2017年 Zuo.Kevin. All rights reserved.
//

#import "ViewController.h"
#import "DrawingBoardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    DrawingBoardView *view = [[DrawingBoardView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
