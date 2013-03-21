//
//  PhotosByPhotographerCDTVC.h
//  Photomania
//
//  Created by Alex Paul on 3/20/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//
//  Can do "setImageURL:" segue and will call said method in destination VC.

#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerCDTVC : CoreDataTableViewController
@property (nonatomic, strong) Photographer *photographer;  
@end
