Object subclass: #DiceBag
	instanceVariableNames: 'dice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dice'!
!DiceBag commentStamp: '<historical>' prior: 0!
wtf!


!DiceBag methodsFor: 'comparing' stamp: 'Anonymous 10/23/2018 17:59'!
= aDiceBag
	^ self asString = aDiceBag asString! !

!DiceBag methodsFor: 'comparing' stamp: 'Anonymous 10/23/2018 17:58'!
hash
	^ dice hash! !


!DiceBag methodsFor: 'accessing' stamp: 'Anonymous 10/21/2018 19:04'!
bag
	^ dice! !

!DiceBag methodsFor: 'accessing' stamp: 'Anonymous 10/21/2018 18:48'!
diceCount
	^ dice size.! !


!DiceBag methodsFor: 'adding' stamp: 'Anonymous 10/21/2018 18:40'!
addDie: aDie
	dice add: aDie! !

!DiceBag methodsFor: 'adding' stamp: 'Anonymous 10/21/2018 19:18'!
+ aBag
	| newBag |
	newBag := DiceBag new.
	self bag do: [ :die | newBag addDie: die ].	
	aBag bag do: [ :die | newBag addDie: die ].
	^ newBag! !


!DiceBag methodsFor: 'initialization' stamp: 'Anonymous 10/21/2018 18:59'!
initialize
	super initialize.
	dice := Bag new! !


!DiceBag methodsFor: 'printing' stamp: 'Anonymous 10/22/2018 17:59'!
printOn: aStream
	| count counter |
	count := dice valuesAndCounts size.
	counter := 0.
	dice
		keysAndValuesDo: [ :die :size | 
			aStream
				nextPutAll: size asString;
				nextPutAll: 'D';
				nextPutAll: die faces asString.
			counter := counter + 1.
			counter < count
				ifTrue: [ aStream nextPutAll: ' + ' ] .]! !


!DiceBag methodsFor: 'actions' stamp: 'Anonymous 10/21/2018 18:46'!
roll
	| sum |
	sum := 0.
	dice do: [ :die | sum := sum + die roll ].
	^ sum! !


TestCase subclass: #DiceBagTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dice'!
!DiceBagTest commentStamp: '<historical>' prior: 0!
rofl
!


!DiceBagTest methodsFor: 'tests' stamp: 'Anonymous 10/22/2018 18:02'!
testDiceCount
	| bag |
	bag := DiceBag new.
	self assert: bag diceCount equals: 0.
	bag addDie: Die new.
	self assert: bag diceCount equals: 1.
	bag addDie: Die new.
	self assert: bag diceCount equals: 2! !

!DiceBagTest methodsFor: 'tests' stamp: 'Anonymous 10/23/2018 18:08'!
testSum
	| bag1 bag2 bagSum |
	bag1 := DiceBag new.
	bag1 addDie: (Die withFaces: 2).
	bag1 addDie: (Die withFaces: 2).
	bag2 := DiceBag new.
	bag2 addDie: (Die withFaces: 3).
	bag2 addDie: (Die withFaces: 5).
	bagSum := bag1 + bag2.
	self assert: (bag1 bag allSatisfy: [ :each | bagSum bag includes: each ]).
	self assert: (bag2 bag allSatisfy: [ :each | bagSum bag includes: each ]).
	self assert: bag1 + bag2 = bagSum! !

!DiceBagTest methodsFor: 'tests' stamp: 'Anonymous 10/22/2018 18:07'!
testRollDice
	| bag roll |
	1 to: 5 do: [ :i | 
		bag := DiceBag new.
		1 to: i do: [ :j | bag addDie: (Die withFaces: 6) ].
		1 to: 100 do: [ :j | 
			roll := bag roll.
			self assert: roll >= 1 & ((roll <= (i * 6))) ] ]! !

!DiceBagTest methodsFor: 'tests' stamp: 'Anonymous 10/22/2018 18:09'!
testPrint
	| bag |
	bag := DiceBag new.
	bag addDie: (Die withFaces: 2).
	bag addDie: (Die withFaces: 2).
	bag addDie: (Die withFaces: 3).
	bag addDie: (Die withFaces: 4).
	self assert: bag asString equals: '2D2 + 1D3 + 1D4'.
	bag addDie: (Die withFaces: 5).
	self assert: bag asString equals: '2D2 + 1D3 + 1D4 + 1D5'.
	bag addDie: (Die withFaces: 5).
	self assert: bag asString equals: '2D2 + 1D3 + 1D4 + 2D5'! !

!DiceBagTest methodsFor: 'tests' stamp: 'Anonymous 10/22/2018 18:02'!
testAddDice
	| bag |
	bag := DiceBag new.
	self assert: bag bag size equals: 0.
	bag addDie: Die new.
	self assert: bag bag size equals: 1.
	bag addDie: Die new.
	self assert: bag bag size equals: 2! !


Object subclass: #Die
	instanceVariableNames: 'faces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dice'!
