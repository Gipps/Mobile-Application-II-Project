//
//  DBManager.m
//  DatabaseApp
//
//  Created by ituser on 4/1/2015.
//  Copyright (c) 2015 GBC. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>

static DBManager* sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager
+(DBManager*)getSharedInstance{

    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    
    return sharedInstance;
}

-(BOOL)createDB{

    NSString* docDir;
    NSArray* dirPaths;

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    docDir = dirPaths[0];

    self.databasePath = [[NSString alloc]initWithString:[docDir stringByAppendingString:@"student.db"]];
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:self.databasePath]==NO) {
        const char* dbpath = [self.databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
            
            char* errMsg;
            char* sql_stmt = "create table if not exists student(regNo integer primary key, name text, department text, year text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            
        }else{
            isSuccess = NO;
            NSLog(@"Failed to create database");
        }
    }
    
    return isSuccess;
    
}
-(BOOL)saveData:(NSString*)regNum name:(NSString*)name department:(NSString*)department year:(NSString*)year{

    const char* dbpath = [self.databasePath UTF8String];
    BOOL isSuccess = YES;
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        
        NSString* insertSQL = [NSString stringWithFormat:@"insert into student(regNo, name, department, year) values (\"%d\", \"%@\", \"%@\", \"%@\")",[regNum intValue], name, department, year];
        
        const char* sql_stmt = [insertSQL UTF8String];
        
        if(sqlite3_prepare_v2(database, sql_stmt, -1, &statement,NULL)==SQLITE_OK){
            if (sqlite3_step(statement)==SQLITE_DONE) {
                isSuccess = YES;
            }else{
                isSuccess = NO;
                NSLog(@"Failed to execute query");
            }
        
        }else{
            isSuccess = NO;
            NSLog(@"Could not parse the query: %@\n", insertSQL);
        }
        
    }else{
        isSuccess=NO;
        NSLog(@"Failed to open database");
    }

    sqlite3_reset(statement);
    sqlite3_close(database);
    return isSuccess;
}

-(NSArray*)findByRegNumber:(NSString*)regNum{
    BOOL isSuccess = YES;
    NSMutableArray* result = nil;
    
    const char* dbpath = [self.databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"select name, department, year from student where regNo=\"%@\"", regNum];
        
        const char* sql_stmt = [query UTF8String];
        if (sqlite3_prepare_v2(database, sql_stmt, -1, &statement, NULL)==SQLITE_OK) {
            if (sqlite3_step(statement)==SQLITE_ROW) {
                
                result = [NSMutableArray new];
                NSString* name = [[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                NSString* department = [[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
                NSString* year = [[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
                
                [result addObject:name];
                [result addObject:department];
                [result addObject:year];
                
            }else{
                isSuccess=NO;
                NSLog(@"Not found");
            }
        }else{
            isSuccess=NO;
            NSLog(@"Failed to parse query: %@", query);
        }
        
        
    }else{
        isSuccess=NO;
        NSLog(@"Failed to open database");
    }
    
    sqlite3_reset(statement);
    sqlite3_close(database);
    return result;
}

@end
