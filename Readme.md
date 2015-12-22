# Simple demo of Redux for iOS

This app demonstrates how Redux concepts can be used in an iOS app


## One app state

There is only one state for the whole app.
App state is kept in the Store. 
The state can be be changed form anywhere and will update the any UI that subscribed to reflect the current app state.
Action are used to transfer the app state to a new state. 
Listeners get updated whenever the app state changes. 
Reducers are used for state transfer. Reducers are can be composed. 

## Unidirectional data flow

Data flows from in one direction. When the UI changes it sends an action to the store via a dispatch method.
The app state gets transferred into a new state by calling the app reducer which then calles various reducers and composes the new app state.
After a state change all listeneres get notified. A view controller would for example subscribe to state changes and it's update method gets called which in turn updates the whole UI (or View Model if MVVM is used)

![Redux flow in iOS](https://raw.githubusercontent.com/armin/Redux-iOS/master/doc/Redux-iOS%20flow.png)

1. An Action is created and dispatched to the Store. Actions may be created by view controllers, data sources anything that wants to change the state of the app.
2. The Store invokes the app Reducer with it’s current state and the Action.
3. The app Reducer calls other reducers to handle the Action.
4. The other Reducers return their state change.
5. The app Reducer combines the states from all reducers into a new state and the Store updates the App State.
6. The Store notifies all Subscribers about the new App State. Subscribers will most likely be View Controllers who then update their views to reflect the new App State.
7. View controllers may create a new Action to reflect any user interaction and calls dispatch on the Store. Other objects may also creata action e.g. a data sources may create an action. Data received on a web socket could also trigger the creation of an Action to reflect changes. 

And the cycle repeats.

##Sample 

The sample app has a settings view controller. The user can toggle facebook on that screen which will call a toggle action.
To demonstrate the power of Redux another screen has a button which calls the same dispatch action to toggle facebook. When we to the the settings screen the switch is already correct and updated - nice.

