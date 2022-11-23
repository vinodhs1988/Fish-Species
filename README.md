# Fish-Species

This project was developed in MVVM architecture 

This project loads the data from the API `https://www.fishwatch.gov/api/species`

### Minimum iOS vevrsion Supported

iOS 13

### Devices Supported
1. iPhone
2. iPad

### Concepts Covered 
1. MVVM
2. SOLID principles
3. Secutiy measures - Jail break detection
  Jail break detection code added as a extension of `UIDevice`. To test the Jail break detection code go to `CommonExtensions.swift` file and `return TRUE` in that method. Now if you run the app, you will see alert without okay button.
  
 Logic used to detect device is JailBroken
 1. Jail broken app like Cydia app is installed in Device or not
 2. Able to open/write system related file or not


### System Requirement
 1. mac OS Monterey
 2. XCode 13
