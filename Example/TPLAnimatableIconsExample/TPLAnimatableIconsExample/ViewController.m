//
//  ViewController.m
//  TPLAnimatableIconsExample
//
//  Created by Christoph Pageler on 23.02.15.
//  Copyright (c) 2015 Christoph Pageler. All rights reserved.
//

#import "ViewController.h"
#import <TPLAnimatableIcons/TPLAnimateableIcons.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TPLAnimatableIconView *animateableView;
@property (weak, nonatomic) IBOutlet UISwitch *switchState;
@property (weak, nonatomic) IBOutlet UIStepper *stepperStrokeWidth;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.animateableView.iconType = TPLAnimatableIconTypeHamburgerToCross;
	self.animateableView.strokeWidth = self.stepperStrokeWidth.value;
}

- (IBAction)actionIconTypeChanged:(UISegmentedControl *)sender
{
	switch (sender.selectedSegmentIndex) {
		case 0:
		{
			self.animateableView.iconType = TPLAnimatableIconTypeHamburgerToCross;
			break;
		}
		case 1:
		{
			self.animateableView.iconType = TPLAnimatableIconTypeHamburgerToArrowLeft;
			break;
		}
	}
}

- (IBAction)actionStateSwitch:(UISwitch *)sender
{
	[self.animateableView animateToState:sender.on ? TPLAnimatableIconState1 : TPLAnimatableIconState2];
}

- (IBAction)actionStepChanged:(UIStepper *)sender
{
	self.animateableView.strokeWidth = self.stepperStrokeWidth.value;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
