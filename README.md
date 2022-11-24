# Fish-Species

This project was developed in MVVM architecture 

This project loads the data from the API `https://www.fishwatch.gov/api/species`

### Minimum iOS vevrsion Supported

iOS 13

### Devices Supported
  iPhone

### 3rd Party Dependency
`https://github.com/SDWebImage/SDWebImage`
This library provides an async image downloader with cache support. For convenience, we added categories for UI elements like `UIImageView`

### Concepts Covered 
1. MVVM
2. SOLID principles
3. Secutiy measures - Jail break detection
  Jail break detection code added as a extension of `UIDevice`. To test the Jail break detection code go to `CommonExtensions.swift` file and `return TRUE` in that method. To test in simulator comment out the line `if UIDevice.current.isSimulator { return false }`. Now if you run the app, you will see alert without okay button.
  
 Logic used to detect device is JailBroken
 1. Jail broken app like Cydia app is installed in Device or not
 2. Able to open/write system related file or not


### System Requirement
 1. mac OS Monterey
 2. XCode 13

### Upcoming improvements
 1. Snapshot for UI testing 
 2. Creating seperate package/pof for maintaining UI components and networking
 3. Maintain screen navigation in one place (coodinator pattern)
