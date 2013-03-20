//
//  PhotosByPhotographerCDTVC.h
//  Photomania
//
//  Created by Alex Paul on 3/20/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerCDTVC : CoreDataTableViewController
@property (nonatomic, strong) Photographer *photographer;  
@end
