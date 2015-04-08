//
//  DisplayStatements.m
//  Mobile Application II Project
//
//  Created by Kirill Aliaev on 2015-04-05.
//  Copyright (c) 2015 COMP3097. All rights reserved.
//

#import "DisplayStatements.h"
#import "Statement.h"
#import "Statements.h"
#import "DBManager.h"

@implementation DisplayStatements

-(void)loadJSON{
   
    NSError *err = nil;
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"arrayList" ofType:@"json"];
    
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
                s._id = [statement objectForKey:key];
            }else if ([key isEqualToString:@"authority"]){
                s.actor = [[statement objectForKey:@"authority"] objectForKey:@"name"];
            }else if ([key isEqualToString:@"verb"]){
                s.verb = [[[statement objectForKey:@"verb"] objectForKey:@"display"] objectForKey:@"en-US"];
            }else if ([key isEqualToString:@"object"]){
                s.object = [[[[statement objectForKey:@"object"] objectForKey:@"definition"] objectForKey:@"description"] objectForKey:@"en-US"];
            }
            // NSLog(@"Statement list: %@", statement);
            NSLog(@"Id: %@", s._id);
            NSLog(@"Actor: %@", s.actor);
            NSLog(@"Verb: %@", s.verb);
            NSLog(@"Object: %@", s.object);
            
        }
        [stmnts.statements arrayByAddingObject:s];
        
    }
    if([dbm createDB]){
        NSLog(@"Db create success");
    }
    if ([dbm saveData:s._id actor:s.actor verb:s.verb object:s.object]){
        NSLog(@"Db save success");
    }

}

@end