!Die commentStamp: '<historical>' prior: 0!
omfg!


!Die methodsFor: 'comparing' stamp: 'Anonymous 10/22/2018 16:45'!
= aDie
	^ self asString = aDie asString! !

!Die methodsFor: 'comparing' stamp: 'Anonymous 10/22/2018 16:46'!
hash
	^ faces hash! !


!Die methodsFor: 'actions' stamp: 'Anonymous 10/21/2018 18:02'!
roll
	^ faces atRandom.! !


!Die methodsFor: 'initialization' stamp: 'Anonymous 10/21/2018 18:02'!
initialize
	super initialize.
	faces := 6! !


!Die methodsFor: 'printing' stamp: 'Anonymous 10/21/2018 18:06'!
printOn: aStream
	aStream nextPutAll: 'D', self faces asString! !


!Die methodsFor: 'accessing' stamp: 'Anonymous 10/21/2018 18:02'!
faces
	^ faces! !

!Die methodsFor: 'accessing' stamp: 'Anonymous 10/21/2018 18:02'!
faces: number
	faces := number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Die class
	instanceVariableNames: ''!

!Die class methodsFor: 'instance creation' stamp: 'Anonymous 10/21/2018 18:07'!
withFaces: aNumber
	^ Die new faces: aNumber.! !


TestCase subclass: #DieTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dice'!
!DieTest commentStamp: '<historical>' prior: 0!
omg!


!DieTest methodsFor: 'tests' stamp: 'Anonymous 10/22/2018 18:06'!
testRollDie
	| die roll |
	1 to: 10 do: [ :i | 
		die := Die withFaces: i.
		1 to: 100 do: [ :j | 
			roll := die roll.
			self assert: roll >= 1 & (roll <= die faces) ] ]! !

!DieTest methodsFor: 'tests' stamp: 'Anonymous 10/21/2018 18:12'!
testDefaultFacesValue
	| die |
	die := Die new.
	self assert: die faces equals: 6.
	! !

!DieTest methodsFor: 'tests' stamp: 'Anonymous 10/21/2018 18:13'!
testFacesValueSetter
	| die |
	die := Die new.
	self assert: die faces equals: 6.
	
	die faces: 3.
	self assert: die faces equals: 3.
	
	die faces: 10.
		self assert: die faces equals: 10.! !

!DieTest methodsFor: 'tests' stamp: 'Anonymous 10/21/2018 18:38'!
testPrint
	| die |
	die := Die withFaces: 1.
	self assert: die asString equals: 'D1'.
	die faces: 2.
	self assert: die asString equals: 'D2'.
	die faces: 3.
	self assert: die asString equals: 'D3'.
	die faces: 4.
	self assert: die asString equals: 'D4'.
	die faces: 5.
	self assert: die asString equals: 'D5'.
	die faces: 6.
	self assert: die asString equals: 'D6'! !

!DieTest methodsFor: 'tests' stamp: 'Anonymous 10/21/2018 18:14'!
testFacesValueWithFaces
	| die |
	die := Die withFaces: 7.
	self assert: die faces equals: 7.
	die := Die withFaces: 17.
	self assert: die faces equals: 17.! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.649206 pm'!

!IntegerTest methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 18:00'!
testD4Method
	self assert: 1 D4 equals: (DiceBag new addDie: (Die withFaces: 4)).
	self
		assert: 2 D4
		equals:
			(DiceBag new
				addDie: (Die withFaces: 4);
				addDie: (Die withFaces: 4)).
	self
		assert: 3 D4
		equals:
			(DiceBag new
				addDie: (Die withFaces: 4);
				addDie: (Die withFaces: 4);
				addDie: (Die withFaces: 4))! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.653206 pm'!

!IntegerTest methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 18:01'!
testDMethod
	self assert: (1 D: 4) equals: (DiceBag new addDie: (Die withFaces: 4)).
	self assert: (1 D: 5) equals: (DiceBag new addDie: (Die withFaces: 5)).
	self assert: (1 D: 6) equals: (DiceBag new addDie: (Die withFaces: 6)).
	self assert: (2 D: 7) equals: (DiceBag new addDie: (Die withFaces: 7); addDie: (Die withFaces: 7)).! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.653206 pm'!

!Integer methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 17:54'!
D10
	^ self D: 10! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.654206 pm'!

!Integer methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 17:53'!
D: aNumber
	| bag |
	bag := DiceBag new.
	1 to: self do: [ :i | bag addDie: (Die withFaces: aNumber) ].
	^ bag! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.655206 pm'!

!Integer methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 17:54'!
D20
	^ self D: 20! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.655206 pm'!

!Integer methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 17:54'!
D6
	^ self D: 6! !
'From Pharo6.0 of 13 May 2016 [Latest update: #60546] on 23 October 2018 at 6:12:37.656206 pm'!

!Integer methodsFor: '*Dice' stamp: 'Anonymous 10/23/2018 17:53'!
D4
	^ self D: 4! !
