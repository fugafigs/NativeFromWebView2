//
//  ViewController.m
//  Sample
//
//  Created by 波切 賢一 on 12/06/28.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)modal_tapped:(id)sender {
    WebViewController *controller = [[ WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil ];
    
    [ self presentModalViewController:controller  animated:YES ];
}
@end
