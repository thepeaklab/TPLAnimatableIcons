//
//  TPLAnimatableIcon.m
//  Pods
//
//  Created by Christoph Pageler on 23.02.15.
//
//

#import "TPLAnimatableIconView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface TPLAnimatableIconView()
{
	BOOL _didLayout;
}

@property (strong, nonatomic) NSDictionary *iconTypeSettings;
@property (strong, nonatomic) NSArray *lines;

@end

@implementation TPLAnimatableIconView

#pragma mark - Init

- (instancetype)init
{
	if (self = [super init]) {
		[self generalInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self generalInit];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self generalInit];
	}
	return self;
}

- (void)generalInit
{
	_didLayout = NO;
	
	_lineWidth = 4;
	_iconType = TPLAnimatableIconTypeHamburgerToCross;
	_iconState = TPLAnimatableIconState1;
	
	self.iconTypeSettings = @{
							  @(TPLAnimatableIconTypeHamburgerToCross): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(0)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   }
									  ]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowLeft): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   }
									  ]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowRight): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   }
									]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowTop): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(1.2)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   }
									  ]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowBottom): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(1.2)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(0)
									  },
									  @"lines": @[
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionTopRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleLeft)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionMiddleRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionTopCenter)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   },
											  @{
												  @"from": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomLeft),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionBottomCenter)
												  },
												  @"to": @{
														  @(TPLAnimatableIconState1): @(TPLAnimatableIconLinePositionBottomRight),
														  @(TPLAnimatableIconState2): @(TPLAnimatableIconLinePositionMiddleRight)
												  },
												  @"opacity": @{
														  @(TPLAnimatableIconState1): @(1),
														  @(TPLAnimatableIconState2): @(1)
												  }
											   }
									  ]
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowTopRotation): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(90)
									  },
									  @"lines": @{
											  @"copyLinesFromIconType": @(TPLAnimatableIconTypeHamburgerToArrowLeft)
									  }
							  },
							  @(TPLAnimatableIconTypeHamburgerToArrowBottomRotation): @{
									  @"numberOfLines": @(3),
									  @"aspectRatio": @{
											  @(TPLAnimatableIconState1): @(0.6),
											  @(TPLAnimatableIconState2): @(0.8)
									  },
									  @"scale": @{
											  @(TPLAnimatableIconState1): @(1),
											  @(TPLAnimatableIconState2): @(1)
									  },
									  @"rotation": @{
											  @(TPLAnimatableIconState1): @(0),
											  @(TPLAnimatableIconState2): @(-90)
									  },
									  @"lines": @{
											  @"copyLinesFromIconType": @(TPLAnimatableIconTypeHamburgerToArrowLeft)
									  }
							  }
	};
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	_didLayout = YES;
	
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:YES];
}

#pragma mark - Setter

- (void)setIconType:(TPLAnimatableIconType)iconType
{
	_iconType = iconType;
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:YES];
}

- (void)setIconState:(TPLAnimatableIconState)iconState
{
	[self animateToState:iconState
				animated:NO
		  updateIconType:NO];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
	_lineWidth = lineWidth;
	[self animateToState:self.iconState
				animated:NO
		  updateIconType:NO];
}

#pragma mark - Public Methods

- (void)animateToState:(TPLAnimatableIconState)state
{
	[self animateToState:state
				animated:YES
		  updateIconType:NO];
}

- (void)animateToIconType:(TPLAnimatableIconType)iconType
{
	NSUInteger newNumberOfStrokes = [self numberOfLinesForIconType:iconType];
	BOOL canAnimate = self.lines.count == newNumberOfStrokes;
	_iconType = iconType;
#warning reset state after icon type change ?!
	[self animateToState:self.iconState
				animated:canAnimate
		  updateIconType:self.iconType];
}

#pragma mark - Settings

- (NSDictionary *)settingsForIconType:(TPLAnimatableIconType)iconType
{
	return self.iconTypeSettings[@(iconType)];
}

