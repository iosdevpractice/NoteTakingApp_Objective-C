//
//  Note.m
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import "Note.h"

NSString * const noteContentKey = @"noteContentKey";
NSString * const noteModificationDateKey = @"noteModificationDateKey";

@interface Note () <NSCoding>

@property (nonatomic, readwrite) NSDate *modificationDate;

@end

@implementation Note

#pragma mark - initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modificationDate = [[NSDate alloc] init];
    }
    return self;
}

#pragma mark - accessors

- (void)setContent:(NSString *)content
{
    self.modificationDate = [[NSDate alloc] init];
    _content = [content copy];
}

- (NSString *)title
{
    NSString *content = self.content;
    NSString *title = content;
    
    NSInteger index = [content rangeOfString:@"\n"].location;
    if (index != NSNotFound) {
        title = [content substringToIndex:index];
    }
    return title;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.content forKey:noteContentKey];
    [coder encodeObject:self.modificationDate forKey:noteModificationDateKey];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _content = [coder decodeObjectForKey:noteContentKey];
        _modificationDate = [coder decodeObjectForKey:noteModificationDateKey];
    }
    return self;
}

@end
