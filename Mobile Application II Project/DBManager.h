//
//  DBManager.h
//  DatabaseApp
//
//  Created by ituser on 4/1/2015.
//  Copyright (c) 2015 GBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
@property(strong,nonatomic)NSString* databasePath;

+(DBManager*)getSharedInstance;

-(BOOL)createDB;
-(BOOL)saveData:(NSString*)regNum name:(NSString*)name department:(NSString*)department year:(NSString*)year;
-(NSArray*)findByRegNumber:(NSString*)regNum;

@end
