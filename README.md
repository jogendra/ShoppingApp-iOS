# Shopping App

## Functionality of the App

Here is the  fully functional Shopping App which has three screens:
- **Products List**: Displays the list of Products fetched from mock API (given in README). Clicking on any item in list, take you to the Product Details screen.
At the bottom, it has a button that shows the total number of items in the shopping cart and the total amount value of the products in shopping, at the time. Tapping on the button takes you to the Shopping Cart screen. The button doesn't do anything if the shopping cart is empty.

- **Product Details**: The screen displays the details of the selected product. The navigation back button can be used to go back to the previous screen. 
At the bottom, it has increment and decrement products in cart buttons. The number of specific product in the cart is already prefilled if the item is already in the cart before. 
On clicking "_Update Cart_" button, it updates the item count (of product) in the cart (in CoreData) and dismisses the screen.

- **Shopping Cart**: Displays the list of products in the Shopping cart. It fetches a list from CoreData. Tapping on on any product from list will take you to Product Details screen with preselected product count, count can be updated there. Once you are back on the screen, it reflect the latest changes.
At botton, it has a label and a button. The label displays the total items count in the cart and value of items in the cart. The "_Checkout_" button can be used to check out current cart. Clicking it would display a alert with confirmation, also resets everything in the cart. Dismissing alert would take you back to Product List screen.

Please refer to demo (screen recording) and screenshots below.

## Demo

Please refer to demo on YouTube using link (unlisted video): https://youtu.be/jnL-8Xn31vs

## Screenshots:

<table>
<tr>
<td>
<img src="https://user-images.githubusercontent.com/20956124/226170488-3d28ff12-cecd-47a5-a3c8-ca6f084cfd6a.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/20956124/226170516-8f350b83-33ce-42a0-8e01-e46785fd4c4c.png">
</td>
</tr>
<tr>
<td>
<img src="https://user-images.githubusercontent.com/20956124/226170644-a98c9ca0-4f68-445f-b1d9-818b6c0a1be6.png">
</td>
<td>
<img src="https://user-images.githubusercontent.com/20956124/226170646-1a26ecfe-1ae1-436b-baac-ffcc78719dc9.png">
</td>
</tr>
</table>

## Technical Implementation

Here is few technical decisions I made while building this application.
- **MVVM Design Pattern**: MVVM is a good choice for this app because it provides a clear separation of concerns, makes maintaining the app codebase easier, and allows for code reusability. Separating screen from the logics such as getting product list from API endpoint, fetching shopping cart from CoreData, updating cart, enabling/disabling buttons etc, makes Controllers clean and ViewModels testable. And it's easy to change logics on screens without affecting controllers. 
Also, one of the major reason I went for MVVM design pattern because I am most confotable with it. I believe MVVM works quite good for UI/UX intesive projects.

- **Core Data**: I had couple of options to store shopping cart items, UserDefaults, CoreData, writing data to filesystem (no one do that :p). Between UseDefaults and CoreData, I choose CoreData because we need to store product list and for storing objects, CoreData works best. It can be ofcouse achievable with UserDefaults, but require encoding and decoding everytime when we update or fetch, which makes it slow when comes to performance, specially when data is large. On the other hand, Core Data is optimized for performance, and can handle large amounts of data efficiently.
In case out Product data get complicated (relationship with different data), CoreData would manage it greatly. UserDefaults is great for lightweight data but here, CoreData is better choice.

- **Using UI in Code instead of Storyboard**:  Writing UI in code makes it easy to customize, manage, reusable and so on. I created few reusable UI components which can be used over and over across the app. Also, make it easy to implement custom design system and consistency across the project. 

- **Moduler Approach**: The project constains two modules, `AppCoreUI` and `AppDataSource`. 
`AppCoreUI` contails all the reusable UI components, UIKit extensions and some helper classes. Everything related to UI, goes here.
`AppDataSource` contains Remote Data source which is responsible for remote API callings and Core Data source which is resposible for storing Shopping Cart data. Everything related to Data goes here, Models, DTOs, Mappers etc. Repositories makes it nice to use remote data and core data.
`AppCoreUI` and `AppDataSource`, both has their own Unit Tests.

## Scope of Improvements

Few things I feel can be improved:
- **Catching Images**: We fetch a lot of images from remote, list can grows bigger, so having fetched images catched would make app experience smoother and nice.
- **Utility for managing Constrains**: Currently, we are using NSLayoutConstrains for UI components, which produce a lot fo code in the controller. This can be minimized using some utility class which manage constrains. Also, help in saving some time. I am more used to use `SnapKit` and have less used to with writing own constraints.

Feel free to get in touch with at [jogendra.dev](https://jogendra.dev/)
