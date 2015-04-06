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
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    _textPasswd.secureTextEntry = YES;
    
    NSError *err = nil;
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"arrayList" ofType:@"json"];
    
    NSLog(@"JSON Path: %@", dataPath);
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
    
    NSArray* statements = [json objectForKey:@"statements"];
    NSDictionary* statement = [statements objectAtIndex:0];
    
    NSString* actor = [[statement objectForKey:@"actor"] objectForKey:@"objectType"];
    NSString* verb = [[[statement objectForKey:@"verb"] objectForKey:@"display"] objectForKey:@"en-US"];
    NSString* object = [[[[statement objectForKey:@"object"] objectForKey:@"definition"] objectForKey:@"description"] objectForKey:@"en-US"];
    
    NSLog(@"Statement list: %@", statement);
    NSLog(@"Actor list: %@", actor);
    NSLog(@"Verb list: %@", verb);
    NSLog(@"Object list: %@", object);


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