- (NSInteger)numberOfLinesForIconType:(TPLAnimatableIconType)iconType
{
	return [[self settingsForIconType:iconType][@"numberOfLines"] integerValue];
}

- (CGFloat)aspectRationForIconType:(TPLAnimatableIconType)iconType
						 iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"aspectRatio"][@(iconState)] doubleValue];
}

- (CGFloat)scaleForIconType:(TPLAnimatableIconType)iconType
				  iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"scale"][@(iconState)] doubleValue];
}

- (CGFloat)rotationForIconType:(TPLAnimatableIconType)iconType
					 iconState:(TPLAnimatableIconState)iconState
{
	return [[self settingsForIconType:iconType][@"rotation"][@(iconState)] doubleValue];
}

#pragma mark Lines Settings

- (NSArray *)linesSettingsForIconType:(TPLAnimatableIconType)iconType
{
	id lines = [self settingsForIconType:iconType][@"lines"];
	if ([lines isKindOfClass:[NSArray class]]) {
		return lines;
	} else {
		NSDictionary *linesDict = lines;
		TPLAnimatableIconType copyFromIconType = [linesDict[@"copyLinesFromIconType"] integerValue];
		return [self linesSettingsForIconType:copyFromIconType];
	}
}

- (NSDictionary *)settingsForLineAtIndex:(NSUInteger)lineIndex
							withIconType:(TPLAnimatableIconType)iconType
{
	return [self linesSettingsForIconType:iconType][lineIndex];
}

- (TPLAnimatableIconLinePosition)lineFromPositionForLineAtIndex:(NSUInteger)lineIndex
												   withIconType:(TPLAnimatableIconType)iconType
													   forState:(TPLAnimatableIconState)state
{
	NSDictionary *lineDict = [self settingsForLineAtIndex:lineIndex withIconType:iconType];
	return [lineDict[@"from"][@(state)] integerValue];
}

- (TPLAnimatableIconLinePosition)lineToPositionForLineAtIndex:(NSUInteger)lineIndex
												 withIconType:(TPLAnimatableIconType)iconType
													 forState:(TPLAnimatableIconState)state
{
	NSDictionary *lineDict = [self settingsForLineAtIndex:lineIndex withIconType:iconType];
	return [lineDict[@"to"][@(state)] integerValue];
}

- (CGFloat)opacityForLineAtIndex:(NSUInteger)lineIndex
					withIconType:(TPLAnimatableIconType)iconType
						forState:(TPLAnimatableIconState)state
{
	NSDictionary *lineDict = [self settingsForLineAtIndex:lineIndex withIconType:iconType];
	return [lineDict[@"opacity"][@(state)] doubleValue];
}


#pragma mark - Animations

