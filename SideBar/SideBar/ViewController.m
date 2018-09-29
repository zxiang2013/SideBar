//
//  ViewController.m
//  SideBar
//
//  Created by dbc61 on 2018/9/29.
//  Copyright © 2018年 ZZZ. All rights reserved.
//

#import "ViewController.h"
#import "SideBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(click)];
}

- (void)click {
    /// 预先截图
    SideBarViewController *vc = [SideBarViewController new];
    vc.backgroundView = [self screenShot];
    [self.navigationController pushViewController:vc animated:NO];
}

- (UIImage *)screenShot {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    UIImage *shot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return shot;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
