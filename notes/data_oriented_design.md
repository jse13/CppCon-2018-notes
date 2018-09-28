# Data-Oriented Design

### What is wrong with OOP?
- Inheritance hierarchy can become messy
- Marries operations with the data
- Object is sued in vastly different contexts
- Hides state all over the place
- Impact on
    - Performance
    - Scalability
    - Modifiability
    - Testability

### Data Oriented Design
- Separate data from logic
- Logic doesn't try to hide the data
- Avoid virtual calls
- Avoids hidden states
- Promotes domain knowledge: have to know your data, the problem you're solving, and your system to utilize DOD.