- (void)animateToState:(TPLAnimatableIconState)state
			  animated:(BOOL)animated
		updateIconType:(BOOL)updateIconType
{
	_iconState = state;
	
	if (!_didLayout) { return; }
	if (updateIconType) {
		
		if (self.lines.count != [self numberOfLinesForIconType:self.iconType]) {
			
			// remove all old layers
			for (CAShapeLayer *shapeLayer in self.lines) {
				[shapeLayer removeFromSuperlayer];
			}
			
			// create new layers for current iconType
			NSMutableArray *mutableLines = [NSMutableArray array];
			for (int i = 0; i < [self numberOfLinesForIconType:self.iconType]; i++) {
				[mutableLines addObject:[[CAShapeLayer alloc] init]];
			}
			self.lines = [NSArray arrayWithArray:mutableLines];
			mutableLines = nil;
			
			// add new layers to views' layer
			for (CAShapeLayer *shapeLayer in self.lines) {
				[self.layer addSublayer:shapeLayer];
			}

		}
	}
	
	// update non animatable properties
	for (CAShapeLayer *shapeLayer in self.lines) {
		shapeLayer.lineWidth = self.lineWidth;
		
		shapeLayer.strokeColor = self.tintColor.CGColor;
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
		
		shapeLayer.lineCap = kCALineCapRound;
	}
	
	CGPoint(^pointFromLinePosition)(TPLAnimatableIconLinePosition, CGRect) = ^(TPLAnimatableIconLinePosition position, CGRect b) {
		
		CGPoint pointTopLeft = CGPointMake(b.origin.x, b.origin.y);
		CGPoint pointTopCenter = CGPointMake(b.origin.x + b.size.width /  2, b.origin.y);
		CGPoint pointTopRight = CGPointMake(b.origin.x + b.size.width, b.origin.y);
		
		CGPoint pointMiddleLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height / 2);
		CGPoint pointMiddleCenter = CGPointMake(b.origin.x + b.size.width / 2, b.origin.y + b.size.height / 2);
		CGPoint pointMiddleRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height / 2);
		
		CGPoint pointBottomLeft = CGPointMake(b.origin.x, b.origin.y + b.size.height);
		CGPoint pointBottomCenter = CGPointMake(b.origin.x + b.size.width / 2, b.origin.y + b.size.height);
		CGPoint pointBottomRight = CGPointMake(b.origin.x + b.size.width, b.origin.y + b.size.height);
		
		switch (position) {
			case TPLAnimatableIconLinePositionTopLeft:
			{
				return pointTopLeft;
			}
			case TPLAnimatableIconLinePositionTopCenter:
			{
				return pointTopCenter;
			}
			case TPLAnimatableIconLinePositionTopRight:
			{
				return pointTopRight;
			}
			case TPLAnimatableIconLinePositionMiddleLeft:
			{
				return pointMiddleLeft;
			}
			case TPLAnimatableIconLinePositionMiddleCenter:
			{
				return pointMiddleCenter;
			}
			case TPLAnimatableIconLinePositionMiddleRight:
			{
				return pointMiddleRight;
			}
			case TPLAnimatableIconLinePositionBottomLeft:
			{
				return pointBottomLeft;
			}
			case TPLAnimatableIconLinePositionBottomCenter:
			{
				return pointBottomCenter;
			}
			case TPLAnimatableIconLinePositionBottomRight:
			{
				return pointBottomRight;
			}
		}
	};
	
	// update animatable properties
	void(^lineAnimationsBlock)(CAShapeLayer *, NSInteger, CGRect) = ^(CAShapeLayer *shapeLayer, NSInteger idx, CGRect innerBounds)
	{
		
		CGPoint lineFromPoint, lineToPoint;
		
		// Line Position (from, to)
		TPLAnimatableIconLinePosition fromPosition = [self lineFromPositionForLineAtIndex:idx
																			 withIconType:self.iconType
																				 forState:self.iconState];
		TPLAnimatableIconLinePosition toPosition = [self lineToPositionForLineAtIndex:idx
																		 withIconType:self.iconType
																			 forState:self.iconState];
		
		lineFromPoint = pointFromLinePosition(fromPosition, innerBounds);
		lineToPoint = pointFromLinePosition(toPosition, innerBounds);
		
		// Line Opacity
		CGFloat opacity = [self opacityForLineAtIndex:idx
										 withIconType:self.iconType
											 forState:self.iconState];
		
		UIBezierPath *shapeLayerPath = [UIBezierPath bezierPath];
		[shapeLayerPath moveToPoint:lineFromPoint];
		[shapeLayerPath addLineToPoint:lineToPoint];
		
		shapeLayer.path = shapeLayerPath.CGPath;
		shapeLayer.opacity = opacity;
		
	};
	
	void(^layerAnimationsBlock)(void) = ^(void) {
		
		CGFloat rotation = [self rotationForIconType:self.iconType
										   iconState:self.iconState];
		
		[self.layer setValue:@(DEGREES_TO_RADIANS(rotation))
				  forKeyPath:@"transform.rotation.z"];
		
	};
	
	// Find inner bounding H = W
	CGFloat l = MIN(self.frame.size.width, self.frame.size.height);
	CGSize s = CGSizeMake(l, l);
	

	
	// Different aspect rations for states
	// ... hamburger H != W, Cross H == W
	
	// 0.5 -> height/2 == width
	CGFloat aspectRatio = [self aspectRationForIconType:self.iconType
											  iconState:self.iconState];
	
	// apply aspect ratio
	s.height *= aspectRatio;
	
	
	// Different scales for states
	CGFloat scale = [self scaleForIconType:self.iconType
								 iconState:self.iconState];
	
	// apply scale
	s.height *= scale;
	s.width *= scale;
	
	
	// re-center bounds
	CGRect innerBounds = CGRectMake(self.frame.size.width / 2 - s.width / 2,
									self.frame.size.height / 2 - s.height / 2,
									s.width, s.height);
	
	
	if (animated) {
		
		CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		CFTimeInterval duration = 0.25;
		
		[self.lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			
			CAShapeLayer *shapeLayer = obj;
			
			NSDictionary *animatedProperties = @{
												 @"opacity": @(shapeLayer.opacity),
												 @"path": (__bridge id)shapeLayer.path
												 };
			
			NSMutableDictionary *animations = [NSMutableDictionary dictionary];
			
			// Prepare animations from values
			for (NSString *propertyKey in [animatedProperties allKeys]) {
				CABasicAnimation *shapeLayerAnimation = [CABasicAnimation animationWithKeyPath:propertyKey];
				shapeLayerAnimation.duration = duration;
				shapeLayerAnimation.timingFunction = timingFunction;
				
				// Set From to current value of presentation layer
				id currentValue = [((CAShapeLayer *)shapeLayer.presentationLayer) valueForKeyPath:propertyKey];
				shapeLayerAnimation.fromValue = currentValue;
				
				// remember animation in dict
				animations[propertyKey] = shapeLayerAnimation;
			}
			
			
			// modify layer
			lineAnimationsBlock(obj, idx, innerBounds);
			
			// finish animations to values
			for (NSString *propertyKey in [animatedProperties allKeys]) {
				// fetch remembered animation from block
				CABasicAnimation *shapeLayerAnimation = animations[propertyKey];
				
				// Update to values to new values
				shapeLayerAnimation.toValue = [shapeLayer valueForKeyPath:propertyKey];
				[shapeLayer addAnimation:shapeLayerAnimation forKey:propertyKey];
			}
			
			animatedProperties = nil;
			animations = nil;
			
		}];
		
		
		CABasicAnimation *layerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
		layerAnimation.duration = duration;
		layerAnimation.timingFunction = timingFunction;
		
		// Set From to current value of presentation layer
		id currentValue = [((CAShapeLayer *)self.layer.presentationLayer) valueForKeyPath:@"transform.rotation.z"];
		layerAnimation.fromValue = currentValue;
		
		layerAnimationsBlock();
		
		layerAnimation.toValue = [self.layer valueForKeyPath:@"transform.rotation.z"];
		[self.layer addAnimation:layerAnimation forKey:@"transform.rotation.z"];
		
		
	} else {
		
		[self.lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			lineAnimationsBlock(obj, idx, innerBounds);
		}];
		
		layerAnimationsBlock();
	}
}

@end

NSString *NSStringFromTPLAnimatableIconType(TPLAnimatableIconType iconType)
{
	switch (iconType) {
		case TPLAnimatableIconTypeHamburgerToCross:
		{
			return @"HamburgerToCross";
		}
		case TPLAnimatableIconTypeHamburgerToArrowLeft:
		{
			return @"HamburgerToArrowLeft";
		}
		case TPLAnimatableIconTypeHamburgerToArrowRight:
		{
			return @"HamburgerToArrowRight";
		}
		case TPLAnimatableIconTypeHamburgerToArrowTop:
		{
			return @"HamburgerToArrowTop";
		}
		case TPLAnimatableIconTypeHamburgerToArrowBottom:
		{
			return @"HamburgerToArrowBottom";
		}
		case TPLAnimatableIconTypeHamburgerToArrowTopRotation:
		{
			return @"HamburgerToArrowTopRotation";
		}
		case TPLAnimatableIconTypeHamburgerToArrowBottomRotation:
		{
			return @"HamburgerToArrowBottomRotation";
		}
	}
}
