//
//  SecondVC.m
//  DSLWidget
//
//  Created by 董诗磊 on 2017/3/14.
//  Copyright © 2017年 董诗磊. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第二VC";
    
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
    //打开第二个VC
    UIButton * closeVC = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeVC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    closeVC.frame = CGRectMake(50,110, 80, 30);
    
    [closeVC setTitle:@"关闭VC" forState:UIControlStateNormal];
    
    [closeVC addTarget:self  action:@selector(CloseAcstion) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:closeVC];

}

- (void)CloseAcstion
{


    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
