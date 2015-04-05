//
//  ViewController.m
//  Mobile Application II Project
//  Maps tutorial http://www.techotopia.com/index.php/Working_with_Maps_on_iOS_7_with_MapKit_and_the_MKMapView_Class
//  Created by Kirill Aliaev on 2015-03-13.
//  Copyright (c) 2015 COMP3097. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textLink;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPasswd;
@end



@implementation ViewController


- (IBAction)btnDisplay:(id)sender {
}
- (IBAction)btnDonloadAndDisplay:(id)sender {
}
- (IBAction)btnReset:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError *err = nil;
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"arrayList" ofType:@"json"];
    
    NSLog(@"Hello: %@", dataPath);
    
    NSArray *statements = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
    
    NSLog(@"Transaction list: %@", statements);
    NSLog(@"Error list: %@", err);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
