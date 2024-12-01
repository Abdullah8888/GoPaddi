# ``GoPaddi``

An intuitive flight booking app that lets you search, view all planned 
trips, and book flights seamlessly.


## How to run the project

Open the project via xcode after cloning the project. 

Note: If you are get "Unknow error". it means you will have to change the baseUrl


### Steps to change the base URL
- Visit https://beeceptor.com/crud-api/  to generate a new base Url for api/trip, make sure it ends with api/trip
- Go to the Constant.swift, then replace the old baseUrl with the new baseUrl

- Run the project again. (You shouldn't see any error and you should be able to create a plan which wull be automatilly reflect on the Trip landing page)


### Techniques and patterns used
- MVVM with clean architecture concept
- Coordinator pattern
- DI

### External Packages used and patterns used
- Swinject
- FSCalendar
- Toast
