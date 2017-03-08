//
//  ViewController.m
//  Practice1
//
//  Created by 朱祐震 on 2017/3/8.
//  Copyright © 2017年 MCU. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *test;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview: self.test];
    
    NSLog(@"%@", self.test);
}

- (UIImageView *)test
{
    if (_test == nil) {
        UIImageView *test = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"00.JPG"]];
        [test setFrame:CGRectMake(0, 0, 60, 80)];
    }
    
    return _test;
}
@end
