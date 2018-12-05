//
//  ViewController.m
//  DMHud
//
//  Created by Santiago on 2018/12/5.
//  Copyright © 2018 David. All rights reserved.
//

#import "ViewController.h"
#import "DMHud.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [DMHud setHudShowStyle:HudShowStyleEaseOut];
//    [DMHud setHudTextFont:12.f];
}

- (IBAction)showHud:(id)sender {
    NSString *tipString = @"提示：\n系统出现问题了，请您稍后重试!";
//    [DMHud showText:tipString];
    [DMHud showText:tipString withTimeInterval:5.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
