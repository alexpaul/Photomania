//
//  AttributedStringViewController.m
//  Shutterbug
//
//  Created by Alex Paul on 3/2/13.
//  Copyright (c) 2013 Alex Paul. All rights reserved.
//

#import "AttributedStringViewController.h"

@interface AttributedStringViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation AttributedStringViewController

- (void)setText:(NSAttributedString *)text
{
    _text = text;
    self.textView.attributedText = text; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.attributedText = self.text; 
}


@end
