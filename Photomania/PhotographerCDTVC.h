//
//  PhotographerCDTVC.h
//  Photomania
//
//  Created by Alex Paul on 3/18/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//
//  Can do "setPhotographer:" segue and will call said method in destination VC.

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface PhotographerCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
