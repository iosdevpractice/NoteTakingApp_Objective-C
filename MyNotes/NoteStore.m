//
//  NoteStore.m
//  MyNotes
//
//  Created by Wiley Wimberly on 7/31/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import "NoteStore.h"

NSString * const noteStoreSaveFile = @"notes.data";

@interface NoteStore ()

@property (nonatomic, readonly) NSURL *savePath;

@end

@implementation NoteStore

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSData *notesData = [NSData dataWithContentsOfURL:self.savePath];
        
        if (notesData) {
            _notes = [[NSKeyedUnarchiver unarchiveObjectWithData:notesData]
                      mutableCopy];
        } else {
            _notes = [[NSMutableArray alloc] init];
        }
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(save)
         name:UIApplicationWillResignActiveNotification
         object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - accessors

- (NSURL *)savePath {
    
    return [[[[NSFileManager defaultManager]
              URLsForDirectory:NSDocumentDirectory
              inDomains:NSUserDomainMask]
             lastObject]
            URLByAppendingPathComponent:noteStoreSaveFile];
}

#pragma mark -

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.notes];
    [data writeToURL:self.savePath atomically:YES];
}

@end
