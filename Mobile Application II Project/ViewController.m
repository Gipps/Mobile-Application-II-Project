//
//  ViewController.m
//  Mobile Application II Project
//  Maps tutorial http://www.techotopia.com/index.php/Working_with_Maps_on_iOS_7_with_MapKit_and_the_MKMapView_Class
//  Created by Kirill Aliaev on 2015-03-13.
//  Copyright (c) 2015 COMP3097. All rights reserved.
//

#import "ViewController.h"
#import "Statement.h"
#import "Statements.h"
#import "DBManager.h"

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
    Statement* s = [Statement new];
    Statements* stmnts = [Statements new];
    DBManager* dbm = [DBManager new];
    
    stmnts.statements = [[NSArray alloc] init];
    
    for (int i = 0; i < statements.count; i++) {
        NSDictionary* statement = [statements objectAtIndex:i];
        
        for(NSString *key in [statement allKeys]){
            if([key isEqualToString:@"id"]){
                s.iD = [statement objectForKey:key];
            }else if ([key isEqualToString:@"authority"]){
                s.actor = [[statement objectForKey:@"authority"] objectForKey:@"name"];
            }else if ([key isEqualToString:@"verb"]){
                s.verb = [[[statement objectForKey:@"verb"] objectForKey:@"display"] objectForKey:@"en-US"];
            }else if ([key isEqualToString:@"object"]){
                s.object = [[[[statement objectForKey:@"object"] objectForKey:@"definition"] objectForKey:@"description"] objectForKey:@"en-US"];
            }
           // NSLog(@"Statement list: %@", statement);
            NSLog(@"Id: %@", s.iD);
            NSLog(@"Actor: %@", s.actor);
            NSLog(@"Verb: %@", s.verb);
            NSLog(@"Object: %@", s.object);
           
        }
        [stmnts.statements arrayByAddingObject:s];
        
        }
    if([dbm createDB]){
        NSLog(@"Db create success");
    }
    if ([dbm saveData:s.iD actor:s.actor verb:s.verb object:s.object]){
        NSLog(@"Db save success");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
