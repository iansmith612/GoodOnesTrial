# GoodOnesTrial
Take home front end project for GoodOnes

## Approach
For this project, I wanted to emulate Tinder's swipe and 'like' functionality for photos that the user uploads. Upon first entering the app, the user will click the plus button to upload photos from their photo library to the app. Then the user will swipe through the photos giving each photo a status of either 'like' or 'dislike.' Once the user has swiped through all of the uploaded photos, they can then press the collection button in the upper left hand corner to view their liked photos so far.

## Methods Part 1

### Front End
The basic front end elements of the app are icons with a few mixing colors to give a subtle glow to buttons with a pleasing color scheme. When the user uploads the photos, the photo will be an element covering most of the screen so the user has a full view of the photo. When the user swipes on a photo, the changing x coordinate of the image will trigger a green checkmark or red cancel symbol to appear on the image and once the x coordinate has passed a certain threshold the photo will be removed from the stack and stored in the liked array if the user swiped right. To make the swipes engaging, the card element has an animation with slight bounces giving it a simulated elastic feel that the user should enjoy. When the user wishes to view their current collection, a new sheet will appear displaying their saved photos. The user can scroll through the stored photos.

### Uploading Images
In order to implement a photo selection functionality, I used PhotosUI and UIViewControllerRepresentable. This allowed me to interact with PHPickerViewController and then display the uploaded images as PhotoPickerModels in a ZStack. Due to PHPicker constraints, this app must be ran on ***iOS 14 or later.*** While I did not include the functionality because it wasn't part of the requirements, I did lay down a skeleton for adding live photos and videos in the future.

### Storing the images
I used a @Binding on an array of PhotoPickerModels and displayed the array on a toggled sheet when the user presses the collection button. Unfortunately, due to time constraints and limited swiftUI experience, I was not able to persist the data between app uses. UserDefaults or @AppStorage could not possibly handle the complexity of storing structs with UIImage properties. The next possible item was using Core Data which could potentially store UIImages as Binary Data or Transformables, but after completing the project to the best of my ability Monday evening at 7:15pm, I knew I would not have time to get it in for consideration for a Monday cooldown. Given enough time, I am positive I would be able to complete it.

## Part 2 and Part 3
My efforts were focused largely on making the app look as good and as clean as possible and I did not have time to add the Google API functionality. I did add a button for Google, but it is a placeholder for future functionality.

## Closing Notes
1. It's worth noting that during use of this app through a simulated iPhone, when uploading defaule stock images, there was an image of a rose bush that would not upload. I could not find any discernible reason why as Xcode simply said that the image cannot open. The other default stock images could be selected and uploaded without any issue.
2. Due to unfortunated personal reasons, I was only able to work on this project for around 8 hours trying to navigate work and relationships. While I do not have any professional experience in SwiftUI, I do like to develop mobile apps as side projects and do have professional front end web development experience. I appreciate the opportunity to apply for this job and I hope you will keep me in consideration.
