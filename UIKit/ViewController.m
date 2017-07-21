//
//  ViewController.m
//  UIKit
//
//  Created by Touch on 9/8/16.
//  Copyright © 2016 ___Touch___. All rights reserved.
//

#import "ViewController.h"

#import "WaveViewController.h"
#import "SpiningViewController.h"
#import "ProgressViewController.h"

static NSString *kReuseIdentifer    = @"kReuseIdentifer";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray       *viewTypes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _viewTypes = @[@"Progress View",
                   @"Wave Animation",
                   @"Spinning Animation"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifer];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifer forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = _viewTypes[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *nextController = nil;
    
    if (indexPath.row == 0) {
        nextController = [[ProgressViewController alloc] init];
    }
    else if (indexPath.row == 1) {
        nextController = [[WaveViewController alloc] init];
    }
    else if (indexPath.row == 2) {
        nextController = [[SpiningViewController alloc] init];
    }
    
    [self.navigationController pushViewController:nextController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

@end
