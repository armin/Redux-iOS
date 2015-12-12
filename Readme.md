# Simple demo of Redux for iOS

This app demonstrates how the app stae is managed.

The state can be be changed form anywhere and will update the any UI that subscribed to reflect the current app state.

## One app state

There is only one state for the whole app.
App state is kept in the Store. 
Action are used to transfer the app state to a new state. 
Listeners get updated whenever the app state changes. 
Reducers are used for state transfer. Reducers are can be composed. 

## Unidirectional data flow

Data flows from in one direction. When the UI changes it sends an action to the store via a dispatch method.
The app state gets transferred into a new state by calling the app reducer which then calles various reducers and composes the new app state.
After a state change all listeneres get notified. A view controller would for example subscribe to state changes and it's update method gets called which in turn updates the whole UI (or View Model if MVVM is used)

##Sample 

The sample app has a settings view controller. The user can toggle facebook on that screen which will call a toggle action.
To demonstrate the power of Redux another screen has a button which calls the same dispatch action to toggle facebook. When we to the the settings screen the switch is already correct and updated - nice.

