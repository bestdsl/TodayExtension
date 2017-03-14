//
//  ViewController.m
//  DSLWidget
//
//  Created by 董诗磊 on 2017/3/10.
//  Copyright © 2017年 董诗磊. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *DSLTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"document Path %@",NSHomeDirectory());
    
    self.DSLTF.placeholder = @"输入文字";
    
    [self.DSLTF addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventEditingChanged];
    
    //保存图片
    [self copyImageToLibrary];
    
    
    
}

//copy image to Library
- (void)copyImageToLibrary{

    NSString * path = [[NSBundle mainBundle]pathForResource:@"DSL.png" ofType:nil];

    NSFileManager * manger = [NSFileManager defaultManager];
    
    NSString * documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/DSL.png"];
    
    NSLog(@"%@",documentPath);
    
    NSError * error = nil;
    
    if (path != nil) {
        
        if (![manger fileExistsAtPath:documentPath]) {
            
            [manger copyItemAtPath:path toPath:documentPath error:&error];
            
            if (error) {
                
       NSLog(@"==copy error==%@",[error
                                localizedDescription]);
                
            }
            
        }
        
        
    }else{
        
        NSLog(@"sourcePath is nil");
        
    }


 [self copyImage];

}

#pragma mark从app那里加载数据以便达到数据共享的目的（NSFileManger 存图片）
- (void)copyImage{
    
    NSError * error = nil;
    
    NSURL * contentURL = [[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.DSLBlobWidget"];
    
    NSString * newPath = [contentURL URLByAppendingPathComponent:@"/Library/Caches/DSL.png"].path;
    
    [[NSFileManager defaultManager]copyItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/DSL.png"] toPath:newPath error:&error];
    
    if (error) {
        
        NSLog(@"copy error==%@",[error localizedDescription]);
 
    }
    
   


}


#pragma mark 存储data
- (void)saveData:(UITextField *)TF{


    NSUserDefaults * defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.DSLBlobWidget"];
    
    [defaults setObject:TF.text forKey:@"DSL"];
    
    [defaults synchronize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
