Check out the mockup here: https://invis.io/6T68J2EUR

## Inspiration

Here at Stereonography we wanted more than just a social media network. We believe in hiding your deepest secrets in plain sight where no one will think to look. With decreasing security in mobile phones, we decided it was time to build ourselves some protection.

## What it does

Our mobile application takes an image, video, or audio recording and uses stenography to encrypt a message into the byte code of the given file. Once a file has been encrypted you chose how you chose how you send it (i.e. Facebook, email, Twitter). Once received the recipient can use our app to decrypt the file. If I were in desperate need to send my mother my credit card number, I would simply enter the credit card number, snap a picture, enter a security question and voila, my mom has a beautiful selfie of me with my banking information encrypted inside of it. 

## How we built it

Our mobile application was built using Xcode, in objective C and Swift 2. To create the encryption we broke down the byte code of a file and by studying the data structure we were able to alter the least significant bits to have our encoded message without juristically changing the file. This is very advantageous for privacy as it is just an image being sent over a common medium such as Facebook. Unless specifically told that an image was encrypted they would not be able to tell that there was a secret message travelling through in plain site. 

## Challenges we ran into

We originally started working with jpeg format however this was difficult due to the header and footer in the byte code of the file. We quickly created a pivot and continued on the right path.

## Accomplishments that we're proud of

- We successfully encrypted a text with in an image.
- Created a UI.

## What we learned
- Learned a lot about stenography and encryption.
- How to use xcode.
- How to use git work flows.
- How to create a user flow.
- How to create a story board flow.

## What's next for Stereonography

- We all agree that we would like to come to more hackathons and increase our knowledge in our fields.
