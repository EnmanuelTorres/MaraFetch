### Focus Areas
I prioritized the data layer and compliance with the solid principles.

### Time Spent
I spent around 6 and a half hours.

### Trade-offs and Decisions
To improve modularity and testability, I designed the URLSessionHTTPClient class to conform to two distinct protocols. This approach minimizes reliance on URLSession.shared, avoiding the use of singletons, and instead emphasizes the delegation pattern. By doing so, the implementation becomes more flexible, allowing for better dependency injection, enhanced unit testing capabilities, and improved separation of concerns.

### Weakest Part of the Project
I think that I could have improved my views, making them more attractive.

### Demo
![Video (2)](https://github.com/user-attachments/assets/9e36a030-769d-429e-9bec-24b1e9bce690)

Picture 1 | Picture 2 | Picture 3 |
-------|--------|--------|
![p1](https://github.com/user-attachments/assets/22d153a3-0c9e-49f9-84a3-0f734901f752)|![p2](https://github.com/user-attachments/assets/28869056-67ef-4839-a5eb-9866a4c87b23)|![p3](https://github.com/user-attachments/assets/93bc3640-9a45-48cc-af5b-019a52b14adc)
