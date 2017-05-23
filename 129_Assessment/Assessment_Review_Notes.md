# Assessment Review Notes
### Benefits of Object Oriented Programming in Ruby
1. Creating objects allow programmers to think more abstractly about the code they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose funtionality to the parts of code that need it, meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an application without duplication.
5. We can build applications faster as we can reuse pre-written code.
6. As the softare becomes more complex this complexity can be more easily managed.

### States and Behaviors
States track atributes for individual objects. __Instance variables__ are scoped at the object (or instance) level, and are how objects keep track of their state.

Behaviors are what objects are capable of doing. __Instance methods__ defined in a class are available to objects (or instances) of that class and define its behaviors.

#### General Approach to Class Methodology (& CRC Cards)
In general, here is the approach:
1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a spike to explore the problem with temporary code.
3. When you have a better idea of the problem, model your thoughts into CRC cards.
***
CRC - Class Responsibility Collaborator

#### Example: Guess Who?
1. Guess Who is a 2 player game where each player tries to determine the other player's secret person. Each player has access to an identical list of people and their physical features. Players take turns narrowing down the possibilities by asking the other player a question regarding a physical feature. At anytime a player may guess the person's name and, if correct, the player wins.
2. Nouns and Verbs
    * Nouns: player, list, secret person, features, question, guess
    * Verbs: ask, guess
3. Guess at Organization
    * Player
      * ask
      * guess
    * List
4. A player will have a secret_person. A List can be used as a collaborator object for each person.
