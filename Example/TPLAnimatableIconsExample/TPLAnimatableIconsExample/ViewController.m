//
//  ViewController.m
//  TPLAnimatableIconsExample
//
//  Created by Christoph Pageler on 23.02.15.
//  Copyright (c) 2015 Christoph Pageler. All rights reserved.
//

#import "ViewController.h"
#import <TPLAnimatableIcons/TPLAnimateableIcons.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet TPLAnimatableIconView *animatableView1;
@property (strong, nonatomic) NSArray *iconTypes;

@property (weak, nonatomic) IBOutlet UISwitch *switchState;
@property (weak, nonatomic) IBOutlet UIStepper *stepperLineWidth;
@property (weak, nonatomic) IBOutlet UITableView *tableViewTypes;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.iconTypes = @[
					   @(TPLAnimatableIconTypeHamburgerToCross),
					   @(TPLAnimatableIconTypeHamburgerToArrowLeft),
					   @(TPLAnimatableIconTypeHamburgerToArrowRight),
					   @(TPLAnimatableIconTypeHamburgerToArrowTop),
					   @(TPLAnimatableIconTypeHamburgerToArrowBottom),
					   @(TPLAnimatableIconTypeHamburgerToArrowTopRotation),
					   @(TPLAnimatableIconTypeHamburgerToArrowBottomRotation)
					   ];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.tableViewTypes selectRowAtIndexPath:[NSIndexPath indexPathForRow:0
																 inSection:0]
									 animated:NO
							   scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.iconTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
															forIndexPath:indexPath];
	
	TPLAnimatableIconType iconType = [self.iconTypes[indexPath.row] integerValue];
	cell.textLabel.text = NSStringFromTPLAnimatableIconType(iconType);
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TPLAnimatableIconType type = (TPLAnimatableIconType)indexPath.row;
	[self.animatableView1 animateToIconType:type];
}

- (IBAction)actionStateSwitch:(UISwitch *)sender
{
	[self.animatableView1 animateToState:sender.on ? TPLAnimatableIconState2 : TPLAnimatableIconState1];
}

- (IBAction)actionStepChanged:(UIStepper *)sender
{
	self.animatableView1.lineWidth = self.stepperLineWidth.value;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
