//
//  ViewController.m
//  Mobile Application II Project
//
//  Created by Kirill Aliaev on 2015-03-13.
//  Copyright (c) 2015 COMP3097. All rights reserved.
//

#import "ViewController.h"
#import "RSTinCanConnector.h"
#import "TCLRS.h"
#import "RSTinCanOfflineConnector.h"

@interface ViewController (){
    NSDictionary *options;
}

@end

RSTinCanConnector* connector;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
