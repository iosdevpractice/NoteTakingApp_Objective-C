//
//  DetailViewController.h
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Note *note;
@property (nonatomic, copy) void (^completionBlock)(void);
@property (nonatomic, getter=isNewNote) BOOL newNote;

@end
