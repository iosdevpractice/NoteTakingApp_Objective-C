//
//  Note.h
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSDate *modificationDate;

@end
