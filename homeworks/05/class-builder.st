Object subclass: #CBClassBuilder
	instanceVariableNames: 'className packageName superClass variables methods classSideMethods'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ClassBuilder'!

!CBClassBuilder methodsFor: 'accessing' stamp: 'Adam 1/5/2019 23:26'!
build
	| variableNames instance |
	variableNames := ''.
	variables do: [ :x | variableNames := variableNames , x name , ' ' ].

	instance := superClass
		subclass: className asSymbol
		instanceVariableNames: variableNames
		classVariableNames: ''
		package: packageName.

	methods do: [ :x | instance compile: x ].
	classSideMethods do: [ :x | instance class compile: x ].

	variables
		do: [ :x | 
			x getWithGetter
				ifTrue: [ instance compile: x name , String cr , '^ ' , x name ].
			x getWithSetter
				ifTrue: [ instance compile: x name , ': aValue' , String cr , x name , ' := aValue' ].
			x getWithValueReset
				ifTrue: [ instance compile: 'reset' , x name capitalized , String cr , x name , ' := ' , x defaultValue asString ] ].

	instance compile: self buildInitialize.
	instance compile: self buildPrint! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Adam 1/5/2019 22:10'!
initialize
	variables := OrderedCollection new.
	methods := OrderedCollection new.
	classSideMethods := OrderedCollection new.
	superClass := Object! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 20:04'!
addString: aName
	| instance |
	instance := StringValueBuilder new name: aName.
	variables add: instance.
	^ instance! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 18:48'!
className: aString
	className := aString! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 20:04'!
addArray: aName
	| instance |
	instance := ArrayValueBuilder new name: aName.
	variables add: instance.
	^ instance! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 18:50'!
superClass: aClass
	superClass := aClass! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 20:27'!
addClassSideMethod: aCode
	classSideMethods add: aCode! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Adam 1/5/2019 22:59'!
buildPrint
	| result |
	result := 'printOn: aStream', String cr.
	result := result , 'super printOn: aStream.', String cr.
	variables do: [ :x | result := result , x buildPrint ].
	result := result , ' ^ aStream'.
	^ result! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 20:26'!
addMethod: aCode
	methods add: aCode.

	! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Adam 1/5/2019 23:03'!
buildInitialize
	| result |
	result := 'initialize' , String cr.
	variables do: [ :x | result := result , x buildInitialize ].
	^ result
! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 20:04'!
addInteger: aName
	| instance |
	instance := IntegerValueBuilder new name: aName.
	variables add: instance.
	^ instance! !

!CBClassBuilder methodsFor: 'accessing' stamp: 'Anonymous 1/5/2019 18:49'!
packageName: aString
	packageName := aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

CBClassBuilder class
	instanceVariableNames: ''!

!CBClassBuilder class methodsFor: 'as yet unclassified' stamp: 'Anonymous 1/5/2019 20:22'!
forClassNamed: aClass inPackage: aPackage
	| instance |
	instance := self new.
	instance className: aClass.
	instance packageName: aPackage.
	^ instance! !


Object subclass: #ValueBuilder
	instanceVariableNames: 'varShownByPrinting varWithSetter varWithGetter varWithValueReset varWithDefaultValue name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ClassBuilder'!

!ValueBuilder methodsFor: 'initialization' stamp: 'Adam 1/5/2019 23:30'!
buildInitialize
	varWithDefaultValue
		ifFalse: [ ^ '' ].
	^ name , ' := ' , self defaultValue asString , '.', String cr! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:21'!
withValueReset
	varWithValueReset := true! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:20'!
withGetter
	varWithGetter := true! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 20:52'!
getWithAccessors
	^ varWithGetter and: varWithSetter ! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 20:53'!
getShownByPrinting
	^ varShownByPrinting! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:34'!
name
	^ name! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:20'!
withDefaultValue
	varWithDefaultValue := true! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:22'!
getWithSetter
	^ varWithSetter! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:35'!
name: aName
	name := aName! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:22'!
getWithDefaultValue
	^ varWithDefaultValue! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:26'!
defaultValue
	^ self subclassResponsibility ! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 20:52'!
withAccessors
	varWithGetter  := true.
	varWithSetter := true.! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Adam 1/5/2019 23:01'!
buildPrint
	varShownByPrinting ifFalse: [ ^ '' ].
	^ 'aStream nextPutAll: '' ('',' , name , ' asString,'')''.' , String cr! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:20'!
withSetter
	varWithSetter := true! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:22'!
getWithGetter
	^ varWithGetter! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:22'!
getWithValueReset
	^ varWithValueReset! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 20:53'!
initialize
	varShownByPrinting := false.
	varWithDefaultValue := false.
	varWithGetter := false.
	varWithSetter := false.
	varWithValueReset := false! !

!ValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:19'!
shownByPrinting
	varShownByPrinting := true! !


ValueBuilder subclass: #ArrayValueBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ClassBuilder'!

!ArrayValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:29'!
defaultValue
	^ Array new! !


ValueBuilder subclass: #IntegerValueBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ClassBuilder'!

!IntegerValueBuilder methodsFor: 'initialization' stamp: 'Anonymous 1/5/2019 19:29'!
defaultValue
	^ 0! !


ValueBuilder subclass: #StringValueBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ClassBuilder'!

!StringValueBuilder methodsFor: 'initialization' stamp: 'Adam 1/5/2019 21:56'!
defaultValue
	^ ''''''! !
