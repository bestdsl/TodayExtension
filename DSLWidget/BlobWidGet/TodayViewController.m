//
//  TodayViewController.m
//  BlobWidGet
//
//  Created by 董诗磊 on 2017/3/13.
//  Copyright © 2017年 董诗磊. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>


#import "DSLWidgetFramework.h"

#import "DSLNSLog.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //
    if ([[UIDevice currentDevice].systemVersion integerValue]>=10) {
        
         self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        
        
    }
    
    
    
    
    //先新建里一个lable
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    label.backgroundColor = [UIColor redColor];
    
    label.text = [self getDatafromMainAPP];
    
    [self.view addSubview:label];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(110, 0, 100, 100)];
    
    image.backgroundColor = [UIColor redColor];
    
    image.image = [self getImagefromMainAPP];
    
    [self.view addSubview:image];
    
    
    //代码共享模块
    [DSLNSLog DSLNSLogMethod:@"I'm is 董诗磊"];
    
    //跳转设置界面的快捷方式
    UIButton * SkipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    SkipBtn.frame = CGRectMake(image.frame.origin.x + image.frame.size.width +10, 0, 80, 30);
    
    [SkipBtn setTitle:@"蜂窝网络" forState:UIControlStateNormal];
    
    [SkipBtn addTarget:self  action:@selector(SkipAcstion) forControlEvents:UIControlEventTouchUpInside];
  
    [self.view addSubview:SkipBtn];
    
    //打开第二个VC
    UIButton * OpenSecondVC = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [OpenSecondVC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    OpenSecondVC.frame = CGRectMake(SkipBtn.frame.origin.x,SkipBtn.frame.origin.y + SkipBtn.frame.size.height +10, 80, 30);
    
    [OpenSecondVC setTitle:@"打开VC" forState:UIControlStateNormal];
    
    [OpenSecondVC addTarget:self  action:@selector(OpenAcstion) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:OpenSecondVC];

    
}

- (void)OpenAcstion{


    [self.extensionContext openURL:[NSURL URLWithString:@"DSLTodayWidget://SecondVC"]completionHandler:^(BOOL success) {
        
    }];


}

- (void)SkipAcstion{


    [self.extensionContext openURL:[NSURL URLWithString:@"Prefs:root=MOBILE_DATA_SETTINGS_ID"]completionHandler:^(BOOL success) {
        
    }];

}

#pragma mark从app那里加载数据以便达到数据共享的目的（NSFileManger 存图片）
- (UIImage *)getImagefromMainAPP{

  
    
    NSURL * contentURL = [[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.DSLBlobWidget"];
    
   contentURL = [contentURL URLByAppendingPathComponent:@"/Library/Caches/DSL.png"];
    
    NSData * data = [NSData dataWithContentsOfURL:contentURL];
    
    NSLog(@"======%@",data);
    
    return [UIImage imageWithData:data];

}

#pragma mark  从app那里加载数据以便达到数据共享的目的（NSUserDefaults）
- (NSString *)getDatafromMainAPP{

    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.DSLBlobWidget"];
    
    return [defaults objectForKey:@"DSL"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{

//    NCWidgetDisplayModeCompact, // Fixed height
//    NCWidgetDisplayModeExpanded,

    if (activeDisplayMode == NCWidgetDisplayModeCompact ) {
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width ,110);
        
    }else{
    
    //因为机子型号不一样所以最大搞多可能不一样，这里设置最大
    
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width ,MAXFLOAT);
    
    }

}

@end
