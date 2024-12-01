# ``GoPaddi``

An intuitive flight booking app that lets you search, view all planned 
trips, and book flights seamlessly.

<p>
    <img src="https://github.com/accelerex-developer/RexPayiOS/blob/main/RexpaySDK/ReadmeFiles/landing_page.png" width="200px" height="auto" hspace="20"/>

</p>

[Click here to download the recorder video](https://github.com)

## How to run the project

Open the project via xcode after cloning it. 

Note: If you encounter an 'Unknown error,' it means you need to change the baseUrl.


### Steps to Change the Base URL
- Visit https://beeceptor.com/crud-api/  to generate a new base Url for api/trip, make sure it ends with api/trip.
- Open Constant.swift in the project and replace the old baseUrl with the new one.

- Run the project again. You should no longer see any errors, and you should be able to create a trip that will automatically reflect on the Trip landing page.


### Techniques and patterns used
- MVVM with clean architecture concept
- Coordinator pattern
- DI

### External Packages used
- Swinject
- FSCalendar
- Toast
