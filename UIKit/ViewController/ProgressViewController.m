//
//  ProgressViewController.m
//  UIKit
//
//  Created by Touch on 9/8/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "ProgressViewController.h"
#import "KNLoadingProgress.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(10, 100, 320, 40);
    KNLoadingProgress *progress = [[KNLoadingProgress alloc] initWithFrame:frame];
    progress.numberOfDots = 3;
    progress.backgroundColor = [UIColor colorWithRed:1.000 green:0.705 blue:0.094 alpha:1.000];
    [self.view addSubview:progress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
