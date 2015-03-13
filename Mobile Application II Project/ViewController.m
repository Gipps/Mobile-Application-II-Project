//
//  ViewController.m
//  Mobile Application II Project
//
//  Created by Kirill Aliaev on 2015-03-13.
//  Copyright (c) 2015 COMP3097. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
NSMutableDictionary *lrs;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    lrs = [ [NSMutableDictionary alloc] init];
    [lrs setValue:@"https://cloud.scorm.com/tc/24YOP10U8J/" forKey:@"endpoint"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
