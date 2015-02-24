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

@property (weak, nonatomic) IBOutlet TPLAnimatableIconView *animatableView1;

@property (weak, nonatomic) IBOutlet UISwitch *switchState;
@property (weak, nonatomic) IBOutlet UIStepper *stepperStrokeWidth;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.animatableView1.iconType = TPLAnimatableIconTypeHamburgerToCross;
	self.animatableView1.lineWidth = self.stepperStrokeWidth.value;
	
}

- (IBAction)actionIconTypeChanged:(UISegmentedControl *)sender
{
	switch (sender.selectedSegmentIndex) {
		case 0:
		{
			self.animatableView1.iconType = TPLAnimatableIconTypeHamburgerToCross;
			break;
		}
		case 1:
		{
			self.animatableView1.iconType = TPLAnimatableIconTypeHamburgerToArrowLeft;
			break;
		}
		case 2:
		{
			self.animatableView1.iconType = TPLAnimatableIconTypeHamburgerToArrowTopRotation;
			break;
		}
	}
}

- (IBAction)actionStateSwitch:(UISwitch *)sender
{
	[self.animatableView1 animateToState:sender.on ? TPLAnimatableIconState1 : TPLAnimatableIconState2];
}

- (IBAction)actionStepChanged:(UIStepper *)sender
{
	self.animatableView1.lineWidth = self.stepperStrokeWidth.value;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
