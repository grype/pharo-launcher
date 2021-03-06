Class {
	#name : #PhLLaunchImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imageDir'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLLaunchImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new.
	imageDir := FileLocator temp / 'pharo-launcher-tests-launch-image-command' , UUIDGenerator next asString.
	imageDir ensureCreateDirectory
]

{ #category : #running }
PhLLaunchImageCommandTest >> tearDown [ 
	imageDir ensureDeleteAll
]

{ #category : #tests }
PhLLaunchImageCommandTest >> testCanLaunchImage [
	| command image |
	command := PhLLaunchImageCommand new.
	command context: presenter.
	FileLocator image copyTo: imageDir / FileLocator image basename.
	image := PhLImage location: imageDir / FileLocator image basename.
	image versionFile 
		writeStreamDo: [ :stream | 
			SystemVersion current major asString putOn: stream.
			SystemVersion current minor asString putOn: stream ].
	presenter selection: image.

	command execute.
	
	"we run the image <<unwatch>>. That means we do not have a way to ask information to the process"
	"how to assert the image is run? how to close it?"
]
